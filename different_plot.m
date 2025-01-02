clear all;
close all;
clc;

main;

%%
syms u v w real
V=simplify([u,v,w]*h{1}(u)*P{1}*[u;v;w])

%%
NGrid=80;

[X,Y] = meshgrid(linspace(ulim(1),ulim(2),NGrid), ...
                 linspace(vlim(1),vlim(2),NGrid));

V_NEW = -((X + 60).*(- 13211944598451182*X.^2 + 9668427535026132.*X.*Y + 3689841385741729.*X.*w - 9589630598951496.*Y.^2 + 16461294215742086.*Y.*w - 13128283484441104.*w.^2))./2266735911777429702574080 - 0.1

Z=double(0*V_NEW);
Z_mirror=double(0*V_NEW);

for i=1:size(X,1)
    for j=1:size(Y,2)
        zis=solve(V_NEW(i,j)==0,w);
        if(isempty(zis))
            Z(i,j) = 0;
            Z_mirror(i,j)=0;
        else
            Z(i,j) = zis(1);
            Z_mirror(i,j)=zis(2);
        end
    end
end

plot3(X,Y,Z)
hold on
plot3(X,Y,Z_mirror)