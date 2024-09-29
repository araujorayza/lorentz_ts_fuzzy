function dx=lorentz_nonlinear(t,x,param)
%     Lorentz system
%     du = -sigma*u+sigma*v
%     dv = -v - u*w + r*u
%     dw = -b*w + u*v
    sigma=param(1);
    r=parm(2);
    b=param(3);

    u = x(1);
    v = x(2);
    w = x(3);

    dx = [-sigma*u+sigma*v;
          -v - u*w + r*u;
          -b*w + u*v];
end