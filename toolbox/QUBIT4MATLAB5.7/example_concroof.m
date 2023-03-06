% example_concroof    Examples for using concroof

clear all
close all
format compact

% Robertson-Schrodinger uncertainty relation for a qubit
d=2;
paulixyz
A=x;
B=y;
rho=rdmat(1,d);

varA_times_varB=va(A,rho)*va(B,rho)

% Expression from the RHS of the Robertson-Schrodinger uncertainty relation
func=@(xx) sqrt(abs(trace((A*B+B*A)*(xx))-2*trace(A*(xx))*trace(B*(xx)))^2+abs(trace(i*(A*B-B*A)*(xx)))^2);

disp('Original bound of the Robertson-Scrodinger uncertainty relation')
unc_bound_original=(1/4)*func(rho)

disp('Improved bound based on concave roofs')
MIXED_STATE_DECOMP_ON=1;
unc_bound_improved=(1/4)*(concroof(rho,func,d,MIXED_STATE_DECOMP_ON))^2

disp(' ')

% Robertson-Schrodinger uncertainty relation for a qutrit
d=3;
A=rhermitian(1,d);
B=rhermitian(1,d);
rho=mmstate(1,d);

varA_times_varB=va(A,rho)*va(B,rho)

% Expression from the RHS of the Robertson-Schrodinger uncertainty relation
func=@(xx) sqrt(abs(trace((A*B+B*A)*(xx))-2*trace(A*(xx))*trace(B*(xx)))^2+abs(trace(i*(A*B-B*A)*(xx)))^2);

disp('Original bound of the Robertson-Scrodinger uncertainty relation')
unc_bound_original=(1/4)*func(rho)

disp('Improved bound based on concave roofs')
MIXED_STATE_DECOMP_ON=1;
unc_bound_improved=(1/4)*(concroof(rho,func,d,MIXED_STATE_DECOMP_ON))^2
