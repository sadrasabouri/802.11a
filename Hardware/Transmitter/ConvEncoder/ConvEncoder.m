function Output = ConvEncoder(Input)
% /*
%  * `ConvEncoder` Matlab function
%  *
%  * 802.11a IEEE Wifi PLCP DATA Convolutional Encoder (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)
%  * g0 = (1011011)_2  ---> g_0(x) = x^1 + x^3 + x^4 + x^6 + x^7
%  * g1 = (1111001)_2  ---> g_1(x) = x^1 + x^2 + x^3 + x^4 + x^7
%  * With initial value of (x_7, x_6, x_5, x_4, x_3, x_2, x_1) = (0, 0, 0, 0, 0, 0, 0)
%  * 
%  * parameters:
%  * Input    [n]: Input data array 
%  * Output   [2*n]: Output Coded data array
%  *
%  * [TEST_INPUT] : ones(1, 8)
%  * [TEST_OUTPUT]: [1, 1, 1, 0, 0, 1, 1, 0,
%  *                 1, 0, 0, 0, 1, 1, 1, 1]
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */
Output = [];

for i=1:size(Input, 2)
    offset = 0;
    while (offset < 7 && i - offset > 0)
        offset = offset + 1;
    end
    offset = offset - 1;
    X = [fliplr(Input(i - offset : i)), zeros(1, 7 - offset)];              %   Input Buffering

    Output = [Output, xor(xor(xor(xor(X(1), X(3)), X(4)), X(6)), X(7)), ...
                      xor(xor(xor(xor(X(1), X(2)), X(3)), X(4)), X(7))];    %   Y[Y, Y_0, Y_1]
end

end
