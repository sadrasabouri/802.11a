# [Receiver](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver)
This part contains receiver part of the protocol which simply breaks into 3 part:

1. [DeScrambler](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/DeScrambler)

<img src="https://github.com/sadrasabouri/802.11a/blob/master/OtherFiles/Scrambler.PNG">

```
                +--------------+ 
                |              |
Output Data --> | DeScrambler | <------ from Antenna
                |              |
                |              |
                +--------------+
```

This directory contains different files:

## [Receiver.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/Receiver.v)
Receiver Verilog module.

## [Receiver_tb.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/Receiver_tb.v)
Receiver Verilog test bench which will be used as a unit test.

## [Receiver_tb.txt](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/Receiver_tb.txt)
Receiver Verilog test bench result.

## [Receiver.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/Receiver.m)
Receiver matlab function which will be used as a software simulation for HDL module.

## [Receiver_test.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/Receiver_test.m)
Receiver matlab function test.
