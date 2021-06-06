function y_s = AnalogDemod(x_c, f_s, BW, f_c)
% ANALOGDEMOD   Demodulate the inputted signal.
%   x_c : channel input signal
%   f_s : sample frequency
%   BW  : BandWidth of channel
%   f_c : carry frequency
%   y_s : a two cell array containing output demodulated signals

T_s = 1 / f_s;
L = max(size(x_c));             %   Number of samples
t = (0 : L - 1) * T_s;

y1 = x_c .* cos(2*pi*f_c*t);    %   Demodule Inphase
y2 = x_c .* sin(2*pi*f_c*t);    %   Demodule Quadrature


NFFT = 2 ^ nextpow2(L);     %   Next power of 2 from length of y
f = f_s / 2 * linspace(0, 1, NFFT / 2 + 1); %   Frequency Domain

Y1 = fft(y1, NFFT);         %   Fourier transform of y1
Y2 = fft(y2, NFFT);         %   Fourier transform of y2

Filter = ones(size(f));
Filter = Filter .* (f < BW);
Filter = [Filter(1:end-1), Filter(end:-1:2)];    %   Symetric Filter

%   LPF
Y1 = Y1 .* Filter;
Y2 = Y2 .* Filter;

y1 = real(ifft(Y1));
y1 = y1(1:max(size(x_c)));
y2 = real(ifft(Y2));
y2 = y2(1:max(size(x_c)));

y_s = {y1, y2};
