% example_BES_CCNR4x4   Example for using BES_CCNR4x4.

rho=BES_CCNR4x4;

R_rho=realign(rho);

disp('Trace norm of the realigned matrix. If it is larger than 1 then the state is entangled.')

CCNR=trnorm(R_rho)