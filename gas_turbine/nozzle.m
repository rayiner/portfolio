% Nozzle model

function [sv] = nozzle(cv, iv, sv)
    tin = sv.ab.t;
    pin = sv.ab.p;
    y = cv.n.y;
    n = cv.n.n;
    mw = cv.n.mw;
    
    [sv.n.t, sv.n.p, sv.n.u] = expand_flow(tin, pin, iv.pa, n, y, cv.R, mw);
    sv.n.ratio = (1 + iv.f + iv.fib + iv.fab);
    
