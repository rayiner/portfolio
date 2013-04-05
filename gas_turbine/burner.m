% Burner model

function [sv] = burner(cv, iv, sv)
    sv.b.t = sv.c.t * ((cv.b.n*iv.f*cv.Q)/(cv.b.cp*sv.c.t)+(1-iv.b))/(1+iv.f-iv.b); 
    sv.b.p = sv.c.p * cv.b.pr;
    sv.b.fmax = (1-iv.b)*(cv.t.tmax/sv.c.t-1)/((cv.b.n*cv.Q/sv.c.t)*(cv.b.mw/cv.R)*(cv.b.y-1)/cv.b.y - cv.t.tmax/sv.c.t);
