% measurement(:,2);
% % Output
% y = r-e;
% 
% % Plot the measurement
% figure(1); clf(1);
% stairs(r); hold on; stairs(e);
% xlabel('Time [s]'); ylabel('Signal [rad,rad]');

%% Calculate errors

% load error and reference terms
% load('Session_02_Nov/Performance_measurements/Region_1/reduced_gain_to_0.06.mat')
% load('Session_02_Nov/Performance_measurements/Region_1/added_notch_at_3.46.mat')
% load('Session_02_Nov/Performance_measurements/Region_1/added_integrator.mat')
% load('Session_02_Nov/Performance_measurements/Region_1/reverted_feedforward.mat')
% load('Session_02_Nov/Performance_measurements/Region_1/ref_v3_saviour_of_us_all.mat')
% load('Session_02_Nov/Performance_measurements/Region_1/ref_v3_take_2.mat')
% load('Session_10_Nov/Performance_measurements/Region_1/K_fc_0.0066_0.0064_and_K_fa_0.000269_0.000276_.mat')
% load('Session_10_Nov/Performance_measurements/Region_1/K_fc_0.0066_0.0064_and_K_fa_0.000267_0.000276_new_ref_error_only.mat')

load('Session_10_Nov/Performance_measurements/Region_2/K_fc_0.0066_0.0064_and_K_fa_0.000267_0.000276_with_ref.mat')
load('Session_10_Nov/Performance_measurements/Region_2/K_fc_0.0066_0.0064_and_K_fa_0.000267_0.000276_v4.mat')

Region=2;
time_period = [11.98, 10.98, 9.98];
max_error = [12, 6.3, 6.3];

period = 0;
% Cut reference to single period: 11.973
start = 1+period*4000*time_period(Region);
cut_point = (period+1)* 4000*time_period(Region); % sampling frequency*time

e = error(start:cut_point);
r = reference(start:cut_point);


% cut signal to one period

[rmax, idx_middle] = max(r);
rforward = r(1:idx_middle);
rbackward = r(idx_middle:end);

forward_range = find(rforward>2.5 & rforward<122.5); % constant velocity range
forward_RMS = rms(e(forward_range));
forward_peak = max(abs(e(forward_range)));

backward_range = find(rbackward>=2.5 & rbackward<=122.5); % constant velocity range
backward_RMS = rms(e(backward_range));
backward_peak = max(abs(e(backward_range)));

% display final values in mrad
RMS_error = 0.5*(forward_RMS+backward_RMS)*1000
Peak_error = max(forward_peak, backward_peak)*1000


fs=4000;
Time = 0:1/fs:(length(e)-1)/fs;

maxerror = zeros(1,length(e));
maxerror(r>=2.5 & r<=122.5) = max_error(Region);
neg_maxerror = -maxerror;

plot(Time, e*1000); hold on; grid on;
plot(Time, [maxerror; neg_maxerror], 'g--', Linewidth=1.5); hold off;
xlim([0, time_period(Region)]);
legend(["error signal", "max allowable peak error"]);
xlabel("Time [s]"); ylabel("Error [mrad]");
% plot(Time, neg_maxerror);



