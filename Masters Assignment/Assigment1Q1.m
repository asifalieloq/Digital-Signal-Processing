clear all; close all; clc;
% Verification of z-transform expression of a causal sequence using filter().
n = 0:20; a = 0.5;
xn = (n-2).*a.^(n-2).*cos(pi/3.*(n-2));
bx = [0 0 1 -0.25]; ax = [1 -a a];
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