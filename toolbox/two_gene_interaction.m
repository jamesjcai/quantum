a=0:0.05:1;
b=2*acos(sqrt(a));

b=-pi:0.15:pi;

d1=zeros(length(b),length(b));
d2=zeros(length(b),length(b));
d3=zeros(length(b),length(b));
d4=zeros(length(b),length(b));
HH=kron(H,H)*kron(q0,q0);

for k=1:length(b)
    for l=1:length(b)
        c=g.CRY(b(k),true).mat*g.CRY(b(l)).mat*HH;
        x=diag(c*c');
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