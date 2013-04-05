% Fan model

function [sv] = fan(cv, iv, sv)
    sv.f.t = sv.d.t * iv.prf^((cv.f.y-1)/(cv.f.y*cv.f.n));
    sv.f.p = sv.d.p * iv.prf;
    sv.f.wdot = cv.f.y/(cv.f.y-1) * cv.R/cv.f.mw * (sv.f.t - sv.d.t) * (1+iv.beta);