%% Reference generator
%INPUTS:
% v_stroke  - Constant vel scan stroke
% total_t   - Total time for foward motion
% p_total   - Final position
% vmax      - Max vel. bound
% amax      - Max acc. bound
% amin      - Min acc. bound

% OUTPUT
% Reference.r3g file that can be loaded into the ref3 block
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;

% Set your parameters here
v_stroke = 121;
total_t = 5;
p_total = 125;
vmax = 300;
amax = 1000;
amin = 1;
plt = 1;    % If you don't want to plot the profile, set this to 0

SAVE_NAME = 'Session_02_Nov/References/Ref_region_3.mat';

%% Reference generation. Do not change unless you know what you're doing

%This is the function that works with the given parameters
Ts = 1/4000;
try
    [jj,tx,j,a,v,p,tt,found] = find_ref3(p_total, v_stroke, total_t, vmax, amax, amin, Ts, plt);
catch ME
    fprintf('*** Failed: %s\n  Reconsider given reference bounds...\n', ME.message);
    return;
end
Iend = find(abs(v) <= 1e-10 & abs(a)<=1e-10 & (p == p_total + 1e-10) <= 1e-10 & j==0,1);
t0 = tx(1);
tend = tx(Iend);
p0 = p(1);
pend = p(Iend);
vel = max(v);
acc = max(a);
jerk = max(j);

refdesign = [t0 tend p0 pend vel acc jerk;
    tend 2*tend pend 0 vel acc jerk;
    0 0 0 0 0 0 0];
irow = 3;
irepeat = 1;
if(found)
    save(SAVE_NAME,'irow','refdesign','irepeat')
    file1=SAVE_NAME;
    file2=strrep(file1,'.mat','.r3g');
    copyfile(file1,file2)
end
function [jj,tx,j,a,v,p,tt,found] = find_ref3(p_total, v_stroke, total_t, vmax, amax, amin, Ts, plt)
p = p_total - v_stroke; %distance without constant vel part;
%start iteration variables - acc and jerk
jmin = 1000;
jmax = 20000;
found = false;
j_counter = 0;
j = jmin;
%start iterative search
while ((~found) && (j <= jmax))
    j = jmin + j_counter*20;
    a = amin;
    acc_counter = 0;
    while ((~found) && (a < amax))
        a = amin + 5*acc_counter;
        [t,jd] = make3(p,vmax,a,j,Ts);
        [~,~,~,~,v,~,~]=profile3(t,jd,Ts,0);
        vmax_profile = max(v);
        t3 = v_stroke / vmax_profile;
        t(3) = t3;
        t_max = check_T_total(t);
        if t_max<= total_t
            [jj,tx,j,a,v,p,tt]=profile3(t,jd,Ts,plt);
            found = true;
        else
            acc_counter = acc_counter + 1;
        end
    end
    j_counter =  j_counter + 1;
end
if (found == false)
    warning('Reference not found. Reconsider reference bounds')

elseif (found == true)
    disp('Reference found!')
end
end

function t_max = check_T_total(t)
if length(t)==3
    timevec=   [0 1 1 2 2 3 3 4 ]*t(1) ...
        + [0 0 1 1 1 1 2 2 ]*t(2) ...
        + [0 0 0 0 1 1 1 1 ]*t(3) ;
end
t_max = timevec(end);
end