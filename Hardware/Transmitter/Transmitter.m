function Output = Transmitter(Input)
% /*
%  * `Transmitter` Matlab function
%  *
%  * 802.11a IEEE Transmitter
%  *
%  * parameters:
%  * Input    [n]: Input data array 
%  * Output   [n]: Output descrambled data array
%  *
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */
    cd Scrambler;   %   Including Scrambler
    Output = Scrambler(Input);
    cd ..;          %   Comming back to main directory
end