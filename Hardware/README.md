# Hardware Implementation of 802.11a protocol
In this Hardware Implementation of IEEE 802.11a Wifi Standard we feature Verilog for our HDL language and Matlab for our high-level testing language.

Hardware simulations will be also done by Modelsim.


## Main Structure
Bellow structure will be implemented for this project which is by the way a optimal subset of 802.11a standard.


### [Transmitter](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter)
This part contains transmitter part of the protocol which simply breaks into 3 part:

1. Scrambler
2. Convolutional-Encoder

```ditaa {cmd=true args=["-E"]}
               +-----------+        +---------+
               |           |        |         |
Input Data --> | Scrambler +------> |  Conv.  |
               |           |        | Encoder |
               |           |        |         |
               +-----------+        +---------+
```
### [Receiver](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Receiver)
