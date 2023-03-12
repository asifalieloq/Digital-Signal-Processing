
close all; clc
wc = pi/2; M = 33; L = M + 1; % lowpass filter
hd = ideallp(wc,M);
%% Part a
% h = h.*rectwin(M+1); delw = 1.8;
% h = h.*bartlett(M+1); delw = 6.1;
% h = h.*hann(M+1); delw = 6.2;
% h = h.*hamming(M+1); delw = 6.6;
h = hd.*blackman(M+1); delw = 11;
w = linspace(0,1,1000)*pi;
H = freqz(h,1,w);
Hmag = abs(H);
Hdb = 20*log10(Hmag./max(Hmag));
[peakH peakHind] = findpeaks(Hdb);
Lshind = w(peakHind) > wc;
As = max(peakH(Lshind))
bandwid = delw*pi/L
%% Part (b)
beta = 1:9; Nbeta = length(beta);
As_kaiser = zeros(1,Nbeta);
bandwid_kaiser = zeros(1,Nbeta);
for ii = 1:Nbeta
hk = hd.*kaiser(L,beta(ii));
Hk = freqz(hk,1,w);
Hkmag = abs(Hk);
Hkdb = 20*log10(Hkmag./max(Hkmag));
[peakHk peakHkind] = findpeaks(Hkdb);
Lshind = w(peakHkind) > wc;
As_kaiser(ii) = abs(max(peakHk(Lshind)));
bandwid_kaiser(ii) = (As_kaiser(ii)-8)/M/2.285;
end
% Plot:
plot(bandwid_kaiser,As_kaiser,'.-b'); hold on
xlabel('Transition Bandwidth')
ylabel('A_s (dB)')
% title('Magnitude Response (dB)','fontsize',TFS);
fw.name = {'Rectangular','Bartlett','Hann','Hamming','Blackman'};
fw.As = [21 26 44 53 74];
fw.bw = [1.8 6.1 6.2 6.6 11]*pi/L;
for jj = 1:5
plot(fw.bw(jj),fw.As(jj),'s-k')
text(fw.bw(jj),fw.As(jj),[' ',fw.name{jj}])
end
ylim([10 100]); xlim([0.1 1.2])