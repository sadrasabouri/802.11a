% /*
%  * `DUT` Matlab script
%  *
%  * 802.11a IEEE whole module desing under test which make a closed loop
%  * path from transmitter ro reciever and checks if the sending data and 
%  * it's receving are the same or not 
%  *
%  * parameters:
%  * Input    [n]: Input data array 
%  * Output   [n]: Output descrambled data array
%  *
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */
    Input = zeros(1, 127)

    cd Transmitter;   %   Including Transmitter
    Antenna = Transmitter(Input)
    cd ..;          %   Comming back to main directory

    cd Receiver;   %   Including Receiver
    Output = Receiver(Antenna)
    cd ..;          %   Comming back to main directory

    if (sum(Input == Output) == size(Input, 2))
        display('ALL TESTS PASSED :)')
    else
        Input == Output
    end