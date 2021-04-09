% ptsym   Partial transpose of a symmetric state in a bipartite form.
%         The density mayrix is not normalized.

function rho_pt_bipartite=ptsym(rho_sym,M)

[sy,sx]=size(rho_sym);
N=sy-1;

rho_bipartite=sym2bipartite(rho_sym,M);

% Partial transpose according to a Mx(N-M) partition.
rho_pt_bipartite=pt_nonorm(rho_bipartite,1,N-M+1);