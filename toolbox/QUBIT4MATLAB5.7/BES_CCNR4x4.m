% BES_CCNR4x4   4x4 bound entangled state maximaly violating the 
%               Computable Cross Norm-Realignment (CCNR) criterion

function rho=BES_CCNR4x4

psi=zeros(4,4);

psi1 = [0 1 1 0]'/sqrt(2);
psi2  = [0 1 -1 0]'/sqrt(2);
psi3  = [1 0 0 1]'/sqrt(2);
psi4  = [1 0 0 -1]'/sqrt(2);

rhoApBp1 = psi1*psi1'/6;
rhoApBp2 = psi2*psi2'/6;
rhoApBp3 = psi3*psi3'/6;
rhoApBp4 = (eye(2*2)-psi4*psi4')/6;



rho=kron(psi1*psi1',rhoApBp1)+kron(psi2*psi2',rhoApBp2)+...
    kron(psi3*psi3',rhoApBp3)+kron(psi4*psi4',rhoApBp4);

F=[1 0 0 0;0 0 1 0;0 1 0 0;0 0 0 1];
V = kron(kron(eye(2),F),eye(2));
rho= V*rho*V;


