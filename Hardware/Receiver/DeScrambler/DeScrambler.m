function Output = DeScrambler(Input)
% /*
%  * `DeScrambler` Matlab function
%  *
%  * 802.11a IEEE Wifi PLCP DATA Scrambler (https://pdos.csail.mit.edu/archive/decouto/papers/802.11a.pdf - Page 16)
%  * S(x) = x ^ 7 + x ^ 4 + 1
%  * With initial value of (x_7, x_6, x_5, x_4, x_3, x_2, x_1) = (1, 1, 1, 1, 1, 1, 1)
%  * 
%  * parameters:
%  * Input    [n]: Input data array 
%  * Output   [n]: Output scrambled data array
%  *
%  * [TEST_INPUT]:  [0, 0, 0, 0, 1, 1, 1, 0,
%  *                 1, 1, 1, 1, 0, 0, 1, 0,
%  *                 1, 1, 0, 0, 1, 0, 0, 1,
%  *                 0, 0, 0, 0, 0, 0, 1, 0,
%  *                 0, 0, 1, 0, 0, 1, 1, 0,
%  *                 0, 0, 1, 0, 1, 1, 1, 0,
%  *                 1, 0, 1, 1, 0, 1, 1, 0,
%  *                 0, 0, 0, 0, 1, 1, 0, 0,
%  *                 1, 1, 0, 1, 0, 1, 0, 0,
%  *                 1, 1, 1, 0, 0, 1, 1 ,1,
%  *                 1, 0, 1, 1, 0, 1, 0, 0,
%  *                 0, 0, 1, 0, 1, 0, 1, 0,
%  *                 1, 1, 1, 1, 1, 0, 1, 0,
%  *                 0, 1, 0, 1, 0, 0, 0, 1,
%  *                 1, 0, 1, 1, 1, 0, 0, 0,
%  *                 1, 1, 1, 1, 1, 1, 1]
%  * [TEST_OUTPUT] : zeros(1, 127)
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */
    
    Output = zeros(size(Input));

    string = [1, 1, 1, 1, 1, 1, 1];         %   Initial State
    
    for i=1:size(Input, 2)
        S_x = xor(string(7), string(4));    %   S(x) = x ^ 7 + x ^ 4 + 1
        
        %   Due to sequential run
        first_slice = string(1:3);
        second_slice = string(4:6);
        
        %   string update
        string(1) = S_x;
        string(2:4) = first_slice;
        string(5:7) = second_slice;
        
        
        %   Scrambling
        Output(i) = xor(Input(i), S_x);
    end
end