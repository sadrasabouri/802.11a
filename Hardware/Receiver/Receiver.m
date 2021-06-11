function Output = Receiver(Input)
% /*
%  * `Receiver` Matlab function
%  *
%  * 802.11a IEEE Receiver
%  *
%  * parameters:
%  * Input    [n]: Input data array 
%  * Output   [n]: Output descrambled data array
%  *
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */
    cd DeScrambler;   %   Including DeScrambler
    Output = DeScrambler(Input);
    cd ..;          %   Comming back to main directory
end