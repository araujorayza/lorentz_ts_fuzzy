clear all;
close all;
clc;

param=[10.5; 29.4; 2.8]; %[sigma,r,b]

ulim=[-60,60];
vlim=[-80,60];
wlim=[-60+5/4*param(2),80+5/4*param(2)];
% using the change of variables: x=u, v=y, z=w-5/4*r


InitSTATE=[20;-70;40+5/4*param(2)];
t=0:0.001:30;

options = odeset('RelTol',1e-13,'AbsTol',1e-13);

[t_nl,STATE_NL] = ode45(@(t,y_var) lorentz_nonlinear(t,y_var,param),t,InitSTATE,options);
[t_ts,STATE_TS] = ode45(@(t,y_var) lorentz_TSFuzzy(t,y_var,param),t,InitSTATE,options);


figure(1)
plot(t_ts,STATE_TS(:,1),'-k')
hold on
plot(t_nl,STATE_NL(:,1),'-r')
title('u x t')

figure(2)
plot(t,STATE_TS(:,2),'-k')
hold on
plot(t,STATE_NL(:,2),'-r')
title('v x t')

figure(3)
plot(t,STATE_TS(:,3),'-k')
hold on
plot(t,STATE_NL(:,3),'-r')
title('w x t')


