%%

p=[];
x=0:0.05:pi;
for k=1:length(x)
    s=simulate(quantumCircuit(ryGate(1,x(k))));
    %histogram(s)    
    %pause
    p=[p s.Amplitudes.^2];
end
figure;
plot(x,p')



%%
% gates = [hGate(1); cxGate(1,2)];
gates = [ryGate(1,0.5*pi)];
c = quantumCircuit(gates);
plot(c)
s = simulate(c);
[states,P] = querystates(s);
probability(s,1,"1")
histogram(s)
%%
f=0:0.05:2;

gates = [ryGate(1,0.5*pi); ryGate(2,0.5*pi); ...
         cryGate(1,2,0.3*pi)];
c = quantumCircuit(gates);
s = simulate(c);
%f = formula(s);
%[states,P] = querystates(s);
probability(s,2,"1")
%%
f1=0:0.1:pi;
f2=0:0.1:pi*2;
[X,Y]=meshgrid(f1,f2);
P1=zeros(length(f2),length(f1));
for k=1:length(f1)
    for l=1:length(f2)
        gates = [ryGate(1,pi); ryGate(2,f1(k)); ...
                 cryGate(1,2,f2(l))];        
%        gates = [ryGate(1,0.5*pi); ryGate(2,f1(k)); ...
%                 cryGate(1,2,f2(l))];
        c = quantumCircuit(gates);
        s = simulate(c);
        %f = formula(s);
        %[states,P] = querystates(s);
        P1(l,k)=sqrt(probability(s,2,"1"));
    end
end
figure; surface(X,Y,P1); view(3);
%ylabel('\theta of controlled qubit');
ylabel('rotation angle of control gate \theta (/2)');
xlabel('initial angle of second qubit');
zlabel('Amplitude of second qubit |1>');

%%
%M = randsample(s,50)
%T = table(M.Counts,M.MeasuredStates,VariableNames=["Counts","States"])

%%


i_plotit(0)
i_plotit(0.25)
i_plotit(0.5)
i_plotit(0.75)
i_plotit(1)



function i_plotit(a)
    f1=0:0.15:pi;
    f2=0:0.2:pi*2;
    [X,Y]=meshgrid(f1,f2);
    P1=zeros(length(f2),length(f1));
    for k=1:length(f1)
        for l=1:length(f2)
            gates = [ryGate(1,a*pi); ryGate(2,f1(k)); ...
                     cryGate(1,2,f2(l))];        
            c = quantumCircuit(gates);
            s = simulate(c);
            %f = formula(s);
            %[states,P] = querystates(s);
            P1(l,k)=sqrt(probability(s,2,"1"));
        end
    end
    figure; surface(X,Y,P1); 
    %view(3);
    title(sprintf('%g*pi - initial angle of 1st qubit',a));
    ylabel('rotation angle of control gate \theta (/2)');
    xlabel('initial angle of 2nd qubit');
    zlabel('Amplitude of 2nd qubit |1>');
    c=colorbar;
    c.Label.String = 'Amplitude of 2nd qubit |1>';
end