Theta=0:0.01:1;
q=[1 0]';
p=zeros(size(Theta));
for k=1:length(Theta)
    theta=Theta(k)*pi;
    RY=[cos(theta/2) -sin(theta/2); sin(theta/2) cos(theta/2)];    
    f=(RY*q).^2;
    p(k)=f(2);
end

figure;
plot(p,2*Theta);
hold on
% plot(p,asin(sqrt(p))*(2/pi),'x')
plot(p,4*asin(sqrt(p))/pi)
xlabel('Expected P (% of expressed cells)')
ylabel('Value of parameter \theta for RY gate')
