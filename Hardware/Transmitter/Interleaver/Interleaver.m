function Output = Interleaver(Input)
% /*
%  * `Interleaver` Matlab function
%  *
%  * 802.11a IEEE Wifi PLCP DATA Interleaver (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 17)
%  * In N_CBPS = 48 we have these index mappings:
%  * 0 --> 0
%  * 1 --> 3
%  * 2 --> 6
%  * 3 --> 9
%  * 4 --> 12
%  * 5 --> 15
%  * 6 --> 18
%  * 7 --> 21
%  * 8 --> 24
%  * 9 --> 27
%  * 10 --> 30
%  * 11 --> 33
%  * 12 --> 36
%  * 13 --> 39
%  * 14 --> 42
%  * 15 --> 45
%  * 16 --> 1
%  * 17 --> 4
%  * 18 --> 7
%  * 19 --> 10
%  * 20 --> 13
%  * 21 --> 16
%  * 22 --> 19
%  * 23 --> 22
%  * 24 --> 25
%  * 25 --> 28
%  * 26 --> 31
%  * 27 --> 34
%  * 28 --> 37
%  * 29 --> 40
%  * 30 --> 43
%  * 31 --> 46
%  * 32 --> 2
%  * 33 --> 5
%  * 34 --> 8
%  * 35 --> 11
%  * 36 --> 14
%  * 37 --> 17
%  * 38 --> 20
%  * 39 --> 23
%  * 40 --> 26
%  * 41 --> 29
%  * 42 --> 32
%  * 44 --> 35
%  * 45 --> 38
%  * 46 --> 41
%  * 47 --> 44
%  * 
%  * parameters:
%  * Input    [n]: Input data array 
%  * Output   [n]: Output scrambled data array
%  *
%  * [TEST_INPUT] : 0:47
%  * [TEST_OUTPUT]: [0, 16, 32, 1, 17, 33, 2, 18,
%  *                 34, 3, 19, 35, 4, 20, 36, 5,
%  *                 21,37, 6,  22,38,  7, 23,39,
%  *                  8,24,40,   9,25, 41, 10,26,
%  *                 42,11,27,  43,12, 28, 44,13,
%  *                 29,45,14,  30,46, 15, 31,47]
%  *
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */
    
    NCBPS = 48;
    N = size(Input, 2) / NCBPS;
    Output = [];
    for k=1:N
        MEM = reshape(Input((k-1) * NCBPS + 1:k* NCBPS), 16, NCBPS / 16)';
        Output = [Output, reshape(MEM, 1, NCBPS)];
    end
end