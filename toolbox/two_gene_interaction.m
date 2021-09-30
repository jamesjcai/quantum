g=Gates;
q=Qubits;

a=0:0.05:1;
b=2*acos(sqrt(a));

b=-pi:0.15:pi;

d1=zeros(length(b),length(b));
d2=zeros(length(b),length(b));
d3=zeros(length(b),length(b));
d4=zeros(length(b),length(b));
HH=kron(H,H)*kron(q0,q0);
P=[];
for k=1:length(b)
    for l=1:length(b)
        c=g.CRY(b(k),true).mat*g.CRY(b(l)).mat*HH;
        x=diag(c*c');
        P=[P; x(2:4)'];
        d1(l,k)=x(1);
        d2(l,k)=x(2);
        d3(l,k)=x(3);
        d4(l,k)=x(4);
    end
end
figure;
subplot(221)
mesh(d1)
xlabel('1st \theta'); ylabel('2nd \theta'); view(2); title('00')
subplot(222)
mesh(d2)
xlabel('1st \theta'); ylabel('2nd \theta'); view(2); title('01')
subplot(223)
mesh(d3)
xlabel('1st \theta'); ylabel('2nd \theta'); view(2); title('10')
subplot(224)
mesh(d4)
xlabel('1st \theta'); ylabel('2nd \theta'); view(2); title('11')



%%
b=-pi:0.15:pi;
d2=zeros(length(b),1);
d3=d2; d4=d2;
    for l=1:length(b)
        c=g.CRY(b(l)).mat*HH;
        x=diag(c*c');
        d2(l)=x(2);
        d3(l)=x(3);
        d4(l)=x(4);
    end
figure;
plot(b,d2);
hold on
plot(b,d3);
plot(b,d4);
legend({'01','10','11'})
