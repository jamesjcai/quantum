% prodbasis2sym    Converts a multi-qubit density matrix from the computational basis 
%                  prodbasis2sym to the symmetric basis. Thus, an N-qubit
%                  state will produce an (N+1)x(N+1) density matrix.

function rho_sym=prodbasis2sym(rho_prodb)

[sy,sx]=size(rho_prodb);
N=floor(log2(sy)+0.5);

rho_sym=zeros(N+1,N+1);

for n=0:N
    for m=0:N
        rho_sym(m+1,n+1)=dstate(m,N)'*rho_prodb*dstate(n,N);
    end %for
end %for

