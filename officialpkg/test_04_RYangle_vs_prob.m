

a=0:0.05:1;
p=zeros(size(a));

for k=1:length(a)
        g = [ryGate(1,a(k)*pi)];
        c=quantumCircuit(g);
        s = simulate(c);
        p(k)=probability(s,1,"1");
end

figure;
scatter(a*pi,p)
hold on
plot(a*pi, sin(a*pi/2).^2);
axis square

%%
% %fr0 = 4*asin(sqrt(f0))/pi;
a=0:0.05:1;
figure;
scatter(a, 2*asin(sqrt(a)))
axis square



