%%
close all

figure;
subplot(2,2,1)
i_plot(0)
subplot(2,2,2)
i_plot(0.25)
subplot(2,2,3)
i_plot(0.5)
subplot(2,2,4)
i_plot(0.75)

function i_plot(a)

x=-pi/2:0.05:pi/2;
y=x;
for theta=0:0.25:1
        g = [ryGate(1,a*pi); ryGate(2,theta*pi)];
        c=quantumCircuit(g);
        s = simulate(c);
        p1=probability(s,2,"1");
        
    for k=1:length(x)
        
        g = [ryGate(1,a*pi); ryGate(2,theta*pi); ...
             cryGate(1,2,x(k))];
        c=quantumCircuit(g);
     %   plot(c)
        s = simulate(c);
        b=sqrt(probability(s,2,"1"));
        y(k)=b;
    end
    %figure;
    hold on
    scatter(x,y);
end
    ylim([0 1])
    title(sprintf('%f',p1))

end