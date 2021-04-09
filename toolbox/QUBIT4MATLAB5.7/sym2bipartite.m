% sym2bipartite    Converts a multi-qubit density matrix from the symmetric
%                  basis to a density matrix of a bipartite state.
%                  A density matrix of a symmetric N-qubit state is
%                  of size (N+1) times (N+1).
%                  rho_bipartite=sym2bipartite(rho_sym,M) results
%                  in a quantum state of a bipartite system, where the two
%                  parties are of size M+1 and N-M+1. Thus,
%                  the bipartition corresponds to M qubits vs. N-M qubits.

function rho_bipartite=sym2bipartite(rho_sym,M)

[sy,sx]=size(rho_sym);
N=sy-1;

rho_bipartite=zeros((M+1)*(N-M+1),(M+1)*(N-M+1));

for n=0:N
        
    % decomoposition of |n,M>
    % as sum_k lambda_k |k,M> |n-k,N-M>
    % See G. Toth, J. Opt. Soc. Am. B 24, 275 (2007)
    fn=zeros((M+1)*(N-M+1),1);
    for k=0:M
        if k<=M && n-k>=0 && n-k<=N-M
            fn=fn+sqrt(binom(M,k)*binom(N-M,n-k)/binom(N,n))*...
                kron(uvec(k+1,M+1),uvec(n-k+1,N-M+1));
            
            % For degugging
            % [1 sqrt(binom(M,k)*binom(N-M,n-k))/binom(N,n) k n+1 n-k+1]
        end
    end
    for m=0:N
        
        % For degugging
        %[n m rho_sym(n+1,m+1)]
    
        fm=zeros((M+1)*(N-M+1),1);
        for k=0:M
            if k<=M && m-k>=0 && m-k<=N-M
                fm=fm+sqrt(binom(M,k)*binom(N-M,m-k)/binom(N,m))*...
                    kron(uvec(k+1,M+1),uvec(m-k+1,N-M+1));
                
                % For degugging
                % [2 sqrt(binom(M,k)*binom(N-M,m-k))/binom(N,m) k m+1 m-k+1]
            end
        end
        rho_bipartite=rho_bipartite+rho_sym(n+1,m+1)*fn*fm.';
        
        % For degugging
        % save
        % pause
        
    end %for
end %for

