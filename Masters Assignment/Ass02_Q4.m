% P1064: Multiband filter design; All methods
close all; clc
%% Specification:
wp1 = 0.2*pi; ws1 = 0.25*pi; ws2 = 0.45*pi;
wp2 = 0.55*pi; wp3 = 0.7*pi; wp4 = 0.75*pi;
G1 = 2; G2 = 0; G3 = 3; G4 = 1;
deltap1 = 0.2; deltas = 0.05; deltap2 = 0.3; deltap3 = 0.1;
delta = min([deltas deltap1 deltap2 deltap3]);
A = -20*log10(delta);
wlp = (wp1+ws1)/2; wbp1 = (wp2+ws2)/2; wbp2 = (wp3+wp4)/2;
whp = wbp2;
delw = 0.05*pi;
%% Part a: Fixed window
L = ceil(6.2*pi/delw); Mfw = L - 1;
if mod(Mfw,2) == 1
Mfw = Mfw + 1;
end
hfw1 = fir1(Mfw,wlp/pi,hann(Mfw+1));
hfw2 = fir1(Mfw,[wbp1 wbp2]/pi,'DC-0',hann(Mfw+1));
hfw3 = fir1(Mfw,whp/pi,'high',hann(Mfw+1));
hfw = G1*hfw1 + G3*hfw2 + G4*hfw3;
%% Part b: Kaiser window
[Mk,wn,beta,ftype] = ...
kaiserord([ws2 wp2 wp3 wp4]/pi,[0 1 0],...
[deltas,deltap2,deltas/2]);
if mod(Mk,2)==1
Mk = Mk + 1;
end
hkai1 = fir1(Mk,wlp/pi,kaiser(Mk+1,beta));
hkai2 = fir1(Mk,[wbp1 wbp2]/pi,'DC-0',kaiser(Mk+1,beta));
hkai3 = fir1(Mk,whp/pi,'high',kaiser(Mk+1,beta));
hkai = G1*hkai1 + G3*hkai2 + G4*hkai3;
%% Part c: Frequency sampling
% Mfs = 70;
Mfs = 60;
L = Mfs + 1;
hfs = fir2(Mfs,[0 wp1 ws1 ws2+0.005*pi wp2 wp3 wp4 pi]/pi,...
[G1 G1 G2 G2 G3 G3 G4 G4],rectwin(L));
%% Part d: Parks-McClellan
[Mpm,fo,ao,W] = firpmord([wp1,ws1,ws2,wp2,wp3,wp4]/pi,[G1,G2,G3,G4],...
[deltap1,deltas, deltap2,deltap3]);
Mpm = Mpm + 14
[hpm,delta] = firpm(Mpm,fo,ao,W);
delta,
deltap1,
%% Plot:
hp = hfw; M = Mfw; Method = 'Hann'; % Part a
% hp = hkai; M = Mk; Method = 'Kaiser'; % Part b
% hp = hfs; M = Mfs; Method = 'Frequency Sampling'; % Part c
% hp = hpm; M = Mpm; Method = 'Parks McCllelan';% Part d
w = linspace(0,1,1000)*pi;
[Ha wt P2 L2] = amplresp(hp(:)',w);
plot(w/pi,Ha,'linewidth',2);
ylim([-0.1 G3+0.4])
xlabel('\omega/\pi')
ylabel('Amplitude')
title('Amplitude Response')
set(gca,'XTick',[0 wp1 ws1 ws2 wp2 wp3 wp4 pi]/pi)
set(gca,'YTick',[-deltas deltas G4-deltap3 G4+deltap3...
G1-deltap1 G1+deltap1 G3-deltap2 G3+deltap2])
grid on
%% Part e:
legend([Method,', M = ',num2str(M)],'location','northwest')
ind = w <= wp1;
d1 = max(abs(Ha(ind)-G1));
text(w(100)/pi,G1+0.15,['\delta_{p1} = ',num2str(d1,'%.3f')])
ind = (w>=ws1 & w <= ws2);
d2 = max(abs(Ha(ind)));
text(w(350)/pi,deltas,['\delta_{s1} = ',num2str(d2,'%.3f')])
ind = (w>=wp2 & w <= wp3);
d3 = max(abs(Ha(ind)-G3));
text(w(625)/pi,G3+0.15,['\delta_{p2} = ',num2str(d3,'%.3f')])
ind = w >= wp4;
d4 = max(abs(Ha(ind)-G4));
text(w(875)/pi,G4+0.15,['\delta_{p3} = ',num2str(d4,'%.3f')])
ind1 = Ha<G1-deltap1;
ind2 = (w > wp1 & w < ws1);
ind = ind1(:) & ind2(:);
f1 = find(ind==1,1,'first')-1;
ind1 = Ha>deltas;
ind2 = (w > wp1 & w < ws1);
ind = ind1(:) & ind2(:);
f2 = find(ind==1,1,'last')+1;
ind1 = Ha>deltas;
ind2 = (w > ws2 & w < wp2);
ind = ind1(:) & ind2(:);
f3 = find(ind==1,1,'first')-1;

ind1 = Ha<G3-deltap2;
ind2 = (w > ws2 & w < wp2);
ind = ind1(:) & ind2(:);
f4 = find(ind==1,1,'last')+1;

ind1 = Ha<G3-deltap2;
ind2 = (w > wp3 & w < wp4);
ind = ind1(:) & ind2(:);
f5 = find(ind==1,1,'first')-1;

ind1 = Ha>G4+deltap3;
ind2 = (w > wp3 & w < wp4);
ind = ind1(:) & ind2(:);
f6 = find(ind==1,1,'last')+1;
