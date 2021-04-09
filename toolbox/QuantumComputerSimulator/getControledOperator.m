%The code returns matrix for single q-bit operator controlled by another
%q-bit.
%
%opName - name of quantum gate
%l - number of bits between target and controlled q-bit excluding these q-bits
%For example:
%q0: --------.--------- control bit
%q1: ------------------
%q2: ------------------
%q3: --------X--------- target bit
%In this case l = 2
%lambda, phi, theta - gate parameters

function op = getControledOperator(opName, l, theta, phi, lambda)
    baseOp = getOperator(opName, theta, phi, lambda);    
    N = 2^(l+2);    
    op = [eye(N/2) zeros(N/2); zeros(N/2) kron(eye(N/4), baseOp)];    
end