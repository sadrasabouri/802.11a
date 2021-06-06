function x_o = Channel(x_c, f_s, f_m, BW)
% CHANNEL   Return the Channel effected signal.
%   x_c : channel input signal
%   f_s : sample frequency
%   f_m : middle frequency
%   BW  : BandWidth of channel
%   x_o : channel output signal

L = max(size(x_c));
NFFT = 2 ^ nextpow2(L);     %   Next power of 2 from length of x_c
X_C = fft(x_c, NFFT);       %   Fourier transform of x_c
f = f_s / 2 * linspace(0, 1, NFFT / 2 + 1);

Filter = ones(size(f));
Filter = Filter .* (f < f_m + BW);
Filter = Filter .* (f > f_m - BW);
Filter = [Filter(1:end-1), Filter(end:-1:2)];    %   Symetric Filter

X_O = X_C .* Filter;
x_o = real(ifft(X_O));
x_o = x_o(1:max(size(x_c)));    %   Aligning
