Qubits;
g=Gates;

Q=kron(q0,q0);
G1=kron(H,H);
G2x=kron(q0*q0',I)+kron(q1*q1',g.RY(pi/3).mat);
G2=kron(I,q0*q0')+kron(g.RY(pi/3).mat,q1*q1');
G2x*G1*Q

G2=g.CRY(pi/3).mat;
G2x=g.CRY(pi/1.5,true).mat;
p=(G2x*G2*G1*Q).^2;
oddp=(p(1)+p(4))/(p(2)+p(3));

%%
figure;
bar(p)
a=permn([0 1],2);
b={};
for k=1:size(a,1)
    b{k}=sprintf('%d',a(k,:));
end
xticklabels(b)
