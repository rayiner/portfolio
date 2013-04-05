% Mixer nozzle model

function [sv] = mixer_nozzle(cv, iv, sv)
    tin = sv.m.t;
    pin = sv.m.p;
    y = cv.mn.y;
    n = cv.mn.n;
    mw = cv.mn.mw;
    
    [sv.mn.t, sv.mn.p, sv.mn.u] = expand_flow(tin, pin, iv.pa, n, y, cv.R, mw);

    sv.mn.ratio = (1 + iv.f + iv.fib + iv.fab + iv.beta);

    