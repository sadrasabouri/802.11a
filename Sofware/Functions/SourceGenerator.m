function bits = SourceGenerator(bytes)
% SOURCEGENERATOR   Input a sequence of bytes(8bits) and transfer them to bits.
%   bytes : Inputted byte sequence
%   bits : Output bit sequence

bits = de2bi(bytes, 8);
bits = bits(:, end:-1:1);    %   Making the Arrangement
bits = reshape(bits', 1, []);
