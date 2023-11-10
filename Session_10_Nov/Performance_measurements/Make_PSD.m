load('Session_02_Nov/Performance_measurements/Region_1/initial_feedback_without_feedforward.mat')
error1=error(reference>=2.5 & reference<=122.5);
load('Session_02_Nov/Performance_measurements/Region_1/initial_feedback_with_feedforward.mat')
error2=error(reference>=2.5 & reference<=122.5);
load('Session_02_Nov/Performance_measurements/Region_1/reduced_gain_to_0.06.mat')
error3=error(reference>=2.5 & reference<=122.5);
legend_text = ["Initial controller", "Feedforward action", "Gain reduced"];
% 
% load('Session_02_Nov/Performance_measurements/Region_1/added_notch_at_3.46.mat')
% error1 = error(reference>=2.5 & reference<=122.5);
% load('Session_02_Nov/Performance_measurements/Region_1/added_integrator.mat')
% error2 = error(reference>=2.5 & reference<=122.5);
% load('Session_02_Nov/Performance_measurements/Region_1/longer_constant_velocity.mat')
% error3 = error(reference>=2.5 & reference<=122.5);
% legend_text = ["Notch filter at 3.46Hz", "Integrator action", "Change in reference"];

load('Session_10_Nov/Performance_measurements/Region_1/K_fc_0.0066_0.0064_and_K_fa_0.000269_0.000276_.mat')
error1=error;
nfft = 10000; 

cell = {error1, error2, error3};

figure;
for i=[1]
    error = cell{i};
    [PSD, F] = cpsd(error, error, hann(nfft), 0.5*nfft, nfft, 4000);
    subplot(3,1,1);
    semilogx(F, 10*log10(abs(PSD)), LineWidth=2); grid on; hold on;
    title('Power spectral density of error')
    ylabel('[10log(rad^2/Hz)]');
    xlim([0.4 2000])
    
    subplot(3,1,2);
    Cumulative_PSD = sqrt(cumtrapz(F, PSD));
    semilogx(F, Cumulative_PSD, LineWidth=2); hold on;grid on; 
    title('Cumulative amplitude spectrum')
    ylabel('RMS error [rad]')
    xlim([0.4 2000])
    
    subplot(3,1,3);
    Reverse_cumulative_PSD = flip(sqrt(cumtrapz(F,flip(PSD))));
    semilogx(F, Reverse_cumulative_PSD, LineWidth=2); hold on;grid on; 
    title('Reverse amplitude power spectrum')
    ylabel('RMS error [rad]')
    xlim([0.4 2000])
end


subplot(3,1,1);
legend(legend_text)
subplot(3,1,2);
legend(legend_text)
subplot(3,1,3);
legend(legend_text)
