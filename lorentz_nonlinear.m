function dstate=lorentz_nonlinear(t,state,param)
%     Lorentz system
%     du = -sigma*u+sigma*v
%     dv = -v - u*w + r*u
%     dw = -b*w + u*v


    sigma = param(1);
    r = param(2);
    b = param(3);

    u = state(1);
    v = state(2);
    w = state(3);

    du = -sigma*u + sigma*v;
    dv = -v -u*w + r*u;
    dw = -b*w + u*v;

    dstate = [du;dv;dw];             
end