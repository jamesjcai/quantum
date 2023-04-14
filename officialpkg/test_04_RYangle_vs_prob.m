

a=0:0.05:1;
p=zeros(size(a));

for k=1:length(a)
        g = [ryGate(1,a(k)*pi)];
        c=quantumCircuit(g);
        s = simulate(c);
        p(k)=probability(s,1,"1");
end

scatter(a*pi,p)