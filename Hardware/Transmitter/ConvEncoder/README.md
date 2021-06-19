# ConvEncoder
802.11a IEEE Wifi PLCP DATA Convolutional Encoder (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)

The DATA field, composed of SERVICE, PSDU, tail, and pad parts, shall be coded with a convolutional encoder of coding rate R = 1/2, 2/3, or 3/4, corresponding to the desired data rate. The convolutional encoder shall use the industry-standard generator polynomials, g0 = (133)_8 and g1 = (171)_8, of rate R = 1/2, as shown in Figure bellow.

The bit denoted as “A” shall be output from the encoder before the bit denoted as “B.” Higher rates are derived from it by employing “puncturing.” Puncturing is a procedure for omitting some of the encoded bits in the transmitter (thus reducing the number of transmitted bits and increasing the coding rate) and inserting a dummy “zero” metric into the convolutional decoder on the receive side in place of the omitted bits.

<img src="https://github.com/sadrasabouri/802.11a/blob/master/OtherFiles/ConvEncoder.PNG">

This directory contains different files:

## [ConvEncoder.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/ConvEncoder/ConvEncoder.v)
ConvEncoder Verilog module which will be used as a first layer in transmitter.

## [ConvEncoder_tb.v](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/ConvEncoder/ConvEncoder_tb.v)
ConvEncoder Verilog test bench which will be used as a unit test.

## [ConvEncoder_tb.txt](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/ConvEncoder/ConvEncoder_tb.txt)
ConvEncoder Verilog test bench result.

## [ConvEncoder.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/ConvEncoder/ConvEncoder.m)
ConvEncoder matlab function which will be used as a software simulation for HDL module.

## [ConvEncoder_test.m](https://github.com/sadrasabouri/802.11a/tree/master/Hardware/Transmitter/ConvEncoder/ConvEncoder_test.m)
ConvEncoder matlab function test which is used as a proved test which is in IEEE standard.
