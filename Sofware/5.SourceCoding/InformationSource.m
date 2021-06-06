function output = InformationSource(n)
%INFORmATIONSOURCE Return a sequence containing n chars from X
%   n : inputted number of sequence
%   output : output sequnce
%            a      b       c       d       e       f
%   X = 
%           1/2    1/4     1/8     1/16    1/32    1/32

random_vector = int16(rand(1, n) * 31);  %   Uniform = [0, 31]

is_a = random_vector < 16;
is_b = (~is_a).* (random_vector < 24);
is_c = (~is_a).* (~is_b) .* (random_vector < 28);
is_d = or(random_vector == 28, random_vector == 29);
is_e = random_vector == 30;
is_f = random_vector == 31;

output = is_a .* 'a';
output = output + is_b .* 'b';
output = output + is_c .* 'c';
output = output + is_d .* 'd';
output = output + is_e .* 'e';
output = output + is_f .* 'f';

output = char(output);
