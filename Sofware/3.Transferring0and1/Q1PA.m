cd ../functions
NUMBER_OF_BITS = 32;

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
b = double(rand(1, NUMBER_OF_BITS) > 0.5)

%   Communication System:
b_s = Divide(b);
b_1 = b_s{1};
b_2 = b_s{2};

x_1 = PulseShaping(b_1, pulse_0, pulse_1);
x_2 = PulseShaping(b_2, pulse_0, pulse_1);

x_c = AnalogMod(x_1, x_2, f_s, f_c);

y = Channel(x_c, f_s, f_m, BW);

y_s = AnalogDemod(y, f_s, BW, f_c);
y_1 = y_s{1};
y_2 = y_s{2};

out1 = MatchedFilt(y_1, pulse_0, pulse_1);
b_1h = out1{3};
out2 = MatchedFilt(y_2, pulse_0, pulse_1);
b_2h = out2{3};

bh = Combine_(b_1h, b_2h)

cd ../3.Transferring0and1

disp('Plotting Proecess Started...');
%   Plotting the Result
figure;
suptitle('Question 1 - Part A');
T = linspace(0, T_p * (NUMBER_OF_BITS / 2), max(size(x_c)));

subplot(4, 3, 1);
bar(b);
title('b[n]');

subplot(4, 3, 2);
bar(b_1);
title('b_1[n]');

subplot(4, 3, 3);
bar(b_2);
title('b_2[n]');



subplot(4, 3, 4);
plot(T, x_c);
title('x_c(t)');

subplot(4, 3, 5);
plot(T, x_1);
title('x_1(t)');

subplot(4, 3, 6);
plot(T, x_2);
title('x_2(t)');



subplot(4, 3, 7);
plot(T, y);
title('y(t)');

subplot(4, 3, 8);
plot(T, y_1);
title('y_1(t)');

subplot(4, 3, 9);
plot(T, y_2);
title('y_2(t)');



subplot(4, 3, 10);
bar(bh);
title('b_h[n]');

subplot(4, 3, 11);
bar(b_1h);
title('b_h_1[n]');

subplot(4, 3, 12);
bar(b_2h);
title('b_h_2[n]');
