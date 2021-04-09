%------------------------------
%Introduction:
%This code implements simulator of a universal quantum computer.
%The simulator is based on Deutsch model of a quantum computer, thus matrix
%multiplication and tensor (Kronecker) product are only operations used for simulation.
% 
%Gates are named according to standard notation, mostly follows that used in
%scientific literature.
%Operators are put into matrix of strings, where rows of matrix are q-bits and 
%columns are steps of an quantum algorithm (see below for details). This construction
%mimics generally used quantum circuit schemas and allows user to easily convert from
%the schema to the simulator notation. 
%
%These single q-bit operators are avaiable: 
%I, X, Y, Z, H, S, T, DS, DT, RX, RY, RZ, U1, U2, U3, EXP (matrix exponential)
%
%Note 1: Check function getOperator for parameters names of gates U2 and U3 as these
%have more than one parameter.
%
%Note 2: Matrix in operator EXP has to be defined as a global variable called "A", i.e.
%before using EXP operator type Global A; followed by the matrix A the in command window, e.g.
%  Global A;
%  A = 0.5*[3 1; 1 3];
%  quantumComputer(...);
%
%Note 3: User can add any single q-bit operator to function getOperator.
%
%One q-bit controlled version of above operators, including controlled X (CNOT), 
%can be used as well.
%
%Toffoli gate (CCNOT) is available too and it is denoted TF onwards.
%
%The code also implements swap gate and it is denoted SWP onwards.
%
%------------------------------
%Syntax of the function is following:
%function [computerState, probFinal] = quantumComputer(qAlgorithm, measuredQbits, initState)   
%------------------------------
%
%INPUT Parameters:
%qAlgorithm: Matrix of strings containing quantum algorithm. Matrix rows
%corespond to qbits and columns to steps of the algorithm.
%For example, quantum circuit (Bell state (|00> + |11>)/sqrt(2) preparation)
%
%----H----.----
%----I----X----
%
%is expressed by matrix qAlgorithm = ["H" "."; "I" "X"].
%
%Dot means control q-bit controlling gate below it (see first row of the algorithm).
%Identity operators have to be included, i.e it is not possible to use
%empty strings instead.
%Empty strings are used only in case controlling bit is not directly above
%controlled gate, e.g.
%
%----H----.----
%----I---------  HERE IS BLANK STRING ABOVE X
%----I----X----
%
%In this case alg = ["H" "."; "I" "" ; "I" "X"]
%
%Parameters (if any) are written after gates and are separated by character '|', e.g.
%
%----U3----H---- U3 parameters are theta = pi/2, phi = pi/4, lambda = pi/8
%----I-----H----
%
%So, alg = ["U3|pi/2|pi/4|pi/8" "H"; "I" "H"]
%It is possible to input directly numbers or use multiples and fractions of pi
%
%Here is an example of using Toffoli gates
%
%----.-----X--- 
%----------X---
%----.-----X---
%----TF----I---
%
%In this case alg = ["." "X"; "" "X"; "." "X"; "TF" "I"]
%
%This example is concerning SWP gates:
%----X-----SWP-- 
%----X---------- HERE is a blank between SWPs
%----I-----SWP--
%
%The circuit can be rewriten as alg = ["X" "SWP"; "X" ""; "I" "SWP"] and
%its purpose is to swap the first and the last q-bits.
%In case two or more swap gates are used in one algorithm step, those are
%evaluated from the most significant q-bit towards the least significant
%q-bits. For example, in this circuit:
%
%1:---SWP---
%2:---SWP---
%3:---SWP---
%4:---SWP---
%
%firstly q-bits 1 and 2 are swapped and then q-bits 3 and 4 are swapped. If
%user wants to swap q-bits 1 and 4, and q-bits 2 and 3, following circuit
%has to be used
%
%1:---SWP----I-----
%2:---------SWP----
%3:---------SWP----
%4:---SWP----I-----
%
%so, quantum algorithm has following shape: alg = ["SWP" "I"; "" "SWP"; "" "SWP"; "SWP" "I"]
%------------------------------
%measuredQbits (row vector) - indexes of q-bits to be measured. Q-bit's index
%starts with 1. First row of algorithm is intended for MSB, last row for LSB,
%hence index one refers to MSB. For example [1 2 3] ensures that only
%first, second and third q-bits are to be measured.
%In case this parameter is omitted, all bits are to be measured.
%It is possible to reverse order of q-bits (i.e. to swap MSB and LSB), 
%e.g. to reverse order of 4 q-bits, measuredBits is vector [4 3 2 1].
%------------------------------
%initState (column vector) - initial state of quantum computer. You can use
%functions initializeRegisters or initializeRegistersInt for state
%preparation. Result of any previous computation done by quantumComputer can be
%used as initial state as well. This allows to use this function in cycles.
%------------------------------
%
%OUTPUT Parameters:
%computerState (column vector) - state of quantum register after
%calculation. State is expresed in standard basis (or so-called measure or z basis).
%------------------------------
%probFinal (column vector) - probability distribution of measured q-bits. 
%First row of the vector correspond to the state |0...0>, last one to
%|1...1>. Number of vector members is 2^m where m is number of measured
%q-bits (i.e. lenght of vector measuredQbits).
%Histogram of the measured q-bits distribution is shown after finalizing calculation.  
%------------------------------
%algMatrix (matrix) - a matrix describing an algorithm
function [computerState, probFinal, algMatrix] = quantumComputer(qAlgorithm, measuredQbits, initState)                           
    algorithm = algorithmPreprocess(qAlgorithm); %replacing Toffoli and swap gates with simpler gates
    %algorithm = toffoliAlgorithmPreprocess(qAlgorithm); %replacing Toffoli gates with simpler gates
    
    steps = size(algorithm,2);
    qbits = size(algorithm,1);    
    opParams = "";
    algMatrix = eye(2^qbits);
                    
    if nargin == 3
        computerState = initState;
        mBits = measuredQbits;
    end
    
    if nargin == 2
        computerState = initializeRegistersInt(qbits,0); %in case initState is empty, state |0...0> is set in
        mBits = measuredQbits;
    end
    
    if nargin == 2 || nargin == 3
        if size(mBits,2) > qbits
            error 'Number of measured q-bits is higher and number of q-bits used in algorithm.'
        end
    end
    
    if nargin == 1        
        computerState = initializeRegistersInt(qbits,0); %in case initState is empty, state |0...0> is set in
        mBits = 1:qbits; %measure all q-bits unless they are specified
    end  
    
    if qbits == log(size(computerState,1))/log(2)
        for k = 1:steps            
            stepOperator = eye(1); %initialize operator for step
            l = 1;            
            while l <= qbits
                if algorithm(l,k) ~= "." %single q-bit operator                    
                    opParams = split(algorithm(l,k),'|');                       
                    opParams(2:end) = lower(opParams(2:end)); %in case constants like a pi are used, these have to be expressed in lower case
                    while size(opParams) < 4
                        opParams(end + 1) = "0";
                    end
                    stepOperator = kron(stepOperator, getOperator(opParams(1),str2num(char(opParams(2))),str2num(char(opParams(3))),str2num(char(opParams(4)))));                    
                else %controled multi q-bit operator
                    m = 0;
                    while algorithm(l + m + 1,k) == ""                          
                        m = m + 1;
                    end
                    l = l + m + 1;
                    opParams = split(algorithm(l,k),'|');
                    while size(opParams) < 4
                        opParams(end + 1) = "0";
                    end
                    opParams(2:end) = lower(opParams(2:end)); %in case constants like a pi are used, these have to be expressed in lower case
                    stepOperator = kron(stepOperator, getControledOperator(opParams(1),m,str2num(char(opParams(2))),str2num(char(opParams(3))),str2num(char(opParams(4)))));
                end
                l = l + 1;
            end
            
            algMatrix = stepOperator*algMatrix; %calculate matrix describing the quantum algorithm
        end
    else
        error 'Different q-bits number in algorithm and initial state';
    end
    computerState = algMatrix*computerState; %calculate final computer state
    prob = abs(computerState).^2;    
    
    if size(mBits,2) == qbits %all q-bits are measured
        probFinal = prob;
        kk = qbits; 
    else  %only particular q-bits are measured
        kk = size(mBits,2);
        probFinal = zeros(2^kk,1);
        
        for k = 1:2^qbits
            binAddress = dec2bin(k-1, qbits); %state in binary representation           
            binAddress = binAddress(mBits); %measured q-bits are selected                         
            probFinal(bin2dec(binAddress)+1) = probFinal(bin2dec(binAddress)+1) + prob(k); %measured q-bits are converted to decimal to address vector of probabilities
        end
    end      
    
    %plotting results in histogram
    bar(categorical(cellstr(dec2bin(0:2^kk-1))),100*probFinal,'faceColor','r');
    text(1:2^kk, 100*probFinal, num2str(100*probFinal,'%0.1f %%'),'HorizontalAlignment','center','VerticalAlignment','bottom')
    ylim([0 100]);
    xlabel('State');
    ylabel('Probability (%)');
    title('Quantum register distribution');
end