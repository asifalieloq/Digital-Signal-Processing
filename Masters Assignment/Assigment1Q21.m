clear all; close all; clc;
n = 0:50; a = 0.9;
xn =8*(0.9).^n + 2*(n - 1).*(0.9).^n; %0.25.*a.^n+0.25.*(-a).^n+0.5.*(-a).^n;
bx = [1]; 
ax = conv(conv([1 -0.9],[1 0.9]),[1 -0.9]);
zplane(bx,ax); grid; figure;
xnz = filter(bx,ax,[1,zeros(1,length(n)-1)]);
stem(n,xn,'filled'); grid;
xlabel('Time Index n','fontsize',14);
ylabel('x[n]','fontsize',14);
hold on;
stem(n,xnz,'rx');
xlabel('Time Index n','fontsize',14);
ylabel('x[n]','fontsize',14);
title('Sequence Computed from ztransform','fontsize', 18);
legend({'x(n)','z^{-1}\{X(z)\}'},'fontsize', 25);
sum(xn-xnz)
