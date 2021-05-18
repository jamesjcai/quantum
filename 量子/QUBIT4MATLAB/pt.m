% pt    partial transposition of a density matrix
%       for a qudit register.
%    pt(M,list,d) computes the matrix obtained from M
%    by partially transposing the qudits given in the list.
%    The numbering of the qudits starts with 1, not from 0.
%    Here d is the dimension of the qudits.
% 
%    If d is not provided then d is taken to be 2 (qubits).
%    d can also be a vector of dimensions. In this case, 
%    the qudits can be of different dimension.
%   
%    M is normalized making the trace 1 before any further
%    computation. If instead of a density matrix, a state vector
%    is provided for M, then this vector is transformed to
%    a density matrix before computing the partial transpose.
%
%    pt_nonorm is like pt, but does not normalize the state.
% 
%    Example:
%
%    Let us assume that rho is a four-qubit state.
%
%    pt(rho,[4 3 2 1]) transposes the state for all subsystems
%
%    pt(rho,[4 3]) transposes the state for two subsystems
%
%    pt(rho,[4 3],[3 4 5 6]) transposes the state for two subsystems,
%    the system consists of a 3-state. 4-state, 5-state and 6-state system.
%
%    pt(mkron(r4,r3,r3,r1),[4 3]) transposes r4 and r3 of the product
%    state, where r1,r2,r3,r4 are density matrices
%

function rhoT=pt(rho,list,varargin)

rho=ketbra2(rho);

if nargin==2,
    d=2;
elseif nargin==3,
    d=varargin{1};
else
    error('Wrong number of input arguments.');
end %if

[sy,sx]=size(rho);
if length(d)==1
    ld=floor(log(sy+0.01)/log(d));
    d=d*ones(ld,1);
else
    ld=length(d);
end

rhoT=zeros(sy,sx);
for n=1:length(list)
    nn=list(n);
    nmax=prod(d(ld+2-nn:ld));
    nmax2=nmax*d(ld+1-nn);
     
    % Partial transpostion #1
    for k=1:nmax
        for l=1:nmax
            rhoT(k:nmax:end,l:nmax:end)=rho(k:nmax:end,l:nmax:end).';
        end %for
    end %for
    
    rho=rhoT;
    
    % Partial transpostion #2
    for k=1:nmax2
        for l=1:nmax2
            rhoT(k:nmax2:end,l:nmax2:end)=rho(k:nmax2:end,l:nmax2:end).';
        end %for
    end %for
    
    rho=rhoT;

end %for


