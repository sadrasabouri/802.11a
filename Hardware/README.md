# Hardware Implementation of 802.11a Protocol
In this Hardware Implementation of IEEE 802.11a Wifi Standard we feature Verilog for our HDL language and Matlab for our high-level testing language.

Hardware simulations will be also done by Modelsim.


## Main Structure
Bellow structure will be implemented for this project which is by the way a optimal subset of 802.11a standard.
Wifi frame which is going to be used here is as fallows:

<img src="https://github.com/sadrasabouri/802.11a/blob/master/OtherFiles/WifiFrames.PNG">


### [Transmitter](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter)
[Transmitter](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Transmitter.v) module has the rule of converting `input` data after `start` to wifi frame and send it to antenna.

User should set the `start` for a clock and then wait for `12 * 8 + 4 + 1 + 12 + 1 + 6 + 16 = 136` clocks and then send in the input data which should be `Transmitter.LENGTH` octets (Bytes) then for resending you should set `start` for a clock again.

This part contains transmitter part of the protocol which simply breaks into 3 part:

1. [Scrambler](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Scrambler)

```
               +-----------+
               |           |
Input Data --> | Scrambler +------> to Antenna
               |           |
               |           |
               +-----------+
```

### [Receiver](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver)
[Receiver](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver/Receiver.v) part contains 

Receiver is waiting for the preamble set to start the process and it pushes it into a FIFO que named `Input_buffer` and then wait for `152` clocks and then start to pick up `LENGTH * 8` bits of input.

receiver part of the protocol which simply breaks into 3 part:

1. [DeScrambler](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/DeScrambler)

```
                +--------------+ 
                |              |
Output Data --> | DeScrambler  | <------ from Antenna
                |              |
                |              |
                +--------------+
```


This directory contains different files:

## [ِDUT.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/DUT.v)
Whole design under test module.

## [DUT_tb.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/DUT_tb.v)
Design under test Verilog test bench.

## [DUT_tb.txt](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/DUT_tb.txt)
Design under test Verilog test bench.

## [DUT.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Transmitter.m)
Transmitter matlab test script.
