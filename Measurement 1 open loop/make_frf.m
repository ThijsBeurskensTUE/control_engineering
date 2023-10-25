nfft = 10000; % average across 60 frames with 50% overlap
figure
hold on
subplot(3,1,1);
[TF,F]=tfestimate(measurement(:,1), measurement(:,2), hann(nfft), 0.5*nfft, nfft, 1/Ts);
semilogx(F, 20*log10(abs(TF)));
subplot(3,1,2);
semilogx(F, rad2deg(angle(TF)));

subplot(3,1,3);
[Coherence,F] = mscohere(measurement(:,1), measurement(:,2), hann(nfft), 0.5*nfft, nfft, 1/Ts);%Ts = 2.5*10^-4
semilogx(F, Coherence);