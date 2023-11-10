
load('Session_02_Nov/Feedforward/no_action.mat')
e_no_action = error;

load('Session_02_Nov/Feedforward/Kfc_only(0.0047124).mat')
e_Kfc = error;

load('Session_02_Nov/Feedforward/Kfc(0.0043)Kfv(0.000021).mat')
e_Kfc_v = error;

load('Session_02_Nov/Feedforward/Kfc(0.0043)Kfv(0.000021)Kfa(0.000275).mat')
e_Kfc_v_a = error;


plot(e_no_action); hold on;
plot(e_Kfc);
plot(e_Kfc_v);
plot(e_Kfc_v_a);
plot(acceleration/200)