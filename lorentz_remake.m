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

%% TS FUZZY SYSTEM

A{1}=[-sigma sigma 0;
        r -1 -xbounds(2);
        0 xbounds(2) -b];
A{2}=[-sigma sigma 0;
        r -1 -xbounds(1);
        0 xbounds(1) -b];

h{1} = @(x) (x - xbounds(1))/(xbounds(2)-xbounds(1));
h{2} = @(x) 1-h{1}(x);

% sol_ts = ode45(@(t,y_var) lorentz_TSFuzzy(t,y_var,param),t,InitSTATE,options);
% STATE_TS=deval(sol_ts,t);
% 
% hold on
% plot3(STATE_TS(1,:),STATE_TS(2,:),STATE_TS(3,:))

%% Project

G=[1];
lambda=10;
l=0.1;
% phi(m,y,k,j)
phi(1,1,1,1)=0.5;
phi(1,2,1,1)=0.5;
phi(1,3,1,1)=1;
phi(2,1,1,1)=0.5;
phi(2,2,1,1)=0.5;
phi(2,3,1,1)=0.5;
phi(3,1,1,1)=0.5;
phi(3,2,1,1)=0.5;
phi(3,3,1,1)=0.5;

% definitions
Rset = 1:length(A); %number of rules
n = size(A{1},2); %system order
nl = 1; %number of nonlinearities

%Theorem
[P,L,R]=journal_result(A,G,Rset,n,lambda,l,phi,nl)
