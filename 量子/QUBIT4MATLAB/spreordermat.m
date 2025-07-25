% spreordermat  Transformation matrix for reordering the qudits according to
%               the given pattern; sparse version.
%    spreordermat(pattern,d) gives a sparse transformation matrix for
%    putting the qudits in the order given in pattern.
%    d is the dimension of the qudit. If it is omitted then
%    the default value is 2 (qubits).
%    pattern=[N N-1 N-2 ... 1] does not change the ordering.
%    The numbering of qudits can be indicated by the expression
%    mkron(b4,b3,b2,b1).
%
%    If d is a vector, then it can be used to give the
%    the transformation matrix for a register of qudits which
%    do not all have the same dimension.
%
%    spreordermat([2 1],[3 2]) corresponds to not changeing the order
%                              of a qutrit and a qubit (i.e., doing nothing)
%
%    spreordermat([1 2],[3 2]) corresponds to flipping a qutrit 
%                              and a qubit


function matrix=spreordermat(pattern,varargin)

if isempty(varargin),
    % qubits
    base=2;
else
    if length(varargin)~=1,
        error('Wrong number of input arguments.');
    end %if
    base=varargin{1};
end %if

% Pattern: numbers from 1 to N.
% No order changes: pattern = 8 7 6 5 4 3 2 1

% If it is a row vector, transform it into column vector
[y,x]=size(pattern);
if x>1,
    pattern=pattern.';
end %if

pattern=pattern-1;

if length(base)==1
    
    N=length(pattern);
    matrix=sparse(base^N,base^N);
    a=zeros(N,1);
    n=1;
    while 1
        matrix(n,sum(base.^pattern.*a)+1)=1;
        k=N;
        a(k)=a(k)+1;
        while a(k)==base
            a(k)=0;
            k=k-1;
            if k==0,
                return
            end %if
            a(k)=a(k)+1;
        end %while
        n=n+1;
    end %while
    
else
    
    % Qudits have different dimensions
    
    % After the permutation of the qudits,
    % we get a new vector of dimensions
    
    N=length(pattern);
    base2=base(N-pattern);
    
    matrix=sparse(prod(base),prod(base));
    
    % a is a binary number for qubits (base d number for qudits)
    a=zeros(N,1);
    n=1;
    while 1
        a2=a(N-pattern);
        %[a a2]
        
        p=sparse(uvec(a(1)+1,base(1)));
        for n=2:N
            p=kron(p,sparse(uvec(a(n)+1,base(n))));
        end
        
        p2=sparse(uvec(a2(1)+1,base2(1)));
        for n=2:N
            p2=kron(p2,sparse(uvec(a2(n)+1,base2(n))));
        end
        
        matrix=matrix+p2*p.';
        
        k=N;
        a(k)=a(k)+1;
        while a(k)==base(k)
            a(k)=0;
            k=k-1;
            if k==0,
                return
            end %if
            a(k)=a(k)+1;
        end %while
        n=n+1;
    end %while
    
end