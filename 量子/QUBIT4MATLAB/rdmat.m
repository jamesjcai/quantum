% rdmat   Random density matrix
%    rdmat(n,d) creates an n qudit density matrix where d is the 
%    dimension of the qudits. If d is omitted then it is taken to be 2.
%    If argument n is omitted than the default is taken to be
%    the value of global variable N.
%    (A density matrix is a hermitian matrix with 
%    unit trace and non-negative eigenvalues; the distribution
%    of the matrix is random according to the Hilbert-Schmidt norm.)

function r=rdmat(varargin)

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

% The random matrix is uniformly distributed according to the Hilbert-Schmidt norm.
% See the paper by Sommers and Zyczkowski at 
% http://www.arxiv.org/abs/quant-ph?papernum=0405031
% We generate a random (2d)^N dimensional pure state and
% take its reduced density d^N dimensional matrix.

% Generate a random matrix with elements with normal distributions
s=randn(d^N,d^N)+i*randn(d^N,d^N);
% Create a positive matrix
r=s'*s;
% Normalize it
r=r/trace(r);

% One can check that it really computes the reduced
% density matrix of a random state vector:
% ss=ket(reshape(conj(s),d^(2*N),1));
% rr=remove(ss,N:-1:1,d);
% difference=norm(rr-r)


