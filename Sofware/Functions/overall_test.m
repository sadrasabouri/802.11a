function overall_test()
%   This function could be use for testing the perfomance of block (CI)

%   1.  Divide and Combine functions
fprintf('Divide and Combine function:\n');
b = [0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1]
B_s1 = Divide(b);
b1 = B_s1{1,1}
b2 = B_s1{1,2}
b_ = Combine_(b1, b2)
fprintf('IS CORRECT:\n');
b_ == b
fprintf('********************************\n')
b = b'
B_s2 = Divide(b);
b1 = B_s2{1,1}
b2 = B_s2{1,2}
b_ = Combine_(b1, b2)
fprintf('IS CORRECT:\n')
b_ == b

fprintf('==================================================================\n')
%   2.  PulseShaping function
fprintf('PulseShaping function:\n');
b = [0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1]
z_s = [-1, -2, -1]
o_s = [1, 2, 1]
out_b = PulseShaping(b, z_s, o_s)

fprintf('==================================================================\n')
%   3.  AnalogMod function
fprintf('AnalogMod function:\n');
b1 = [0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 0, 1]
b2 = [1, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0]
f_s = 1000000   %   f_s = 1MHz
f_c = 100000    %   f_c = 100KHz
x_c = AnalogMod(b1, b2, f_s, f_c)

fprintf('==================================================================\n')
%   4.  Channel function
fprintf('Channel function:\n');
f_s = 1000;
f_c = 1;
Ts = 1 / f_s;
t = 0:Ts:1000*Ts;
x = 2*cos(2*pi*f_c*t) + 0.9*cos(2*pi*10*f_c*t) - 0.01*cos(2*pi*100*f_c*t);
x_o = Channel(x, f_s, f_c, f_c);
figure;
plot(t, x, t, x_o);
title('Channel function Test.');

fprintf('==================================================================\n')
%   5.  AnalogDemod function
y_s = AnalogDemod(x, f_s, 2*f_c, f_c);
fprintf('AnalogDemod function:\n');
y1 = y_s{1};
y2 = y_s{2};
figure;
plot(t, x, t, y1, t, y2);
title('AnalogDemod function Test.');
