function Output = Transmitter(Input)
% /*
%  * `Transmitter` Matlab function
%  *
%  * 802.11a IEEE Transmitter
%  *
%  * parameters:
%  * Input    [n]: Input data array 
%  * Output   [m]: Output descrambled data array
%  *
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */
    Symbol = [1,0,1,0, 1,0,1,0];                                            %=0hAA
    PREAMBLE_SYMBOLS = [Symbol, Symbol, Symbol, Symbol,  Symbol, Symbol, Symbol, Symbol,  Symbol, Symbol, Symbol, Symbol]; %   PLCP Preamble
    RATE = [1,1,0,1];
    LENGTH = [0,0,0,0, 0,0,0,1, 0,0,0,0];                                   %=0h010
    N_DBPS = 24;

    DATA_LENGH = 8 * bin2dec(num2str(LENGTH));
    N_SYM = ceil((16 + DATA_LENGH + 6) / N_DBPS);
    N = ceil(size(Input, 2) / DATA_LENGH);

    Output = [];
    
    %   For each packet:
    for i=1:N
        toCoder = zeros(1, (24 + N_SYM * N_DBPS));
        
        toCoder(1:4) = RATE;                                                 %   SIGNAL.RATE
        toCoder(5) = 0;                                                      %   SIGNAL.RESERVED
        toCoder(6:17) = LENGTH;                                              %   SIGNAL.LENGTH
        if (mod(sum([PREAMBLE_SYMBOLS, toCoder(1:17)]), 2) == 1)             %   SIGNAL.PARITY
            toCoder(18) = 1;
        else
            toCoder(18) = 0;
        end
        toCoder(19:24) = zeros(1, 6);                                        %   SIGNAL.TAIL
        

        toCoder(25:40) = zeros(1, 16);                                       %   DATA.SERVICE
        if (size(Input, 2) < DATA_LENGH*i)                                   %   DATA.PSDU
            toCoder(41:40+DATA_LENGH) = [Input(DATA_LENGH*(i-1)+1:end), zeros(1, DATA_LENGH - (size(Input, 2) - DATA_LENGH*(i-1)))];
        else
            toCoder(41:40+DATA_LENGH) = Input(DATA_LENGH*(i-1)+1:DATA_LENGH*i);
        end
        toCoder(41+DATA_LENGH:41+DATA_LENGH+5) = zeros(1, 6);              %   DATA.TAIL
        
        cd Scrambler;   %   Including Scrambler
        toCoder(25:end) = Scrambler(toCoder(25:end));
        cd ..;          %   Comming back to main directory

        cd ConvEncoder;
        ConvEncoder_out = ConvEncoder(toCoder(1:end));
        cd ..;
        
        cd Interleaver;
        toCoder = [PREAMBLE_SYMBOLS, Interleaver(ConvEncoder_out)];
        cd ..;
        
        Output = [Output, toCoder];
    end
end