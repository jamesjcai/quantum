% sym2prodbasis    Converts a multi-qubit density matrix from the symmetric  
%                  basis to the product basis. The N-qubit symmetric state 
%                  must be given by an (N+1)x(N+1) density matrix.

function rho_prodb=sym2prodbasis(rho_sym)

[sy,sx]=size(rho_sym);
N=sy-1;

rho_prodb=zeros(2^N,2^N);

for n=0:N
    for m=0:N
        rho_prodb=rho_prodb+rho_sym(n+1,m+1)*dstate(n,N)*dstate(m,N)';
    end %for
end %for

