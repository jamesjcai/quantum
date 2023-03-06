% wdistsquare_dpt   Wasserstein distance square
%    Obtained via a minimization over quantum states.
%    Parameters: wdistsquare_dpt(rho,sigma,H), where
%    rho are sigma are density matrices, H is an operator.
%    H can also be a three-dimensional matrix. In this case,
%    H(:,:,n) give the individual Hn operators.
%    It can give additional parameters:
%    [distance,diagnostic,coupling]=wdistsquare_dpt(rho,sigma,H)
%    Here, coupling is the bipartite state corresponding
%    to the minimum of the ioptmization problem.
%    diagnostic is a variable from solvesdp in YALMIP.
%    See https://arxiv.org/abs/2209.09925
%    It needs the front-end YALMIP and
%    a semidefinite solver such as MOSEK.

function [optimum,diagnostic,coupling]=wdistsquare_dpt(rho,sigma,H)

% 0-General quantum states, 1-PPT states
PPT_STATES_ON=0;

% 0-No transpose, 1-Transpose
TRANSPOSE_ON=1;

% 0-MIN,1-MAX
MIN_OR_MAX=0;

[sy,sx]=size(rho);

d=sx;
d1=d;
d2=d;

E1=eye(d1,d1);
E2=eye(d2,d2);

rho12=sdpvar(d1*d2,d1*d2,'hermitian','complex');
rhoA=keep_nonorm(rho12,1,d);
rhoB=keep_nonorm(rho12,2,d);
FF=[rho12>=0]+[trace(rho12)==1];

if TRANSPOSE_ON==0,
    s=size(H);
    if length(s)==2
       C=(kron(E2,H)-kron(H,E1))^2; % Note: no partial transpose!
    else
       C=zeros(d^2,d^2);
       for n=1:s(3)
          C=C+(kron(E2,H(:,:,n))-kron(H(:,:,n),E1))^2;
       end
    end
    FF=FF+[rhoA==sigma]+[rhoB==rho];
else
    s=size(H);
    if length(s)==2
       C=(kron(E2,H)-kron(H.',E1))^2; % Note: with partial transpose!
    else
       C=zeros(d^2,d^2);
       for n=1:s(3)
          C=C+(kron(E2,H(:,:,n))-kron(H(:,:,n).',E1))^2; 
       end
    end
    FF=FF+[rhoA==sigma]+[rhoB==rho.'];
end

if PPT_STATES_ON==1,
   FF=FF+[pt_nonorm(rho12,1,d1)>=0];
end

ops = sdpsettings('solver','mosek','verbose',0,'debug',1);
if MIN_OR_MAX==1
   diagnostic=solvesdp(FF,-real(trace(rho12*C)),ops);
else
   diagnostic=solvesdp(FF,real(trace(rho12*C)),ops);
end

optimum=1/2*double(trace(rho12*C));

coupling=double(rho12);
