function dstate=lorentz_TSFuzzy(t,state,param)
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

    A{1}=[-sigma sigma 0;
        r -1 -60;
        0 60 -b];
    A{2}=[-sigma sigma 0;
        r -1 60;
        0 -60 -b];
    
    h{1} = @(u) (60+u)/120;
    h{2} = @(u) 1-h{1}(u);
    defuzz = 0;
    for i=1:length(h)
        defuzz = defuzz + h{i}(u)*A{i}*state;
    end
    dstate = [defuzz(1);defuzz(2);defuzz(3)];             
end