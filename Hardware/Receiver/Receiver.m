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
    offset = 1;
    
    Output = [];
    while (offset < size(Input, 2))
        for i=offset:size(Input,2)
            if(all(Input(i:i+95) == PREAMBLE_SYMBOLS))
               display('SEQ FOUND.');
               break
            end
        end
        
        RATE = Input(i+96:i+99)
        LENGTH = Input(i+101:i+112)
        DATA_LENGH = 8 * bin2dec(num2str(LENGTH));
        if(mod(sum(Input(i:i+112)), 2) == 1)
            if (Input(113+i) == 0)
                display('Parity Fault in SIGNAL.');
            end
        else
            if (Input(113+i) == 1)
                display('Parity Fault in SIGNAL.');
            end
        end

        D = Input(i+120:i+126);
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
        output = DeScrambler(Input(120+i:135+i+DATA_LENGH), DeScInit);
        Output = [Output, output(17:end)];
        cd ..;          %   Comming back to main directory

        offset = N_DBPS * (1+ceil((136 + i + DATA_LENGH)/N_DBPS));
    end
end