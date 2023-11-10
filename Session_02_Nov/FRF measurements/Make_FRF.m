
load('FRF measurements/measurement_0.mat')

nfft = 10000; 

[FRF, F] = tfestimate(result(:,1), result(:,2), hann(nfft), 0.5*nfft, nfft, 4000);
% FRF=-FRF;
subplot(3,1,1);
semilogx(F, 20*log10(abs(FRF))); grid on;
ylabel("Magnitude [dB]");
% title("Gain");
% xlabel("Frequency [Hz]");

subplot(3,1,2);
semilogx(F, rad2deg(angle(FRF)))
% title("Phase")
ylabel("Phase [degrees]");grid on;
% xlabel("Frequency [Hz]");

subplot(3,1,3);
[Coherence, F] = mscohere(result(:,1), result(:,2), hann(nfft), 0.5*nfft, nfft, 4000);
semilogx(F, Coherence)
ylabel("Coherence");grid on;
% title("Coherence")
xlabel("Frequency [Hz]");