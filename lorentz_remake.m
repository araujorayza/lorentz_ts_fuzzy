clear all;
close all;
clc;

%% System parameters and set Z definition
param=[10; 28; 8/3]; %[sigma,r,b]

xbounds=[-30,30];
ybounds=[-30,30]; 
zbounds=[-60,60];

sigma = param(1);
r = param(2);
b = param(3);

%% Plot 

%Simulation Parameters
InitSTATE=[20;-20;-10];
t=[0 100];

options = odeset('RelTol',1e-13,'AbsTol',1e-13);

%solves the ODE in time interval t
sol_nl = ode45(@(t,y_var) lorentz_nonlinear(t,y_var,param),t,InitSTATE,options);

%recalculates the solution in specific time points
NofPoints=250;
t=linspace(t(1),t(end),NofPoints);
STATE_NL=deval(sol_nl,t);

figure(1)
plot3(STATE_NL(1,:),STATE_NL(2,:),STATE_NL(3,:))
xlim(xbounds)
ylim(ybounds)
zlim(zbounds)