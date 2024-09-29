function dstate=lorentz_nonlinear(t,state,param)
%     Lorentz system
%     du = -sigma*u+sigma*v
%     dv = -v - u*w + r*u
%     dw = -b*w + u*v
%     using the change of variables: x=u, v=y, z=w-5/4*r

    sigma = param(1);
    r = param(2);
    b = param(3);

    x = state(1);
    y = state(2);
    z = state(3);

    dx = -sigma*x + sigma*y;
    dy = -y -x*(z + 5/4*r) + r*x;
    dz = -b*(z + 5/4*r) + x*y;

    dstate = [dx;dy;dz];             
end