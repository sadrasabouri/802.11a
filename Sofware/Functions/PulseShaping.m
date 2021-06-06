function output = PulseShaping(input_b, zero_seq, one_seq)
% PULSESHAPING   Make a analog pulse from input bit sequence
%   input_b : input bit sequence
%   zero_seq : analog sequence corresponding to 0
%   one_seq : analog sequence corresponding to 1
%   output: output signal

if size(zero_seq) ~= size(one_seq)  %   Checking the size of 1 and 0 sequences
    output = 'ERROR: [SIZE MISMATCH]';
    return
end

one_seqs = repmat(one_seq, size(input_b));
zero_seqs = repmat(zero_seq, size(input_b));

%   input bits works as a mask
extended_input = repmat(input_b', size(zero_seq))';
extended_size = size(input_b);
if extended_size(1) > extended_size(2)    %   Vectors were in cols
    extended_size(1) = max(size(zero_seq)) * extended_size(1);
else                        %   Vectors were in rows
    extended_size(2) = max(size(zero_seq)) * extended_size(2);
end
extended_input = reshape(extended_input,  extended_size);
output = extended_input .* one_seqs + (1 - extended_input) .* zero_seqs;
