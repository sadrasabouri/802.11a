# Transmitter
[Transmitter](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Transmitter.v) module has the rule of converting `input` data after `start` to wifi frame and send it to antenna.

User should set the `start` for a clock and then wait for `12 * 8 + 4 + 1 + 12 + 1 + 6 + 16 = 136` clocks and then send in the input data which should be `Transmitter.LENGTH` octets (Bytes) then for resending you should set `start` for a clock again.

This part contains transmitter part of the protocol which simply breaks into 3 part:

1. [Scrambler](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Scrambler)

802.11a IEEE Wifi PLCP DATA Scrambler (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)

S(x) = x ^ 7 + x ^ 4 + 1

With initial value of (x_7, x_6, x_5, x_4, x_3, x_2, x_1) = (1, 1, 1, 1, 1, 1, 1) 

<img src="https://github.com/sadrasabouri/802.11a/blob/master/OtherFiles/Scrambler.PNG">

```
               +-----------+
               |           |
Input Data --> | Scrambler +------> to Antenna
               |           |
               |           |
               +-----------+
```

This directory contains different files:

## [Transmitter.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Transmitter.v)
Transmitter Verilog module.

## [Transmitter_tb.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Transmitter_tb.v)
Transmitter Verilog test bench which will be used as a unit test.

## [Transmitter_tb.txt](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Transmitter_tb.txt)
Transmitter Verilog test bench result.

## [Transmitter.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Transmitter.m)
Transmitter matlab function which will be used as a software simulation for HDL module.

## [Transmitter_test.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Transmitter_test.m)
Transmitter matlab function test.
