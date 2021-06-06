function bytes = OutputDecoder(bits)
% SOURCEGENERATOR   Input a sequence of bits and transfer them to bytes.
%   bits : Inputted bit sequence
%   bytes : Output byte sequence

bytes = reshape(bits, 8, [])';  %   reshaping to nice form
bytes = bytes(:, end:-1:1);     %   Arragement
bytes = bi2de(bytes);
bytes = bytes';
