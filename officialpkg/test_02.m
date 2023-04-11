%%
close all
    figure; 
        g = [ryGate(1,0.5*pi); ryGate(2,0.5*pi); ...
             cryGate(1,2,0.5*pi)];
        c=quantumCircuit(g);
        plot(c)
        s = simulate(c);
        a=sqrt(probability(s,2,"1"));
        

%%
figure;

i_plotit(0,1)
i_plotit(0.25,2)
i_plotit(0.5,3)
i_plotit(0.75,4)
i_plotit(1,5)



function i_plotit(a,id)
    f2=0:0.15:pi;
    f1=-pi:0.2:pi;
    [X,Y]=meshgrid(f1,f2);
    Z=zeros(length(f2),length(f1));
    for k=1:length(f2)
        for l=1:length(f1)
            gates = [ryGate(1,a*pi); ryGate(2,f2(k)); ...
                     cryGate(1,2,f1(l))];
            c = quantumCircuit(gates);
            s = simulate(c);
            %f = formula(s);
            %[states,P] = querystates(s);
            Z(k,l)=sqrt(probability(s,2,"1"));
        end
    end
    subplot(3,2,id)
    surface(X,Y,Z); 
    %view(3);
    t=sprintf('Angle of 1st qubit, $\\phi_{1} = %g\\pi$',a);
    title(t,'FontSize',15,...
        'Interpreter','latex');
    xlabel('Rotation angle of control gate \theta');
    ylabel('\phi_{2}, angle of 2nd qubit');
    zlabel('Amplitude of 2nd qubit |1>');
    xlim([min(X(:)) max(X(:))])
    ylim([min(Y(:)) max(Y(:))])
    c=colorbar;
    c.Label.String = 'Amplitude of 2nd qubit |1>';
end