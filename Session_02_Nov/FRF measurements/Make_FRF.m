
load('FRF measurements/measurement_0.mat')

nfft = 10000; 

[FRF, F] = tfestimate(result(:,1), result(:,2), hann(nfft), 0.5*nfft, nfft, 4000);
subplot(3,1,1);
semilogx(F, 20*log(abs(FRF))); grid on;

subplot(3,1,2);
semilogx(F, rad2deg(angle(FRF)))

subplot(3,1,3);
[Coherence, F] = mscohere(result(:,1), result(:,2), hann(nfft), 0.5*nfft, nfft, 4000);
semilogx(F, Coherence)