%The function converts integer to quantum state. 
%
%INPUT:
%qbit - number of required q-bits.
%num - integer to be expressed as quantum state
%
%For example: initializeRegistersInt(3, 4), the state |011> is returned,
%expresed in vector: (0 0 0 0 1 0 0 0)'.

function q = initializeRegistersInt(qbits, num)
    N = 2^qbits;
    if num + 1 <= N
        q = zeros(N,1);
        q(num + 1,1) = 1;
    else %error state        
        error (['Required number (', num2str(num),') is higher than maximal range for current number of q-bits: ', num2str(N - 1), '.']);
    end
end