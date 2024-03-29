% qvec   Empty state vector for a given number of qudits.
%    qvec(n,d) creates an n qudit empty state vector where d is the 
%    dimension of the qudits. If d is omitted then it is taken to be 2.
%    If argument n is omitted than the default is taken to be
%    the value of global variable N.

function s=qvec(varargin)

if isempty(varargin)
    global N;
    d=2;
elseif length(varargin)==1
    N=varargin{1};
    d=2;
elseif length(varargin)==2
    N=varargin{1};
    d=varargin{2};
else
    error('Wrong number of input arguments.')
end %if

s=zeros(d^N,1);
