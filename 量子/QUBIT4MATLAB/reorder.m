% reorder   Reorder a state vector or a density matrix according to
%           the given pattern.
%    reorder(v,pattern) transforms a state vector or a density matrix
%    putting the qubits in the order given in pattern.
%    pattern=[N N-1 N-2 ... 1] does not change the ordering.
%    The numbering of qubits can be indicated by the expression
%    mkron(b4,b3,b2,b1). 
%
%    The format reorder(v,pattern,d) makes it possible to handle 
%    d-dimensional systems, not only qubits. If the density matrix 
%    given is sparse, then reorder will also produce a sparse matrix.
%
%    Example: 
%    
%    Let us assume that b1,b2,b3,b4 are single qubit density matrices.
%
%    reorder([4 3 2 1],mkron(b4,b3,b2,b1))=mkron(b4,b3,b2,b1)
%    (doing nothing)
%
%    reorder([1 2 3 4],mkron(b4,b3,b2,b1))=mkron(b1,b2,b3,b4)
%    (putting the qubits in an opposite order)
%
%    If d is a vector, then it can be used to give the
%    the transformation matrix for a register of qudits which
%    do not all have the same dimension.
%
%    Example:
%
%    reorder(rho,[2 1],[3 2]) corresponds to not changeing the order
%                             of a qutrit and a qubit (i.e., doing nothing)
%
%    reorder(rho,[1 2],[3 2]) corresponds to flipping a qutrit 
%                             and a qubit


function mm=reorder(m,pattern,varargin)
% Pattern: numbers from 1 to N.
% No order changes: patterns = 8 7 6 5 4 3 2 1

if isempty(varargin),
   d=2;
else
    if length(varargin)~=1,
        error('Wrong number of input arguments.');
    end %if
    d=varargin{1};
end %if

[y,x]=size(m);
if min(x,y)==1,
  if y==1, 
      m=m.'; 
  end %if
  % m is a state vector
  mm=zeros(y,x);
  mm(reordervec(pattern,d))=m;
elseif issparse(m)
  % m is a sparse density matrix
  r=spreordermat(pattern,d);
  mm=r*m*r.';
else
  % m is a density matrix
  r=reordermat(pattern,d);
  mm=r*m*r.';
end %if