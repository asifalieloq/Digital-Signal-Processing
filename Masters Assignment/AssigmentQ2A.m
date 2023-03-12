% b = [1];
% a = conv([1 -0.9],[1 0.9]);
% c = conv(a,[1 0.9]);
% [r p c] = residuez(b,c)
% zplane(b,c); grid;

b = [1 -0.8*sqrt(2) 0.64];

c=roots(b)

% Pole Magnitude
RC = abs(c)
% Pole angles in Pi Units
AR = angle(c) / pi
% 
% b = [1 0.4*sqrt(2)]; a = [1 -0.8*sqrt(2) 0.64];
% [r p c] = residuez(b,a)
% % Pole Magnitude
% Mp = abs(p)
% % Pole angles in Pi Units
% Ap = angle(p) / pi
% 
% % Pole Magnitude
% RC = abs(p)
% % Pole angles in Pi Units
% AR = angle(p) / pi
