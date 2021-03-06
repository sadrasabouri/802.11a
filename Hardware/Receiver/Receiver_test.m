% /*
%  * `Receiver` Matlab function - test
%  *
%  * [TEST_INPUT]:  [1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 1  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 2  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 3  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 4  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 5  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 6  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 7  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 8  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 9  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 10 (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 11 (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 12 (=0xAA)
%  *
%  *                 1, 1, 0, 1,                %   SIGNAL.RATE (=6)
%  *                 0,                         %   SIGNAL.RESERVED (=0)
%  *                 0,0,0,0,0,0,0,1,0,0,0,0,   %   SIGNAL.LENGHT (=16)
%  *                 0,                         %   SIGNAL.PARITY (=0)
%  *                 0, 0, 0, 0, 0, 0,          %   SIGNAL.TAIL
%  *
%  *                 0, 0, 0, 0, 1, 1, 1, 0,    %   MSB - DATA.SERVICE =SCRAMBLE(0)
%  *                 1, 1, 1, 1, 0, 0, 1, 0,    %   LSB - DATA.SERVICE =SCRAMBLE(0)
%  *                 0, 1, 0, 1, 1, 0, 0, 1,    %   DATA.PSDU 1
%  *                 0, 0, 0, 0, 0, 0, 1, 0,    %   DATA.PSDU 2
%  *                 0, 0, 1, 0, 0, 1, 1, 0,    %   DATA.PSDU 3
%  *                 0, 0, 1, 0, 1, 1, 1, 0,    %   DATA.PSDU 4
%  *                 1, 0, 1, 1, 0, 1, 1, 0,    %   DATA.PSDU 5
%  *                 0, 0, 0, 0, 1, 1, 0, 0,    %   DATA.PSDU 6
%  *                 1, 1, 0, 1, 0, 1, 0, 0,    %   DATA.PSDU 7
%  *                 1, 1, 1, 0, 0, 1, 1, 1,    %   DATA.PSDU 8
%  *                 1, 0, 1, 1, 0, 1, 0, 0,    %   DATA.PSDU 9
%  *                 0, 0, 1, 0, 1, 0, 1, 0,    %   DATA.PSDU 10
%  *                 1, 1, 1, 1, 1, 0, 1, 0,    %   DATA.PSDU 11
%  *                 0, 1, 0, 1, 0, 0, 0, 1,    %   DATA.PSDU 12
%  *                 1, 0, 1, 1, 1, 0, 0, 0,    %   DATA.PSDU 13
%  *                 1, 1, 1, 1, 1, 1, 1, 0,    %   DATA.PSDU 14
%  *                 0, 0, 0, 1, 1, 1, 0, 1,    %   DATA.PSDU 15
%  *                 1, 1, 1, 0, 0, 1, 0, 1,    %   DATA.PSDU 16
%  *                 1, 0, 0, 1, 0, 0, 1, 0,    %   DATA.TAIL | PAD
%  *                 0, 0, 0, 0, 0, 1, 0, 0,    %   PAD
%  *                 0, 1, 0, 0, 1, 1, 0, 0]    %   PAD
%  *
%  *    CODDED
%  * [TEST_INPUT]:  [1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 1  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 2  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 3  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 4  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 5  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 6  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 7  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 8  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 9  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 10 (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 11 (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 12 (=0xAA)
%  *
%  *                 1, 1, 1, 0, 1, 0, 1, 1,    %   SIGNAL.RATE (=6)
%  *                 1, 0,                      %   SIGNAL.RESERVED (=0)
%  *                 0, 1, 1, 0, 1, 1, 1, 0,    %%
%  *                 1, 1, 0, 0, 0, 0, 1, 1,    %%% SIGNAL.LENGHT (=16)
%  *                 0, 1, 1, 1, 1, 1, 0, 0,    %%
%  *                 1, 0,                      %   SIGNAL.PARITY (=0)
%  *                 1, 1, 0, 0, 0, 0, 0, 0,    %%
%  *                 0, 0, 0, 0,                %%  SIGNAL.TAIL
%  *                 0, 0, 0, 0, 0, 0, 0, 0,    %
%  *                 1, 1, 1, 0, 0, 1, 0, 1,    %%  MSB - DATA.SERVICE =SCRAMBLE(0)
%  *                 1, 1, 1, 1, 0, 0, 1, 1,    %
%  *                 1, 0, 1, 0, 0, 1, 0, 0,    %%  LSB - DATA.SERVICE =SCRAMBLE(0)
%  *                 1, 0, 1, 1, 0, 1, 1, 0,    %
%  *                 1, 0, 1, 0, 1, 0, 1, 1,    %%  DATA.PSDU 1
%  *                 1, 1, 1, 0, 0, 0, 0, 0,    %
%  *                 1, 0, 1, 1, 1, 1, 0, 1,    %%  DATA.PSDU 2
%  *                 1, 1, 1, 1, 1, 1, 1, 1,    %
%  *                 0, 0, 0, 0, 1, 0, 0, 0,    %%  DATA.PSDU 3
%  *                 1, 1, 1, 1, 0, 1, 0, 0,    %
%  *                 1, 1, 0, 1, 0, 1, 1, 1,    %%  DATA.PSDU 4
%  *                 0, 0, 0, 0, 0, 1, 0, 0,    %
%  *                 0, 1, 0, 1, 1, 0, 0, 0,    %%  DATA.PSDU 5
%  *                 0, 1, 0, 0, 1, 0, 0, 1,    %
%  *                 0, 0, 1, 0, 1, 0, 0, 0,    %%  DATA.PSDU 6
%  *                 0, 0, 0, 0, 1, 1, 0, 0,    %
%  *                 1, 0, 1, 0, 1, 1, 0, 0,    %%  DATA.PSDU 7
%  *                 1, 0, 0, 1, 1, 1, 1, 0,    %
%  *                 0, 0, 1, 0, 1, 1, 0, 0,    %%  DATA.PSDU 8
%  *                 0, 1, 0, 1, 0, 1, 0, 0,    %
%  *                 1, 1, 1, 0, 0, 1, 0, 1,    %%  DATA.PSDU 9
%  *                 1, 0, 1, 1, 0, 1, 1, 0,    %
%  *                 0, 0, 1, 0, 0, 0, 0, 0,    %%  DATA.PSDU 10
%  *                 1, 1, 1, 1, 1, 0, 0, 0,    %
%  *                 0, 1, 1, 1, 1, 0, 1, 1,    %%  DATA.PSDU 11
%  *                 1, 0, 0, 1, 1, 0, 1, 0,    %
%  *                 0, 1, 1, 1, 0, 1, 0, 0,    %%  DATA.PSDU 12
%  *                 0, 0, 0, 1, 1, 1, 0, 1,    %
%  *                 1, 1, 0, 0, 1, 1, 0, 1,    %%  DATA.PSDU 13
%  *                 1, 0, 1, 1, 1, 0, 1, 0,    %
%  *                 1, 0, 0, 0, 1, 1, 0, 0,    %%  DATA.PSDU 14
%  *                 0, 1, 1, 0, 0, 1, 1, 0,    %
%  *                 0, 1, 0, 1, 0, 1, 1, 1,    %%  DATA.PSDU 15
%  *                 1, 1, 0, 0, 1, 1, 1, 0,    %
%  *                 1, 0, 0, 1, 0, 0, 0, 1,    %%  DATA.PSDU 16
%  *                 1, 0, 1, 0, 1, 0, 1, 1,    %   DATA.TAIL
%  *                 1, 1, 1, 0, 1, 1, 0, 1,    %%  DATA.TAIL | PAD
%  *                 0, 1, 0, 0, 0, 0, 1, 0,    %%
%  *                 1, 1, 1, 1, 0, 1, 1, 1,    %%% PAD
%  *                 1, 1, 1, 1, 1, 1, 0, 0,    %%% PAD
%  *                 0, 0, 1, 0, 0, 0, 1, 1]    %%
%  *  
%  *CODDED_INTERLEAVED
%  * [TEST_INPUT]:  [1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 1  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 2  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 3  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 4  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 5  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 6  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 7  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 8  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 9  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 10  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 11  (=0xAA)
%  *                 1, 0, 1, 0, 1, 0, 1, 0,    %   PLCP SYMBOL 12  (=0xAA)
%  *                                            %%   Interleaved Data:
%  *                 1, 1, 0, 1, 0, 0, 1, 1,
%  *                 1, 0, 1, 0, 1, 0, 1, 0,
%  *                 0, 1, 1, 0, 0, 1, 0, 0,
%  *                 1, 1, 0, 0, 1, 0, 0, 0,
%  *                 0, 1, 1, 0, 1, 1, 0, 0,
%  *                 1, 0, 1, 1, 0, 1, 1, 0,
%  *                 0, 1, 1, 0, 1, 0, 0, 1,
%  *                 1, 0, 1, 1, 0, 0, 0, 0,
%  *                 0, 1, 0, 1, 1, 0, 1, 0,
%  *                 1, 1, 1, 1, 0, 0, 1, 1,
%  *                 1, 0, 0, 0, 0, 0, 1, 1,
%  *                 1, 0, 0, 0, 1, 1, 0, 1,
%  *                 1, 1, 1, 1, 1, 1, 1, 1,
%  *                 1, 0, 1, 1, 0, 1, 0, 0,
%  *                 1, 1, 0, 1, 0, 0, 1, 0,
%  *                 1, 0, 1, 0, 0, 1, 1, 0,
%  *                 0, 1, 0, 1, 1, 1, 0, 1,
%  *                 0, 1, 0, 0, 1, 1, 0, 1,
%  *                 0, 0, 0, 0, 1, 0, 0, 0,
%  *                 0, 0, 0, 0, 0, 1, 1, 1,
%  *                 0, 1, 0, 0, 0, 0, 1, 0,
%  *                 0, 0, 1, 1, 0, 0, 0, 1,
%  *                 1, 1, 0, 0, 1, 1, 1, 0,
%  *                 0, 1, 0, 0, 0, 0, 0, 0,
%  *                 1, 0, 1, 0, 1, 0, 0, 0,
%  *                 1, 1, 1, 1, 1, 0, 0, 1,
%  *                 1, 1, 1, 0, 1, 0, 0, 0,
%  *                 0, 1, 0, 0, 1, 0, 1, 1,
%  *                 1, 0, 0, 0, 1, 0, 0, 1,
%  *                 1, 0, 0, 0, 0, 0, 1, 0,
%  *                 1, 1, 0, 1, 0, 0, 1, 0,
%  *                 0, 1, 1, 1, 1, 1, 1, 0,
%  *                 0, 1, 0, 1, 0, 0, 0, 1,
%  *                 0, 0, 1, 1, 1, 1, 1, 1,
%  *                 0, 1, 1, 0, 1, 0, 1, 0,
%  *                 1, 1, 1, 0, 0, 1, 0, 1,
%  *                 1, 0, 1, 0, 1, 1, 1, 1,
%  *                 0, 1, 0, 0, 1, 0, 1, 0,
%  *                 1, 1, 1, 1, 1, 0, 0, 0,
%  *                 1, 0, 1, 0, 1, 0, 0, 0,
%  *                 0, 0, 1, 1, 1, 0, 0, 1,
%  *                 1, 0, 0, 1, 0, 0, 1, 1,
%  *                 1, 0, 1, 0, 1, 1, 1, 0,
%  *                 1, 0, 0, 1, 1, 0, 1, 0,
%  *                 0, 1, 1, 1, 0, 1, 0, 0,
%  *                 1, 1, 0, 1, 1, 0, 1, 1,
%  *                 1, 0, 1, 0, 1, 0, 0, 1,
%  *                 1, 0, 0, 1, 1, 1, 1, 1]
%  * [TEST_OUTPUT] : [1, 0, 0, 1]
%  *
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */
Input = [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1,0,1,0,0,1,1,1,0,1,0,1,0,1,0,0,1,1,0,0,1,0,0,1,1,0,0,1,0,0,0,0,1,1,0,1,1,0,0,1,0,1,1,0,1,1,0,0,1,1,0,1,0,0,1,1,0,1,1,0,0,0,0,0,1,0,1,1,0,1,0,1,1,1,1,0,0,1,1,1,0,0,0,0,0,1,1,1,0,0,0,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0,0,1,1,0,1,0,0,1,0,1,0,1,0,0,1,1,0,0,1,0,1,1,1,0,1,0,1,0,0,1,1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,1,1,1,0,1,0,0,0,0,1,0,0,0,1,1,0,0,0,1,1,1,0,0,1,1,1,0,0,1,0,0,0,0,0,0,1,0,1,0,1,0,0,0,1,1,1,1,1,0,0,1,1,1,1,0,1,0,0,0,0,1,0,0,1,0,1,1,1,0,0,0,1,0,0,1,1,0,0,0,0,0,1,0,1,1,0,1,0,0,1,0,0,1,1,1,1,1,1,0,0,1,0,1,0,0,0,1,0,0,1,1,1,1,1,1,0,1,1,0,1,0,1,0,1,1,1,0,0,1,0,1,1,0,1,0,1,1,1,1,0,1,0,0,1,0,1,0,1,1,1,1,1,0,0,0,1,0,1,0,1,0,0,0,0,0,1,1,1,0,0,1,1,0,0,1,0,0,1,1,1,0,1,0,1,1,1,0,1,0,0,1,1,0,1,0,0,1,1,1,0,1,0,0,1,1,0,1,1,0,1,1,1,0,1,0,1,0,0,1,1,0,0,1,1,1,1,1]
OUT = Receiver(Input)
display('Bit Error: ');
DESIRED_OUT = [1, 0, 0, 1];
display(sum(xor(OUT(1:size(DESIRED_OUT, 2)), DESIRED_OUT)));
