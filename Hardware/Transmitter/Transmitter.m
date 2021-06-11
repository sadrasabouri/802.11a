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
    Symbol = [1,0,1,0, 1,0,1,0];                                            %=0hAA
    PREAMBLE_SYMBOLS = [Symbol, Symbol, Symbol, Symbol,  Symbol, Symbol, Symbol, Symbol,  Symbol, Symbol, Symbol, Symbol];
    RATE = [1,1,0,1];
    LENGTH = [0,0,0,0, 0,0,0,1, 0,0,0,0];                                   %=0h010
    N_DBPS = 24;

    DATA_LENGH = 8 * bin2dec(num2str(LENGTH));
    N_SYM = ceil((16 + DATA_LENGH + 6) / N_DBPS);
    N = ceil(size(Input, 2) / DATA_LENGH);
    Output = zeros(1, N * (120 + N_SYM * N_DBPS));
    
    %   For each packet:
    for i=1:N
        output = zeros(1, 120 + N_SYM * N_DBPS);
        
        output(1:96) = PREAMBLE_SYMBOLS;                                    %   PLCP Preamble
        output(97:100) = RATE;                                              %   SIGNAL.RATE
        output(101) = 0;                                                    %   SIGNAL.RESERVED
        output(102:113) = LENGTH;                                           %   SIGNAL.LENGTH
        if (mod(sum(output(1:113)), 2) == 1)                                %   SIGNAL.PARITY
            output(114) = 1;
        else
            output(114) = 0;
        end
        output(115:120) = zeros(1, 6);                                      %   SIGNAL.TAIL
        

        output(121:136) = zeros(1, 16);                                     %   DATA.SERVICE
        if (size(Input, 2) < DATA_LENGH*i)                                  %   DATA.PSDU
            output(137:136+DATA_LENGH) = [Input(DATA_LENGH*(i-1)+1:end), zeros(1, DATA_LENGH - (size(Input, 2) - DATA_LENGH*(i-1)))];
        else
            output(137:136+DATA_LENGH) = Input(DATA_LENGH*(i-1)+1:DATA_LENGH*i);
        end
        output(137+DATA_LENGH:137+DATA_LENGH+5) = zeros(1, 6);              %   DATA.TAIL
        
        cd Scrambler;   %   Including Scrambler
        output(121:end) = Scrambler(output(121:end));
        cd ..;          %   Comming back to main directory
        
        Output((120 + N_SYM * N_DBPS) * (i-1) + 1:(120 + N_SYM * N_DBPS) * i) = output;
    end
end