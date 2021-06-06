function out = MatchedFilt(y, zero_seq, one_seq)
% MATCHEDFILT   Make bit sequence a from analog pulse
%   y : input bit analog signal
%   zero_seq: analog sequence corresponding to 0
%   one_seq : analog sequence corresponding to 1
%   out : output which is a 3 cell array containing
%          1. value of zero correlation
%          2. value of one correlation
%          3. bit sequence


bit_samplesize = max(size(zero_seq));
extra_size = bit_samplesize; 
extra_size = extra_size - mod(max(size(y)), bit_samplesize);
if extra_size < bit_samplesize
    y = [y, zeros(1, extra_size)];          %   Zero adding for alignment
end

y_trunc = reshape(y', bit_samplesize, [])'; %   a row for each bit
zero_cor = xcorr2(y_trunc, zero_seq); 
one_cor = xcorr2(y_trunc, one_seq);

cor0 = zero_cor(:, int16(end / 2)) / bit_samplesize;
cor1 = one_cor(:, int16(end / 2)) / bit_samplesize;

output_bit = double(cor1 > cor0);   %   detection using correlation
output_bit = output_bit';

out = {cor0', cor1', output_bit};
