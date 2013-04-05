% common code for all the nozzles

function [t, p, u] = expand_flow(tin, pin, pa, n, y, R, mw)
    t = tin * (1 + n * ((pa/pin)^((y-1)/y)-1));
    p = pa;
    u = sqrt(2*y/(y-1)*R*1000/mw * (tin - t));