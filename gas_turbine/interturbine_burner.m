% Interturbine burner model

function [sv] = interturbine_burner(cv, iv, sv)
    sv.ib.t = sv.tm.t * ((cv.ib.n*iv.fib*cv.Q)/(cv.ib.cp*sv.tm.t) + (1+iv.f))/(1+iv.f + iv.fib); 
    sv.ib.p = sv.tm.p * cv.ib.pr;
    sv.ib.fmax = (1+iv.f)*(cv.ib.tmax/sv.tm.t-1)/((cv.ib.n*cv.Q/sv.tm.t)*(cv.ib.mw/cv.R)*(cv.ib.y-1)/cv.ib.y - cv.ib.tmax/sv.tm.t);
