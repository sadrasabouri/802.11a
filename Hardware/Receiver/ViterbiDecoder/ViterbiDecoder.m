function Output = ViterbiDecoder(Input)
% /*
%  * `ViterbiDecoder` Matlab function
%  *
%  * As Document issued decoding the received sequence by the Viterbi algorithm is recommended.
%  * 
%  * parameters:
%  * Input    [2*n]: Input data array 
%  * Output   [n]: Output descrambled data array
%  *
%  *************************************************
%  * @author : sadrasabouri(sabouri.sadra@gmail.com)
%  *************************************************
%  */
    BPSK_RATE = 1 / 2;
    %   Reshaping input for better reach
    K = BPSK_RATE * size(Input, 2);
    Input = reshape(Input, 2, K)';
    
    %   PreDefining:
    %       TRANS:
    %       A 64 * 2 Matrix which represent transition matrix
    %           TRANS(x, y): Next state which is came as y is inputted
    %               ex:Trans(1,1): Next state when you're in state
    %               1(000000) and input is 0.
    %       O:
    %       A 64 * 2 Matrix which represent output matrix
    %           O(x, y): Ouputput which is came when we are in x as y is inputted
    %               ex:O(1,1): Output when you're in state
    %               1(000000) and input is 0.
    Trans = zeros(64, 2);
    O = zeros(64, 2);
    for i=1:64
        for j=1:2
        state = bin(fi(i-1, 0, 6, 0));
        next_state = [dec2bin(j-1), state(1:end-1)];   %   Buffer
        next_state = bin2dec(next_state) + 1;
        Trans(i, j) = next_state;
        
        O(i, j) = 2*xor(xor(xor(xor(j-1, ...
                                  bin2dec(state(2))), ...
                                  bin2dec(state(3))), ...
                                  bin2dec(state(5))), ...
                                  bin2dec(state(6)))+ ...    %   Y_0
                  xor(xor(xor(xor(j-1, ...
                                  bin2dec(state(1))), ...
                                  bin2dec(state(2))), ...
                                  bin2dec(state(3))), ...
                                  bin2dec(state(6)));        %   Y_1
        end
    end
    
    %       CostTilNow:
    %           A 64*1 matrix which saves all costs till now.
    %           ex: CostTilNow(1): when we are in state zero this is our
    %           minimum hamming distance cost
    CostTilNow = 10 * ones(64, 1);
    
    %       Paths:
    %           A 64 * (BPSK_RATE * size(Input, 2)) matrix which saves
    %           paths to already in state.
    %           ex: Paths(1,1)=0: first step of a state which ends to state
    %           1(000000)
    Paths = zeros(64, K);

    
    %   Branch Metric and Path metric Calculation
    for k=1:K
        I = Input(k, :);
        if (k == 1)
            for j=1:2
                state_to = Trans(1, j);
                Paths(state_to, 1) = 1;
                
                o = bin(fi(O(1, j), 0, 2, 0));
                o_1 = bin2dec(o(1));
                o_2 = bin2dec(o(2));
                cost = xor(I(1), o_1) + ...
                       xor(I(2), o_2);
                CostTilNow(state_to) = cost;
            end
        else
            CostTilNow_ = CostTilNow;
            Path_ = zeros(64, 1);
            for i=1:64
                if (Paths(i, k - 1) ~= 0)
                    for j=1:2
                        state_to = Trans(i, j);

                        o = bin(fi(O(i, j), 0, 2, 0));
                        o_1 = bin2dec(o(1));
                        o_2 = bin2dec(o(2));
                        cost = xor(I(1), o_1) + ...
                               xor(I(2), o_2);
                        if (CostTilNow(i) + cost <= CostTilNow_(state_to))
                            CostTilNow_(state_to) = CostTilNow(i) + cost;
                            
                            Path_(state_to, 1) = i;
                        end
                    end
                end
            end
            Paths(:, k) = Path_(:,1);
            CostTilNow = CostTilNow_;
        end
    end
    
    
    %   TraceBack:
    %       Finding Min:

    min_dist = 100;  %   Defines Maximum Error
    INDEX_MIN = 1;
    for i=1:64
        if (Paths(i, K) ~= 0)
            if (min_dist > CostTilNow(i))
                min_dist = CostTilNow(i);
                INDEX_MIN = i;
            end
        end
    end
    
    Output = zeros(1, K);
    
    for k=K:-1:1
        STATE = Paths(INDEX_MIN, k);
        if     (Trans(STATE, 1) == INDEX_MIN)
            Output(k) = 0;
        elseif (Trans(STATE, 2) == INDEX_MIN)
            Output(k) = 1;
        else
            display('INVALID!');
        end
        INDEX_MIN = STATE;
    end
end
