cd ../functions
NUMBER_OF_BITS = 128;

%   Transferring Configuration
f_s = 1000000;
T_p = 0.01;
f_c = 1000;
f_m = 1000;
BW = 1000;

%   Pulse Shaping Configuration
pulse_0 = -1 * ones(1, T_p * f_s); 
pulse_1 =  1 * ones(1, T_p * f_s);

%   Input Random Bit Sequence:
b = double(rand(1, NUMBER_OF_BITS) > 0.5);

%   Communication System:
b_s = Divide(b);
b_1 = b_s{1};
b_2 = b_s{2};

x_1 = PulseShaping(b_1, pulse_0, pulse_1);
x_2 = PulseShaping(b_2, pulse_0, pulse_1);

x_c = AnalogMod(x_1, x_2, f_s, f_c);

%   Noise Addition
noise_var = logspace(-70, -49, 22);
error = zeros(size(noise_var));
N0 = 4.143 * 10^(-21);

i = 1;
for var = noise_var
    y = Channel(x_c, f_s, f_m, BW);
    SNR = log10(var / (N0/2))
    y = awgn(y, SNR);
    
    y_s = AnalogDemod(y, f_s, BW, f_c);
    y_1 = y_s{1};
    y_2 = y_s{2};
    
    out1 = MatchedFilt(y_1, pulse_0, pulse_1);
    out2 = MatchedFilt(y_2, pulse_0, pulse_1);
    
    zero_cor = Combine_(out1{1}, out2{1});
    one_cor = Combine_(out1{2}, out2{2});
    bh = Combine_(out1{3}, out2{3});
    error(1, i) = sum(xor(b, bh)) / NUMBER_OF_BITS
    i = i + 1;
end

cd ../3.Transferring0and1

figure;

plot(-49:-1:-70, error(end:-1:1));
title('Bit Error Probability per WGN Variance')
ylabel('bit error probability')
xlabel('-log10(Var_n_o_i_s_e)')
