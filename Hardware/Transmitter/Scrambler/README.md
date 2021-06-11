# Scrambler
802.11a IEEE Wifi PLCP DATA Scrambler (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)

S(x) = x ^ 7 + x ^ 4 + 1

With initial value of (x_7, x_6, x_5, x_4, x_3, x_2, x_1) = (1, 1, 1, 1, 1, 1, 1)

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
