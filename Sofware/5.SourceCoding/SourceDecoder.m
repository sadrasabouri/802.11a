function char_seq = SourceDecoder(bit_seq)
%SOURCEDECODER Return a decoded char sequence coded according to the format bellow
%   bit_seq : inputted bit sequnce
%   char_seq : output string sequence
%            a      b       c       d       e       f
%   Coding: 
%            0     10      110     1110   11110    11111

i = 1;
k = 1;
while i <= max(size(bit_seq))
    delta_i = 1;
    tmp = '';
    if bit_seq(i) == 0
        tmp = 'a';
        delta_i = 1;
    else if bit_seq(i+1) == 0
            tmp = 'b';
            delta_i = 2;
        else if bit_seq(i+2) == 0
                tmp = 'c';
                delta_i = 3;
            else if bit_seq(i+3) == 0
                    tmp = 'd';
                    delta_i = 4;
                else if bit_seq(i+4) == 0
                        tmp = 'e';
                    else
                        tmp = 'f';
                    end
                    delta_i = 5;
                end
            end
        end
    end
    char_seq(1, k) = tmp;
    k = k + 1;
    i = i + delta_i;
end

char_seq = char(char_seq);
