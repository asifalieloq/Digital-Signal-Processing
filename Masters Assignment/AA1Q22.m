clear all; close all; clc;
% Verification of z-transform expression of a causal sequence using filter().
n = 0:40; a = 0.58;
% 
xn= 2*(1.118).*(0.8).^n.*cos(0.7854*n-63.4396);
bx = [1 0.4*sqrt(2)]; 
ax = [1 -0.8*sqrt(2) 0.64]
[r p c]=residuez(bx,ax)

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