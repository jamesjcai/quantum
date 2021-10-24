% ref: https://www.youtube.com/watch?v=qysCuvPdX6E
X=[0 1; 1 0]; Z=[1 0; 0 -1]; Y=1i*X*Z;
H=(1/sqrt(2))*(X+Z);
%H=(X+Z)./vecnorm(X+Z);

ket0=[1;0];
%ket0=[0.5;-0.25i];
%ket0=ket0./norm(ket0);
ket1=[0;1];

plotBlochShphere
ket2bv(ket0)
ket2bv(ket1)
plotBlochVect(H*ket0)

function rho = ket2dm(ket)
    % convert ket to a density matrix rho
    rho=ket*ket';
end

function lambda = ket2bv(ket)
    rho=ket2dm(ket);
    X=[0 1; 1 0]; Z=[1 0; 0 -1];
    Y=1i*X*Z;
    lambda=[trace(X*rho); trace(Y*rho); trace(Z*rho)];
end

function plotBlochVect(ket)
    lambda =ket2bv(ket);
    someBV=line([0 lambda(1)],[0 lambda(2)],[0 lambda(3)],...
        'marker','o','linewidth',2); 
end

function plotBlochShphere
[X,Y,Z] = sphere(50);
f=surf(X,Y,Z,'FaceColor',[.5 .5 .5],...
    'LineStyle','none','EdgeColor','none');
axis equal
% shading interp
% colormap gray    
f.FaceAlpha = 0.25;
line([-1 1], [0 0], [0 0],'color','k')
line([0 0],[-1 1],[0 0],'color','k')
line([0 0],[0 0],[-1 1],'color','k')
text(0,0,1.1,"$\left| 0 \right>$",'Interpreter','latex')
text(1.1,0,0,"$\left| + \right>$",'Interpreter','latex')
text(-1.1,0,0,"$\left| - \right>$",'Interpreter','latex')
text(0,0,-1.1,"$\left| 1 \right>$",'Interpreter','latex')
text(0,-1.1,0,"$\left| -i \right>$",'Interpreter','latex')
text(0,1.1,0,"$\left| i \right>$",'Interpreter','latex')
view([60 15])
end