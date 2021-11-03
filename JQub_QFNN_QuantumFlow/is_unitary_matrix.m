function is_unitary_matrix(H)
% if (U * U') == square identity matrix 

U = expm(1i*H);
Uinverse = inv(U);
UConjTran = U';
tol=10^(-6);
er=abs(UConjTran-Uinverse);
if sum(er(:))<tol
   disp('U is unitary')
else
   disp('U is NOT unitary')
end

