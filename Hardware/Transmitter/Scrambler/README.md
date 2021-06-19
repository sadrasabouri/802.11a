# Scrambler
802.11a IEEE Wifi PLCP DATA Scrambler (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)

S(x) = x ^ 7 + x ^ 4 + 1

With initial value of (x_7, x_6, x_5, x_4, x_3, x_2, x_1) = (1, 1, 1, 1, 1, 1, 1)

The DATA field, composed of SERVICE, PSDU, tail, and pad parts, shall be scrambled with a length-127 frame-synchronous scrambler. The octets of the PSDU are placed in the transmit serial bit stream, bit 0 first and bit 7 last. The frame synchronous scrambler uses the generator polynomial S(x) as follows:

```
S(x) = x^7 + x^4 + 1
```

The 127-bit sequence generated repeatedly by the scrambler shall be (leftmost used first), 00001110
11110010 11001001 00000010 00100110 00101110 10110110 00001100 11010100 11100111 10110100
00101010 11111010 01010001 10111000 1111111, when the “all ones” initial state is used.

The same scrambler is used to scramble transmit data and to descramble receive data. When transmitting, the initial state of the scrambler will be set to a pseudo random non-zero state (in this project 1111111). The seven LSBs of the SERVICE field will be set to all zeros prior to scrambling to enable estimation of the initial state of the scrambler in the receiver.

<img src="https://github.com/sadrasabouri/802.11a/blob/master/OtherFiles/Scrambler.PNG">

This directory contains different files:

## [Scrambler.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Scrambler/Scrambler.v)
Scrambler Verilog module which will be used as a first layer in transmitter.

## [Scrambler_tb.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Scrambler/Scrambler_tb.v)
Scrambler Verilog test bench which will be used as a unit test.

## [Scrambler_tb.txt](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Scrambler/Scrambler_tb.txt)
Scrambler Verilog test bench result.

## [Scrambler.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Scrambler/Scrambler.m)
Scrambler matlab function which will be used as a software simulation for HDL module.

## [Scrambler_test.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Scrambler/Scrambler_test.m)
Scrambler matlab function test which is used as a proved test which is in IEEE standard.
