# Hardware Implementation of 802.11a Protocol
In this Hardware Implementation of IEEE 802.11a Wifi Standard we feature Verilog for our HDL language and Matlab for our high-level testing language.

Hardware simulations will be also done by Modelsim.


## Main Structure
Bellow structure will be implemented for this project which is by the way a optimal subset of 802.11a standard.
Wifi frame which is going to be used here is as fallows:

<img src="https://github.com/sadrasabouri/802.11a/blob/master/OtherFiles/WifiFrames.PNG">


### [Transmitter](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter)
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
This part contains receiver part of the protocol which simply breaks into 3 part:

1. [DeScrambler](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/DeScrambler)

```
                +--------------+ 
                |              |
Output Data --> | DeScrambler | <------ from Antenna
                |              |
                |              |
                +--------------+
```
