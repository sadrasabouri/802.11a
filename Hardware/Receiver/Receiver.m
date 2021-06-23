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
    Symbol = [1,0,1,0, 1,0,1,0];                                            %=0hAA
    PREAMBLE_SYMBOLS = [Symbol, Symbol, Symbol, Symbol,  Symbol, Symbol, Symbol, Symbol,  Symbol, Symbol, Symbol, Symbol];
    DeScInit = zeros(1, 7);
    N_DBPS = 24;
    
    Output = [];
    cd ViterbiDecoder
    Input(97 : 96 + (end - 96) / 2) = ViterbiDecoder(Input(97:end));
    cd ..
    RATE = Input(97:100)
    LENGTH = Input(102:113)
    DATA_LENGH = 8 * bin2dec(num2str(LENGTH));
    if(mod(sum(Input(1:113)), 2) == 1)
        if (Input(114) == 0)
            display('Parity Fault in SIGNAL.');
        end
    else
        if (Input(114) == 1)
            display('Parity Fault in SIGNAL.');
        end
    end

    D = Input(121:127);
    %   Calculating DeScrambler Initial state from D
    DeScInit(1) = xor(D(3), D(7));
    DeScInit(2) = xor(D(2), D(6));
    DeScInit(3) = xor(D(1), D(5));
    DeScInit(4) = xor(DeScInit(1), D(4));
    DeScInit(5) = xor(DeScInit(2), D(3));
    DeScInit(6) = xor(DeScInit(3), D(2));
    DeScInit(7) = xor(DeScInit(4), D(1));
    DeScInit

    cd DeScrambler;   %   Including DeScrambler
    Output = DeScrambler(Input(121:136+DATA_LENGH), DeScInit);
    Output = Output(17:20);
    cd ..;          %   Comming back to main directory

end
