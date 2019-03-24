function dydt = odefun(t,y,input, numValues, ending)
fit = [-0.0500000000000000,-0.0350000000000000,-0.00650000000000000;54.5000000000000,57,31;81,97.5000000000000,136.500000000000;0.100000000000000,39,21;4.70000000000000,10.5000000000000,11.5000000000000;16,16,18;NaN,0,16.5000000000000;94.5000000000000,NaN,0;0.570000000000000,25.5000000000000,NaN;NaN,81,24.5000000000000;75.5000000000000,NaN,11.5000000000000;0,0,NaN;NaN,1,8.30000000000000;1,NaN,16.6000000000000;8.30000000000000,16.6000000000000,NaN];

% get the correct random number
AAA = input(ceil(t/ending*numValues+1));
% t*numValues

% Empty solution set
dydt = zeros(10,1);
% Empty functions
x = zeros(8,1);

% Constants from table 4
w_e = 75;
w_s = 30;
w_f = 75;
G_e = 5.17;
G_s = 4.45;
G_f = 57.1;
C_ep = 5;
C_pe = 25;
C_sp = 60;
e_0 = 2.5;
r = 0.56;

% Constants from fitting BA 19
C_ps_BA19 = fit(2,1);
C_pf_BA19 = fit(5,1);
C_fp_BA19 = fit(3,1);
C_fs_BA19 = fit(4,1);
C_ff_BA19 = fit(6,1);



% A DEF Pyramidal Neurons C
y_pDt = dydt(1);
x_pDt = dydt(2);

y_p = y(1);
x_p = y(2);

z_p = x(1);
v_p = x(2);

% B DEF Excitatory Neurons C
y_eDt = dydt(3);
x_eDt = dydt(4);

y_e = y(3);
x_e = y(4);

z_e = x(3);
v_e = x(4);

% C DEF Slow Inhibatory Interneurons C
y_sDt = dydt(5);
x_sDt = dydt(6);

y_s = y(5);
x_s = y(6);

z_s = x(5);
v_s = x(6);

% D DEF Fast Inhibatory Interneurons C
y_fDt = dydt(7);
x_fDt = dydt(8);
y_lDt = dydt(9);
x_lDt = dydt(10);

y_f = y(7);
x_f = y(8);
y_l = y(9);
x_l = y(10);

z_f = x(7);
v_f = x(8);

% Generate white noise
% variance = 5;
% AAA = randn(1, 0, variance);
% AAA = sqrt(5)*randn(1,1);
% AAA = 1;

% ODE Pyramidal Neurons
y_pDt = x_p;
x_pDt = G_e*w_e*z_p - 2*w_e*x_p - w_e^2*y_p;
z_p = 2*e_0./(1+exp(-r*v_p)) - e_0;
v_p = C_pe*y_e - C_ps_BA19*y_s - C_pf_BA19*y_f;

% Input noise


% ODE Excitatory Interneurons
y_eDt = x_e;
x_eDt = G_e*w_e*(z_e + AAA/C_pe) - 2*w_e*x_e - w_e^2*y_e;
z_p = 2*e_0./(1+exp(-r*v_e)) - e_0;
v_e = C_ep*y_p;

% ODE Slow Inhibatory Interneurons
y_sDt = x_s;
x_sDt = G_s*w_s*z_s - 2*w_s*x_s - w_s^2*y_s;
z_p = 2*e_0./(1+exp(-r*v_s)) - e_0;
v_e = C_sp*y_p;

% ODE Slow Inhibatory Interneurons
y_fDt = x_f;
x_fDt = G_f*w_f*z_f - 2*w_f*x_f - w_f^2*y_f;
y_lDt = x_l;
x_lDt = G_e*w_e*AAA - 2*w_e*x_l - w_e^2*y_l;
z_f = 2*e_0./(1+exp(-r*v_f)) - e_0;
v_f = C_fp_BA19*y_p - C_fs_BA19*y_s - C_ff_BA19*y_f + y_l;



% put back the solutions
dydt(1) = y_pDt;
dydt(2) = x_pDt;
dydt(3) = y_eDt;
dydt(4) = x_eDt;
dydt(5) = y_sDt;
dydt(6) = x_sDt;
dydt(7) = y_fDt;
dydt(8) = x_fDt;
dydt(9) = y_lDt;
dydt(10) = x_lDt;



end