function B_s = Divide(b)
% DIVIDE   Input b vector and divide it into two subvectors one containing odd
%          index values while the other one contains even index one
%   b : input bit sequence
%   B_s : a two cell array containing output bit sequences

b1 = b(1:2:end);    %   odd index  --> b1
b2 = b(2:2:end);    %   even index --> b2

B_s = {b1, b2};
