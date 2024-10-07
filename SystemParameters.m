param=[10.5; 29.4; 2.8]; %[sigma,r,b]

ulim=[-60,60];
vlim=[-80,60];
wlim=[-60+5/4*param(2),80+5/4*param(2)];
% using the change of variables: x=u, v=y, z=w-5/4*r

sigma = param(1);
r = param(2);
b = param(3);

A{1}=[-sigma sigma 0;
    r -1 -60;
    0 60 -b];
A{2}=[-sigma sigma 0;
    r -1 60;
    0 -60 -b];

h{1} = @(u) (60+u)/120;
h{2} = @(u) 1-h{1}(u);

%% New model with more rules

A{1}=[-sigma sigma 0;
    r -1 -60;
    60 0 -b];
A{2}=[-sigma sigma 0;
    r -1 60;
    60 0 -b];
A{3}=[-sigma sigma 0;
    r -1 -60;
    -80 0 -b];
A{4}=[-sigma sigma 0;
    r -1 60;
    -80 0 -b];

h{1} = @(u,v) (60-u)/120*(v+80)/140;
h{2} = @(u,v) (60+u)/120*(v+80)/140;
h{3} = @(u,v) (60-u)/120*(60-v)/140;
h{4} = @(u,v) (60+u)/120*(60-v)/140;

%% duffing oscilation
clear all 
d=50;

A{1}=[0 1;
    0 -0.1];
A{2}=[0 1;
    -d^2 -0.1];

h{1} = @(u) 1-u^2/d^2;
h{2} = @(u) 1-h{1}(u);