% Fan nozzle model

function [sv] = fan_nozzle(cv, iv, sv)
    tin = sv.f.t;
    pin = sv.f.p;
    y = cv.fn.y;
    n = cv.fn.n;
    mw = cv.fn.mw;
    
    [sv.fn.t, sv.fn.p, sv.fn.u] = expand_flow(tin, pin, iv.pa, n, y, cv.R, mw);

    sv.fn.ratio = iv.beta;
