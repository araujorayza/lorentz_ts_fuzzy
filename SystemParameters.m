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
