cd ../functions
NUMBER_OF_BITS = 256;

%   Transferring Configuration
f_s = 1000000;
T_p = 0.01;
f_c = 1000;
f_m = 1000;
BW = 1000;

%   Pulse Shaping Configuration
T_Domain = 0:1/f_s:T_p;
pulse_0 = -1 * sin(2*pi*500*T_Domain); 
pulse_1 =  1 * sin(2*pi*500*T_Domain);

%   Input Random Bit Sequence:
b = double(rand(1, NUMBER_OF_BITS) > 0.5)

%   Communication System:
b_s = Divide(b);
b_1 = b_s{1};
b_2 = b_s{2};

x_1 = PulseShaping(b_1, pulse_0, pulse_1);
x_2 = PulseShaping(b_2, pulse_0, pulse_1);

x_c = AnalogMod(x_1, x_2, f_s, f_c);

%   Noise Addition
noise_var = double([-100, -80, -60, -40, -20, 0]);
N0 = 4.143 * 10^(-21);

figure;

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
    bh = Combine_(out1{3}, out2{3})
    
    %   Streching to (-1,1)^2
    bh1 = -1 .* (out1{3} == 0) .* out1{1};
    bh1 = bh1 + (out1{3} == 1) .* out1{2};
    
    bh2 = -1 .* (out2{3} == 0) .* out2{1};
    bh2 = bh2 + (out2{3} == 1) .* out2{2};
    
    subplot(3, 2, i);
    scatter(bh1, bh2, 'filled');
    line([0,0], ylim);
    line(xlim, [0,0]);
    title(['Var_n_o_i_s_e = 10^{', num2str(-1*var), '}']);
    i = i + 1;
end

cd ../3.Transferring0and1
