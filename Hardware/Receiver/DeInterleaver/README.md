# DeInterleaver

The deinterleaver, which performs the inverse relation, is also defined by two permutations

This module will put inputs into a buffer which has a length relative to NCBPS and start to output values after a dedicated pulses of clock. The output shall be interleaved values of input.

Some permutation for NCBPS = 48 have been came here:
```
0 <-- 0
1 <-- 3
2 <-- 6
3 <-- 9
4 <-- 12
5 <-- 15
6 <-- 18
7 <-- 21
8 <-- 24
9 <-- 27
10 <-- 30
11 <-- 33
12 <-- 36
13 <-- 39
14 <-- 42
15 <-- 45
16 <-- 1
17 <-- 4
18 <-- 7
19 <-- 10
20 <-- 13
21 <-- 16
22 <-- 19
23 <-- 22
24 <-- 25
25 <-- 28
26 <-- 31
27 <-- 34
28 <-- 37
29 <-- 40
30 <-- 43
31 <-- 46
32 <-- 2
33 <-- 5
34 <-- 8
35 <-- 11
36 <-- 14
37 <-- 17
38 <-- 20
39 <-- 23
40 <-- 26
41 <-- 29
42 <-- 32
44 <-- 35
45 <-- 38
46 <-- 41
47 <-- 44
```

This directory contains different files:

## [DeInterleaver.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/DeInterleaver/DeInterleaver.v)
DeInterleaver Verilog module which will be used as a last layer in Receiver.

## [DeInterleaver_tb.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/DeInterleaver/DeInterleaver_tb.v)
DeInterleaver Verilog test bench which will be used as a unit test.

## [DeInterleaver_tb.txt](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/DeInterleaver/DeInterleaver_tb.txt)
DeInterleaver Verilog test bench result.

## [DeInterleaver.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/DeInterleaver/DeInterleaver.m)
DeInterleaver matlab function which will be used as a software simulation for HDL module.

## [DeInterleaver_test.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/DeInterleaver/DeInterleaver_test.m)
DeInterleaver matlab function test which is used as a proved test which is in IEEE standard.
