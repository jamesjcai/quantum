g=Gates;
q=Qubits;

% a=0:0.05:1;
% b=2*acos(sqrt(a));

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
        d1(k,l)=x(1);
        d2(k,l)=x(2);
        d3(k,l)=x(3);
        d4(k,l)=x(4);
    end
end

%%
% figure('position', round(1.75 * [0 0 560 420]));
figure('position', round([0 0 560*4 420]));
subplot(141)
plotheat(d1,'00')
subplot(142)
plotheat(d2,'01')
subplot(143)
plotheat(d3,'10')
subplot(144)
plotheat(d4,'11')

function plotheat(d4,txt)
    b=-pi:0.15:pi;
    [X,Y] = meshgrid(b);
    s=mesh(X,Y,d4);
    s.FaceColor = 'flat';
    xticks([-pi, -3*pi/4 -0.5*pi, -pi/4, 0, pi/4, 0.5*pi, 3*pi/4, pi])
    xticklabels({'-\pi','-3\pi/4','-\pi/2','-\pi/4','0','\pi/4','\pi/2','3\pi/4','\pi'});
    yticks([-pi, -3*pi/4 -0.5*pi, -pi/4, 0, pi/4, 0.5*pi, 3*pi/4, pi])
    yticklabels({'-\pi','-3\pi/4','-\pi/2','-\pi/4','0','\pi/4','\pi/2','3\pi/4','\pi'});

    %yticks([-pi, -0.5*pi, 0, 0.5*pi, pi])
    %yticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
    %a = get(gca,'XTickLabel');  
    %set(gca,'XTickLabel',a,'fontsize',15)

    zlabel('Probability')
    xlabel('\bf{\theta}','FontSize',18)
    ylabel('\bf{\theta''}','FontSize',18)
    title(txt)
    xline(0,'m-'); 
    yline(0,'m-');
    xline([-pi, -3*pi/4 -0.5*pi, -pi/4, 0, pi/4, 0.5*pi, 3*pi/4, pi],'w:');
    yline([-pi, -3*pi/4 -0.5*pi, -pi/4, 0, pi/4, 0.5*pi, 3*pi/4, pi],'w:');
    view(2); colorbar;
    xlim([-pi pi])
    ylim([-pi pi])
end

%{
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
%}