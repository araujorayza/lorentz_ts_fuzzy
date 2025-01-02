%% Trying to find the angles
teste = vpa(V_new,2);

% u==0
curve = subs(teste,u,0)

[t1,t2]=coeffs(curve)

A = t1(1);
C = t1(3);
B = t1(2);

COT2theta = (A-C)/B;
COT2theta = double(COT2theta);
theta=acot(COT2theta)/2

theta_in_deg=theta*180/pi

%obtain the unrotated equation
syms X Y real

final=subs(curve,{v,w},{X*cos(theta)-Y*sin(theta),X*sin(theta)+Y*cos(theta)});
final=simplify(final)
vpa(final,2)

%% v==0
curve = subs(teste,v,0)

[t1,t2]=coeffs(curve)

A = t1(1);
C = t1(3);
B = t1(2);

COT2theta = (A-C)/B;
COT2theta = double(COT2theta);
theta=acot(COT2theta)/2

theta_in_deg=theta*180/pi

%obtain the unrotated equation
syms X Y real

final=subs(curve,{u,w},{X*cos(theta)-Y*sin(theta),X*sin(theta)+Y*cos(theta)});
final=simplify(final)
vpa(final,2)

%% w == 0 
curve = subs(teste,w,0)

[t1,t2]=coeffs(curve)

A = t1(1);
C = t1(3);
B = t1(2);

COT2theta = (A-C)/B;
COT2theta = double(COT2theta);
theta=acot(COT2theta)/2

theta_in_deg=theta*180/pi

%obtain the unrotated equation
syms X Y real

final=subs(curve,{u,v},{X*cos(theta)-Y*sin(theta),X*sin(theta)+Y*cos(theta)});
final=simplify(final)
vpa(final,2)

%% plot the ellisoid
[X,Y,Z] = ellipsoid(0,0,0,1372e-7,357e-7,305e-7);

surf(X,Y,Z);
axis equal

%hold on
s = surf(X+0,Y,Z+0);

direction = [1 0 0];
rotate(s,direction,38.9339)
direction = [0 1 0];
rotate(s,direction,-44.3505)
direction = [0 0 1];
rotate(s,direction,-34.7307)

%but i cannot find the size of the axis of this ellipsoid

%%
% plot as a mf
NGrid=200;
[X,Y] = meshgrid(ulim(1):NGrid:ulim(2), ...
                 vlim(1):NGrid:vlim(2));

V_NEW = -((X + 60).*(- 13211944598451182*X.^2 + 9668427535026132.*X.*Y + 3689841385741729.*X.*w - 9589630598951496.*Y.^2 + 16461294215742086.*Y.*w - 13128283484441104.*w.^2))/2266735911777429702574080 - 0.1

Z=0*X;
for i=1:size(X,1)
    for j=1:size(Y,2)
        zis=solve(V_NEW(i,j),w);
        if(isempty(zis))
            Z(i,j) = 0;
        else
            Z(i,j) = zis(1);
        end
    end
end

surf(X,Y,Z)