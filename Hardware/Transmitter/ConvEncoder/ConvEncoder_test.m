% /*
%  * `ConvEncoder` Matlab function - test
%  *
%  * [TEST_INPUT] : ones(1, 8)
%  * [TEST_OUTPUT]: [1, 1, 1, 0, 0, 1, 1, 0,
%  *                 1, 0, 0, 0, 1, 1, 1, 1]
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */

DESIRED_OUT = [1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1];
Input = ones(1, 8)
OUT = ConvEncoder(Input)
RESULT = xor(OUT, DESIRED_OUT);
display('Bit Error: ');
display(sum(RESULT));
