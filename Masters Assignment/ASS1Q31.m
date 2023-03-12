clear all; close all; clc;
n = 0:40; 
b = [0 1 1]; a = [1 -0.9 0.81];
[res pol c] = residuez(b,a)
r = abs(pol(1)), w0 = angle(pol(1)) 
A = abs(res(1)), theta = angle(res(1)) * 57.3
xn= 2*(A).*(r).^n.*cos(w0*n+theta);

zplane(b,a); grid; figure;
xnz = filter(b,a,[1,zeros(1,length(n)-1)]);
stem(n,xn,'filled'); grid;
xlabel('Time Index n','fontsize',14);
ylabel('x[n]','fontsize',14); 
hold on;
stem(n,xnz,'rx');
impz(b,a)
xlabel('Time Index n','fontsize',14);
ylabel('x[n]','fontsize',14);
title('Sequence Computed from ztransform','fontsize', 18);
legend({'x(n)','z^{-1}\{X(z)\}'},'fontsize', 25);
sum(xn-xnz)


