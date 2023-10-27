
nfft = 10000;
APSD = cpsd(, , hann(nfft), 0.5*nfft, nfft, 1/0.001);