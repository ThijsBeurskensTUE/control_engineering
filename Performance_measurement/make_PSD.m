
nfft = 10000;
[PSD, F] = cpsd(e, e, hann(nfft), 0.5*nfft, nfft, 4000);
semilogx(F,PSD)