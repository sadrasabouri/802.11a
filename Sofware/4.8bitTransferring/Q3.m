cd ../functions
NUMBER_OF_BYTES = 64;

%   Transferring Configuration
f_s = 1000000;
T_p = 0.01;
f_c = 1000;
f_m = 1000;
BW = 1000;

%   Pulse Shaping Configuration
pulse_0 = -1 * ones(1, T_p * f_s); 
pulse_1 =  1 * ones(1, T_p * f_s);

%   Input Random Byte Sequence:
B = double(int16(rand(1, NUMBER_OF_BYTES) * 255));
b = SourceGenerator(B);

%   Communication System:
b_s = Divide(b);
b_1 = b_s{1};
b_2 = b_s{2};

x_1 = PulseShaping(b_1, pulse_0, pulse_1);
x_2 = PulseShaping(b_2, pulse_0, pulse_1);

x_c = AnalogMod(x_1, x_2, f_s, f_c);

%   Noise Addition
noise_var = double([-100, -60, -40, 0]);
N0 = 4.143 * 10^(-21);

figure;
suptitle('Error Histogram');

i = 1;
for var = noise_var
    y = Channel(x_c, f_s, f_m, BW);
    SNR = log10(10 ^ var / (N0/2))
    y = awgn(y, SNR);
    
    y_s = AnalogDemod(y, f_s, BW, f_c);
    y_1 = y_s{1};
    y_2 = y_s{2};
    
    out1 = MatchedFilt(y_1, pulse_0, pulse_1);
    out2 = MatchedFilt(y_2, pulse_0, pulse_1);
    
    zero_cor = Combine_(out1{1}, out2{1});
    one_cor = Combine_(out1{2}, out2{2});
    bh = Combine_(out1{3}, out2{3});
    Bh = OutputDecoder(bh)
    
    subplot(2, 2, i);
    hist(B - Bh, 50);   %   Unless they were too sparse
    title(['Var_n_o_i_s_e = 10^{', num2str(-1*var), '}']);
    i = i + 1;
end

cd ../4.8bitTransferring/

