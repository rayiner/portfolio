% Fan turbine model

function [sv] = fan_turbine(cv, iv, sv)
    sv.ft.wdot = -sv.f.wdot / (1 + iv.f + iv.fib);
    sv.ft.t = sv.ib.t * (sv.ft.wdot/(cv.ft.cp*sv.ib.t) + 1);
    
    % find adiabatic efficiency
    tr = sv.ft.t / sv.ib.t;
    n = (tr - 1) / (tr^(1/cv.ft.n) - 1);
    
    sv.ft.p = sv.ib.p * ((sv.ft.t/sv.ib.t-1)*1/n + 1)^(cv.ft.y/(cv.ft.y-1));
    