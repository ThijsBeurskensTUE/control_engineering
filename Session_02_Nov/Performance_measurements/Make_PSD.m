
load('FRF measurements/measurement_0.mat')
%%
nfft = 10000; 

figure;
[PSD, F] = cpsd(result(:,1), result(:,1), hann(nfft), 0.5*nfft, nfft, 4000);
subplot(3,1,1);
ylabel('PSD')
semilogx(F, 20*log(abs(PSD))); grid on;

subplot(3,1,2);
ylabel('Cumulative PSD')
Cumulative_PSD = cumsum(PSD);
semilogx(F, Cumulative_PSD)

subplot(3,1,3);
Reverse_cumulative_PSD = cumsum(flip(PSD));
ylabel('Reverse Cumulative PSD')
semilogx(F, Reverse_cumulative_PSD)

