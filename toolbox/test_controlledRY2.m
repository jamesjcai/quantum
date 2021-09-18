Qubits;
g=Gates;

Q=kron(q0,q0);
G1=kron(H,H);

theta=(0:0.01:1)*2*pi;

oddp=zeros(size(theta));
P=[];
for k=1:length(theta)
    G2=g.CRY(theta(k)).mat;
    
    p=(G2*G1*Q).^2;
    oddp(k)=(p(1)+p(4))/(p(2)+p(3));
    P=[P p];
end
figure;
plot(theta/(2*pi),oddp)

%%
figure;
bar(p)
a=permn([0 1],2);
b={};
for k=1:size(a,1)
    b{k}=sprintf('%d',a(k,:));
end
xticklabels(b)
