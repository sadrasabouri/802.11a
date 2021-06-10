# Transmitter
[Transmitter](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Transmitter.v) module has the rule of converting `input` data after `start` to wifi frame and send it to antenna.
This part contains transmitter part of the protocol which simply breaks into 3 part:

1. [Scrambler](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/Scrambler)

802.11a IEEE Wifi PLCP DATA Scrambler (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)

S(x) = x ^ 7 + x ^ 4 + 1

With initial value of (x_7, x_6, x_5, x_4, x_3, x_2, x_1) = (1, 1, 1, 1, 1, 1, 1) 

```
               +-----------+
               |           |
Input Data --> | Scrambler +------> to Antenna
               |           |
               |           |
               +-----------+
```
