clear all;
close all;
clc;

main;

%[U,S,V]=svd(P{1})
%% Plot test

% with V(u,v,w) = k, k constant; for every u,v inside Z, find the
% corresponding w. 

%% Rough Estimation of the Omega_l set

% lets use the symbolic package to have a sense of the form of V
syms u v w real
V=simplify([u,v,w]*h{1}(u)*P{1}*[u;v;w])

vpa(V,6) % this shows the equation with decimals instead of fractions
% V=V(u,v,w) is a 4D hyper surface so we cannot plot it.
% However, we can find the surface plots with V(u,v,w) = k_level
% reading the equation through those lenses, we find a cubic surface.
% they are very complicated. so we estivame this surface with another, 
% a quadric one. 

%h{1} >= 0
disp('as we can see, the eigenvalues of P are positive:')
disp(eig(P{1}))

% so this means that V is positive semidefinite (h can be 0 outside the origin)
% since (u+60) <=120 and V >=0, we have
% V=(u+60)*V_part <= 120* V_part = V_new

V_new = simplify(V/(u+60)*120);

% This is a rotated ellipsoid along the 3 axes

%% Using quadric surface analysis

% https://solitaryroad.com/c413.html

% f(x, y, z) = ax2 + by2 + cz2 + 2fyz + 2gxz + 2hxy + 2px + 2qy + 2rz + d = 0
% u=x, v=y, w=z


V_new
[t1,t2]=coeffs(V_new-0.1)

a=t1(1);
b=t1(4);
c=t1(6);
f=t1(5)/2;
g=t1(3)/2;
h=t1(2)/2;
p=0;
q=0;
r=0;
d=t1(7);



e=[ a, h, g;
    h, b, f;
    g, f, c];

E=[ a, h, g, p;
    h, b, f, q;
    g, f, c, r;
    p, q, r, d];

e=double(e);
E=double(E);

D=det(e)
Delta=det(E)
rho3=rank(e)
rho4=rank(E)
[dir,k]=eig(e)

% this is a real ellipsoid
% center:
-inv(e)*[p;q;r]

syms x y z
new=dir*[x;y;z];
ops=subs(V_new,{u,v,w},{new(1),new(2),new(3)})
ops=simplify(ops)
vpa(ops,2)

%dir gives the transformation matrix, so we can use it to plot
[X,Y,Z] = ellipsoid(0,0,0,sqrt(1/k(1,1)),sqrt(1/k(2,2)),sqrt(1/k(3,3)));
s = surf(0.89*Y - 0.38*X + 0.27*Z,- 0.74*X - 0.11*Y - 0.66*Z,   0.7*Z - 0.45*Y - 0.56*X);
s.FaceAlpha=0.2;

hold on
InitSTATE=[20;-70;40+5/4*r];
t=[0 100];

options = odeset('RelTol',1e-13,'AbsTol',1e-13);

%solves the ODE in time interval t
sol_nl = ode45(@(t,y_var) lorentz_nonlinear(t,y_var,param),t,InitSTATE,options);
sol_ts = ode45(@(t,y_var) lorentz_TSFuzzy(t,y_var,param),t,InitSTATE,options);

%recalculates the solution in specific time points
NofPoints=500;
t=linspace(t(1),t(end),NofPoints);
STATE_NL=deval(sol_nl,t);
STATE_TS=deval(sol_ts,t);

plot3(STATE_NL(1,:),STATE_NL(2,:),STATE_NL(3,:))
legend;

