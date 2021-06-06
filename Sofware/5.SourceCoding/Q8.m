N = 1:1000; %   Range of n
H = zeros(size(N));
E_l = 1.9375 * ones(size(N));

for n = N
char_seq = InformationSource(n);

bit_seq = SourceEncoder(n, char_seq);

output_seq = SourceDecoder(bit_seq);

h = max(size(bit_seq)) / n

sum(char_seq == output_seq) / n
H(1, n) = h;
end

figure;
plot(N, H, N, E_l);
title('H_n(X)=L_B(n)/n');
xlabel('n');
ylabel('L_B(n)/n');
