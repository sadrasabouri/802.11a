function x_c = AnalogMod(x_1, x_2, f_s, f_c)
% AnalogMod   Return the analog modulated signal.
%   x_1 : input analog signal 1
%   x_2 : input analog signal 2
%   f_s : sample frequency
%   f_c : carry frequency
%   x_c : output analog signal

T_s = 1 / f_s;
L = max(size(x_1)); %   Number of samples
t = (0 : L - 1) * T_s;

%   Inphase and Quadrature modulation
x_c = x_1 .* cos(2*pi*f_c*t) + x_2 .* sin(2*pi*f_c*t);
