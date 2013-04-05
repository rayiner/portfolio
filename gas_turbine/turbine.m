% Turbine model

function [sv] = turbine(cv, iv, sv)
    sv.t.wdot = -sv.c.wdot / (1 - iv.b + iv.f);
    sv.t.t = sv.b.t * (sv.t.wdot/(cv.t.cp*sv.b.t) + 1);
    
    % find adiabatic efficiency
    tr = sv.t.t / sv.b.t;
    n = (tr - 1) / (tr^(1/cv.t.n) - 1);
    
    sv.t.p = sv.b.p * ((sv.t.t/sv.b.t-1)*1/n + 1)^(cv.t.y/(cv.t.y-1));
    