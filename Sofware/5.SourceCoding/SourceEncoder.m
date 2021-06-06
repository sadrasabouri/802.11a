function bit_seq = SourceEncoder(n, char_seq)
%SOURCEENCODER Return a coded bit sequence coded according to the format bellow
%   n : number of inputted char
%   string_seq : inputted string sequence
%   bit_seq : output bit sequnce
%            a      b       c       d       e       f
%   Coding: 
%            0     10      110     1110   11110    11111

i = 1;
bit_seq = zeros(1, n);
for char = char_seq
    tmp = [];
    switch char
        case 'a'
            tmp = [0];
        case 'b'
            tmp = [1, 0];
        case 'c'
            tmp = [1, 1, 0];
        case 'd'
            tmp = [1, 1, 1, 0];
        case 'e'
            tmp = [1, 1, 1, 1, 0];
        case 'f'
            tmp = [1, 1, 1, 1, 1];
    end
    bit_seq(1, i:i+max(size(tmp)) - 1) = tmp;   %   appending
    i = i + max(size(tmp));
end
