# Interleaver

All encoded data bits (Signal and Data subframe) shall be interleaved by a block interleaver with a block size corresponding to the number of bits in a single OFDM symbol, NCBPS.
The interleaver is defined by a two-step permutation. The first permutation ensures that adjacent coded bits are mapped onto nonadjacent subcarriers. The second ensures that adjacent coded bits are mapped alternately onto less and more significant bits of the constellation and, thereby, long runs of low reliability (LSB) bits are avoided.

We shall denote by k the index of the coded bit before the first permutation; i shall be the index after the first and before the second permutation, and j shall be the index after the second permutation, just prior to modulation mapping.


The first permutation is defined by the rule:
```
i = (NCBPS/16) (k mod 16) + floor(k/16)  for k = 0, 1, …, NCBPS–1
```
The function floor (.) denotes the largest integer not exceeding the parameter.


The second permutation is defined by the rule:
```
j = s × floor(i/s) + (i + NCBPS – floor(16 × i/NCBPS)) mod s   for i = 0,1,… NCBPS – 1
```
The value of s is determined by the number of coded bits per subcarrier, NBPSC, according to:
```
s = max(NBPSC/2,1)
```

This module will put inputs into a buffer which has a length relative to NCBPS and start to output values after a dedicated pulses of clock. The output shall be interleaved values of input.

Some permutation for NCBPS = 48 have been came here:
```
0 --> 0
1 --> 3
2 --> 6
3 --> 9
4 --> 12
5 --> 15
6 --> 18
7 --> 21
8 --> 24
9 --> 27
10 --> 30
11 --> 33
12 --> 36
13 --> 39
14 --> 42
15 --> 45
16 --> 1
17 --> 4
18 --> 7
19 --> 10
20 --> 13
21 --> 16
22 --> 19
23 --> 22
24 --> 25
25 --> 28
26 --> 31
27 --> 34
28 --> 37
29 --> 40
30 --> 43
31 --> 46
32 --> 2
33 --> 5
34 --> 8
35 --> 11
36 --> 14
37 --> 17
38 --> 20
39 --> 23
40 --> 26
41 --> 29
42 --> 32
44 --> 35
45 --> 38
46 --> 41
47 --> 44
```

This directory contains different files:

## [Interleaver.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Interleaver/Interleaver.v)
Interleaver Verilog module which will be used as a last layer in receiver.

## [Interleaver_tb.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Interleaver/Interleaver_tb.v)
Interleaver Verilog test bench which will be used as a unit test.

## [Interleaver_tb.txt](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Interleaver/Interleaver_tb.txt)
Interleaver Verilog test bench result.

## [Interleaver.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Interleaver/Interleaver.m)
Interleaver matlab function which will be used as a software simulation for HDL module.

## [Interleaver_test.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Interleaver/Interleaver_test.m)
Interleaver matlab function test which is used as a proved test which is in IEEE standard.
