% rhermitian   Random Hermitian operator of given dimension
%    rhermitian(n,d) creates an n qudit random Hermitian operator where d 
%    is the dimension of the qudits. If d is omitted then it is taken to be 2.
%    If argument n is omitted then the default is taken to be
%    the value of global variable N. 

function rho=rhermitian(varargin);

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

   rho=randn(d^N,d^N)+i*randn(d^N,d^N);
   rho=(rho+rho')/2;


