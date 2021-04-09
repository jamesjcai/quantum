%Auxiliary code for replacing Toffoli gate and swap gate by their implementation with
%controlled NOT, Hadamard and T gates (Toffoli only).
function editedAlg = algorithmPreprocess(algorithm)   
    editedAlg = upper(algorithm); %operators are expresed in upper case    
    noOfToffolis = sum(sum(editedAlg == "TF",1)>0); %no of steps where Toffoli gate is used
    noOfSwaps = sum(sum(editedAlg == "SWP",1)>0); %no of steps where swap gate is used
    noOfToffAndSwp = sum((sum(editedAlg == "TF",1).*sum(editedAlg == "SWP",1))>0); %no of steps where swap or Toffoli gate is used
        
    if noOfSwaps + noOfToffolis > 0 %at least one Toffoli or swap gate is used => algorithm will be modified                        
        qbits = size(algorithm,1);
        steps = size(algorithm,2);
        algPrep(1:qbits,1:(steps + 13*noOfToffolis + 4 *(noOfSwaps - noOfToffAndSwp))) = "I"; 
       
        n = 1;
        for k = 1:steps
            algPrep(:,n) = editedAlg(:,k); %copy algorithm
            stepToff = sum(editedAlg(:,k) == "TF",1);
            stepSwap = sum(editedAlg(:,k) == "SWP",1)/2;
            
            if stepToff == 0 && stepSwap == 0 %neither Toffoli nor swap in k-th step, continue                
                n = n + 1;
            else                
                if stepToff ~= 0 %Toffoli processing
                    toffIndexes = 1:qbits;%positions of Toffoli gates
                    toffIndexes = toffIndexes(editedAlg(:,k) == "TF"); 

                    for m = 1:size(toffIndexes,2)       
                        toffoliBit = toffIndexes(m); 
                        l =  toffoliBit - 1;
                        while editedAlg(l,k) ~= "."
                            l = l - 1;
                        end                    
                        secControlBit = l;

                        l = l - 1;                    
                        while editedAlg(l,k) ~= "."
                            l = l - 1;
                        end
                        firstControlBit = l;

                        %Replace TF with its implementation by simpler single q-bit operators and CNOTs
                        algPrep(toffoliBit,n:n+13) = ["H" "X" "DT" "X" "T" "X" "DT" "X" "T" "H" "I" "I" "I" "I"];
                        algPrep(secControlBit,n:n+13) = ["I" "." "I" "" "I" "." "I" "" "I" "I" "T" "X" "DT" "X"];
                        algPrep(firstControlBit,n:n+13) = ["I" "I" "I" "." "I" "I" "I" "." "I" "I" "I" "." "T" "."];

                        %ensure proper syntax of algorithm - empty strings
                        %among controlled and target q-bits for CNOTs, no empty 
                        %spaces among non-controlled gates => I operator is inserted
                        algPrep((firstControlBit):(toffoliBit-1),n) = "I";
                        algPrep((firstControlBit+1):(toffoliBit-1),[n+3 n+7]) = "";
                        algPrep((secControlBit+1):(toffoliBit-1),[n+1 n+5]) = "";
                        algPrep((firstControlBit+1):(secControlBit-1),[n+11 n+13]) = "";                                     
                    end                                               
                end
                
                if stepSwap ~= 0 %swap preprocessing
                    swapsIndexes = 1:qbits;%positions of swap gates
                    swapsIndexes = swapsIndexes(editedAlg(:,k) == "SWP");
                    
                    for m = 1:2:size(swapsIndexes,2)
                        algPrep(swapsIndexes(m),n:n+4) = ["." "H" "." "H" "."];
                        algPrep(swapsIndexes(m+1),n:n+4) = ["X" "H" "X" "H" "X"];
                        algPrep((swapsIndexes(m)+1):(swapsIndexes(m+1)-1),[n n+2 n+4]) = "";
                    end
                end
                
                if stepToff ~= 0
                    n = n + 14;
                else
                    n = n + 5;
                end
            end
        end
        editedAlg = algPrep;
    end        
end

