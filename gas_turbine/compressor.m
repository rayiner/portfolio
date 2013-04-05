% Compressor model

function [sv] = compressor(cv, iv, sv)
    sv.c.t = sv.f.t * iv.prc^((cv.c.y-1)/(cv.c.y*cv.c.n));
    sv.c.p = sv.f.p * iv.prc;
    sv.c.wdot = cv.c.y/(cv.c.y-1) * cv.R/cv.c.mw * (sv.c.t - sv.f.t);
