%The function returns state coresponding to independently set q-bits. Each input
%is considered to be a single q-bit in state q = a*|0> + b*|1>, where a and
%b are complex numbers. Q-bit is considered to be row vector with two
%members. Returned vector is a column.
%
%Normalization is done automatically by dividing each q-bit by its Euclidian norm.
%
%First input of the function is MSB, last one is LSB, 
%
%For example initializeRegisters([0 1], [1 0]) returns (0 0 1 0)'
%since [0 1] = |1> and [1 0] = |0>, hence state is |10>, i.e. no 2 in decimal.
%It can be clearly seen that first input (i.e. [0 1]) is MSB.

function q = initializeRegisters(varargin)    
    %init configuration - all bits set to |0>
    normalized = zeros(nargin,2); 
    normalized(:,1) = ones(nargin,1);
    
    for k = 1:nargin
        hlp = cell2mat(varargin(k)); %q-bits normalization
        normalized(k,:) = hlp/norm(hlp);
    end
    
    hlp = (normalized(1,:))';
    for k = 2:nargin
        hlp = kron(hlp,(normalized(k,:))'); %Tensor product to get final state
    end
    
    q = hlp;
end

