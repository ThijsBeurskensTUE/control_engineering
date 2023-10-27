% Copyright (C) 2021 Max van Meer
% see www.maxvanmeer.nl for contact details
%
% Control Systems Technology group
% Departement of Mechanical Engineering
% Eindhoven University of Technology
% 
% SPERTE is licensed under the GNU GPLv3

% How many samples to measure?
N_samples = 60e3; % at 4khz, that allows for 15s of data (12s performance region plus some buffer)

% Model should be Reference_model_Control_Engineering or change it if you renamed the
% model
ModelName = 'Reference_model_Control_Engineering';
% Check if the model is running, makes no sense to measure otherwise.
if ~strcmp(get_param(ModelName,'SimulationStatus'),'external')
   warning('The model is not running, can not perform a measurement.');
   return
end

fprintf(['Starting measurement without white noise on the disturbance.\n',...
    'If you are planning on doing an FRF measurement, use the original script.\n' ...
    'This script is meant for measuring system performace']);

% Get the reference block
BlockPaths = find_system(ModelName);
% Get the correct string
Ref_switch = find(contains(BlockPaths,'Ref power'));
% If we have more than 1 index, this means duplicate blocks, should not
% happen! Give a warning, and then try to trigger the first.
if length(Ref_switch) > 1
    warning('There appear to be duplicate noise blocks in your model. Please remove all duplicate blocks.');
    Ref_switch = Ref_switch(1);
end


% Do the measurement
% How many signals do you need to record?
N_signals = 2;
measurement = SPERTE_Measure_And_Collect(p,N_signals,N_samples,ModelName);
pause(0.1);


% Start turning on the reference
set_param(BlockPaths{Ref_switch},'Switch','On');
pause(0.1);

% Turn off the noise
set_param(BlockPaths{Ref_switch},'Switch','Off')

% Make sure the two signals being logged into the Measurement Block 
% are r, e and y
% Reference
r = measurement(:,1);
% Error
e = measurement(:,2);
% Output
y = r-e;

% Plot the measurement
figure(1); clf(1);
stairs(r); hold on; stairs(e);
xlabel('Time [s]'); ylabel('Signal [rad,rad]');

%% Calculate errors

% cut away parts where the reference is 0:
e = e(y>0);
r = r(y>0);
y = y(y>0);

[rmax, idx_middle] = max(r);
rforward = r(:idx_middle);
rbackward = r(idx_middle:);

forward_range = find(rforward>=2.5 & rforward<=122.5); % constant velocity range
forward_RMS = sqrt(1/length(forward_range) * sum(e(forward_range).^2))
forward_peak = max(abs(e(forward_range)))

backward_range = find(rbackward<=125 & r>=2.5); % constant velocity range
backward_RMS = sqrt(1/length(backward_range) * sum(e(backward_range).^2))
backward_peak = max(abs(e(backward_range)))

Duration = length(y)/4000 % 0 to 0



