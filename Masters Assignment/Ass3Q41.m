clear all; close all; clc;

n = [0:100];
b = [1/3 1/3 1/3];
a = [1 -0.95 -0.9025];
yi = [-2 -3];
xi = [1 1];
xn = cos(n*pi/3);
xic = filtic(b,a,yi,xi);
yn2 = filter(b,a,xn,xic);
stem(yn2)