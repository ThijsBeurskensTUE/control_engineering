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


period = 0;
% Cut reference to single period: 11.973
start = 1+period*4000*11.973;
cut_point = (period+1)* 4000*11.973; % sampling frequency*time

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
maxerror(r>=2.5 & r<=122.5) = 12e-3;
neg_maxerror = -maxerror;

plot(Time, e); hold on; grid on;
plot(Time, maxerror);
plot(Time, neg_maxerror);



