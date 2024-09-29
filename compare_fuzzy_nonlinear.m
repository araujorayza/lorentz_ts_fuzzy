clear all;
close all;
clc;

param=[10.5; 29.4; 2.8]; %[sigma,r,b]

ulim=[-60,60];
vlim=[-80,60];
wlim=[-60,80];

x=1;
y=2;
z=3;

InitSTATE=[20;-70;40];
t=0:0.01:100;

options = odeset('RelTol',1e-10,'AbsTol',1e-10);

[t,STATE] = ode45(@(t,y_var) lorentz_nonlinear(t,y_var,param),t,InitSTATE,options);


figure(1)
plot3(STATE(:,x),STATE(:,y),STATE(:,z))
xlim(ulim)
ylim(vlim)
zlim(wlim)
xlabel('x')
ylabel('y')
zlabel('z')
grid on