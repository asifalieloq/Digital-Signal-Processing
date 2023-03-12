close all; clc
%% Specification:
Fs = 1e3; T = 1/Fs;
n = 0:200; nT = n*T;
xn = 5*cos(400*pi*nT)+10*sin(500*pi*nT);
w1 = 400*pi/Fs; w2 = 500*pi/Fs;
Ap = 1; As = 50;
deltap = (10^(Ap/20)-1)/(10^(Ap/20)+1);
deltas = (1+deltap)/(10^(As/20));
delta = min([deltap,deltas]);
A = -20*log10(delta);
wc = (w1+w2)/2;
delw = w2-w1;
%% Part a: Fixed window
L = 6.6*pi/delw; Mfw = L - 1;
hd = ideallp(wc,Mfw);
hfw = hd.*hamming(Mfw+1);
%% Part b: Kaiser window
[Mk,wn,beta,ftype] = ...
kaiserord([w1 w2]/pi,[1 0],[deltap,deltas]);
hkai = fir1(Mk,wc/pi,kaiser(Mk+1,beta));
%% Part c: Parks-McClellan
[Mpm,fo,ao,W] = firpmord([w1,w2]/pi,[1,0],[deltap,deltas]);
Mpm = Mpm + 2
[hpm,delta] = firpm(Mpm,fo,ao,W);
delta,
deltap,

%% Plot:
%  hp = hfw; M = Mfw; Method = 'Hamming'; % Part a
%  hp = hkai; M = Mk; Method = 'Kaiser'; % Part b

hp = hpm; M = Mpm; Method = 'Parks McCllelan';% Part c
w = linspace(0,1,1000)*pi;
H = freqz(hp,1,w);
Hmag = abs(H);
Hdb = 20*log10(Hmag/max(Hmag));
[Ha wt P2 L2] = amplresp(hp(:)',w);

aperr = nan(1,length(w));
magz1 = nan(1,length(w));
magz2 = nan(1,length(w));
ind = w <= w1;
aperr(ind) = Ha(ind) - 1;
magz1(ind) = Hdb(ind);
ind = w >= w2;
aperr(ind) = Ha(ind);
magz2(ind) = Hdb(ind);
yn = filter(hp,1,xn);
subplot(321)
stem(0:M,hp,'filled');
xlim([0 M])
xlabel('n')
ylabel('h(n)')
title('Impulse Response')
subplot(322)
plot(w/pi,Ha);
ylim([-0.1 1.1])
xlabel('\omega/\pi')
ylabel('Amplitude')
title('Amplitude Response')
subplot(323)
plot(w/pi,Hdb);
ylim([-80 0])
xlabel('\omega/\pi')
ylabel('Decibels')
title('Magnitude Response (dB)')
legend([Method,', M = ',num2str(M)],'location','northeast')
subplot(324)
plot(w/pi,aperr);
xlabel('\omega/\pi')
ylabel('Amplitude')
title('Approximation Error')
[AX hf1 hf2] = plotyy(w/pi,magz1,w/pi,magz2);
set(AX(2),'ylim',[-100 0])
xlabel('\omega/\pi')
title('Zoom of Magnitude Response (dB)')
set(get(AX(1),'Ylabel'),'string','Passband dB')
set(get(AX(2),'Ylabel'),'string','Stopband dB')
subplot(325)
plot(n,xn,n,yn)
xlabel('n')
title('Time Sequences')
legend('input','output','location','best')