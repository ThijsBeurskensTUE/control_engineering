% measurement(:,2);
% % Output
% y = r-e;
% 
% % Plot the measurement
% figure(1); clf(1);
% stairs(r); hold on; stairs(e);
% xlabel('Time [s]'); ylabel('Signal [rad,rad]');

%% Calculate errors

% cut away parts where the reference is 0:
e = e(y>0);
r = r(y>0);
y = y(y>0);

[rmax, idx_middle] = max(r);
rforward = r(1:idx_middle);
rbackward = r(idx_middle:end);

forward_range = find(rforward>=2.5 & rforward<=122.5); % constant velocity range
forward_RMS = sqrt(1/length(forward_range) * sum(e(forward_range).^2))
forward_peak = max(abs(e(forward_range)))

backward_range = find(rbackward<=125 & r>=2.5); % constant velocity range
backward_RMS = sqrt(1/length(backward_range) * sum(e(backward_range).^2))
backward_peak = max(abs(e(backward_range)))

Duration = length(y)/4000 % 0 to 0



