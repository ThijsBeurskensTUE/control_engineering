% load('Session_02_Nov/Performance_measurements/Region_1/initial_feedback_without_feedforward.mat')
% error_no_feedforward=error;
load('Session_02_Nov/Performance_measurements/Region_1/initial_feedback_with_feedforward.mat')
error_feedforward=error;
load('Session_02_Nov/Performance_measurements/Region_1/reduced_gain_to_0.06.mat')
new_error=error;

nfft = 10000; 

cell = {error_feedforward, new_error};

figure;
for i=[1,2]
    error = cell{i};
    [PSD, F] = cpsd(error, error, hann(nfft), 0.5*nfft, nfft, 4000);
    subplot(3,1,1);
    semilogx(F, 20*log(abs(PSD))); grid on; hold on;
    
    ylabel('PSD')
    xlim([0.4 2000])
    
    subplot(3,1,2);
    Cumulative_PSD = cumsum(PSD);
    semilogx(F, Cumulative_PSD); hold on;
    
    ylabel('Cumulative PSD')
    xlim([0.4 2000])
    
    subplot(3,1,3);
    Reverse_cumulative_PSD = cumsum(flip(PSD));
    semilogx(F, Cumulative_PSD.^-1); hold on;
    
    ylabel('Reverse Cumulative PSD')
    xlim([0.4 2000])
end
