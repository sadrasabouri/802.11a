function b = Combine_(b1, b2)
% COMBINE   Input b1 and b2 vectors and combine it into a vector.
%   b1 : bit sequence 1
%   b1 : bit sequence 2
%   b : combined bit sequence

b_size = size(b1);
if b_size(1) > b_size(2)    %   Vectors were in cols
    b_size(1) = 2 * b_size(1);
else                        %   Vectors were in rows
    b_size(2) = 2 * b_size(2);
end

b = zeros(b_size);
b(1:2:end) = b1;
b(2:2:end) = b2;
