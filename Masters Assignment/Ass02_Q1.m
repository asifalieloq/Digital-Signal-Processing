
close all; clc
% L = 20; % Part a
L = 40; % Part b & c
M = L - 1;
wp = 0.2*pi; ws = 0.3*pi; Ap = 0.2; As = 40;
wc = (wp+ws)/2;
Dw = 2*pi/L;
alpha = M/2; Q = floor(alpha);
psid = -alpha*2*pi/L*[(0:Q),-(L-(Q+1:M))];
T1 = 0.37897949;

%% Part a:
k = floor(wc/Dw);
Ad = [ones(1,k+1),zeros(1,L-2*k-1),ones(1,k)];
Hd = Ad.*exp(j*psid);
hd = real(ifft(Hd));
h = hd.*rectwin(L)';

%% Part b:
plot(w/pi,Hdb);hold on
plot(w/pi,-40*ones(1,length(w)),'--','color','k')

%% Part c:
k1 = floor(wp/Dw); k2 = ceil(ws/Dw);
Ad = [ones(1,k1+1),T1,zeros(1,L-2*k2+1),T1,ones(1,k1)];
Hd = Ad.*exp(j*psid);
hd = real(ifft(Hd));
h = hd.*rectwin(L)';
figure

%% Part d:
subplot(211)
plot(w/pi,Hdb);hold on
plot(w/pi,-40*ones(1,length(w)),'--','color','k')

%% Part e:
h = fir2(M,[0 wp/pi wc/pi ws/pi 1],[1 1 T1 0 0],rectwin(L));
w = linspace(0,2,1000)*pi;
H = freqz(h,1,w);
Hmag = abs(H);
Hdb = 20*log10(Hmag/max(Hmag));
%% Plot e:
subplot(212)
plot(w/pi,Hdb);hold on
plot(w/pi,-40*ones(1,length(w)),'--','color','k')
ylim([-60 0])
xlabel('\omega/\pi')
ylabel('Magnitude')
title('Magnitude Response')