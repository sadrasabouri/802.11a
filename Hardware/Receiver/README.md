# [Receiver](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver)
This part contains receiver part of the protocol which simply breaks into 3 part:

Receiver is waiting for the preamble set to start the process and it pushes it into a FIFO que named `Input_buffer` and then wait for `152` clocks and then start to pick up `LENGTH * 8` bits of input.

1. [DeScrambler](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/DeScrambler)

<img src="https://github.com/sadrasabouri/802.11a/blob/master/OtherFiles/Scrambler.PNG">

2. [ViterbiDecoder](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/ViterbiDecoder)

As Document issued decoding the received sequence by the Viterbi algorithm is recommended. 

```
                +--------------+     +----------------+
                |              |     |                |
Output Data <-- | DeScrambler  | <-- | ViterbiDecoder | <---- from Antenna
                |              |     |                |
                |              |     |                |
                +--------------+     +----------------+
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
