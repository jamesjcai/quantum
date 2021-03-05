% https://www.mathworks.com/matlabcentral/answers/506168-how-to-plot-euler-formula-in-matlab

t = linspace(0,2);
y = exp(100*i*pi*t)
y = cos(100*pi*t)+j*sin(100*pi*t);

figure
plot(t, real(y),    t, imag(y))
grid

