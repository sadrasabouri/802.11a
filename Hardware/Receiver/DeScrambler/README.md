# DeScrambler
802.11a IEEE Wifi PLCP DATA DeScrambler (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)

S(x) = x ^ 7 + x ^ 4 + 1

With initial value of (x_7, x_6, x_5, x_4, x_3, x_2, x_1) = (1, 1, 1, 1, 1, 1, 1)

This directory contains different files:

## [DeScrambler.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/DeScrambler/DeScrambler.v)
DeScrambler Verilog module which will be used as a first layer in transmitter.

## [DeScrambler_tb.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/DeScrambler/DeScrambler_tb.v)
DeScrambler Verilog test bench which will be used as a unit test.

## [DeScrambler_tb.txt](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/DeScrambler/DeScrambler_tb.txt)
DeScrambler Verilog test bench result.

## [DeScrambler.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/DeScrambler/DeScrambler.m)
DeScrambler matlab function which will be used as a software simulation for HDL module.

## [DeScrambler_test.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/DeScrambler/DeScrambler_test.m)
DeScrambler matlab function test which is used as a proved test which is in IEEE standard.