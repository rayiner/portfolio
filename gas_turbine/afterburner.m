% Afterburner model

function [sv] = afterburner(cv, iv, sv)
    sv.ab.t = sv.ft.t * ((cv.ab.n*iv.fab*cv.Q)/(cv.ab.cp*sv.ft.t) + (1+iv.f+iv.fib))/(1+iv.f + iv.fib+iv.fab); 
    sv.ab.p = sv.ft.p * cv.ab.pr;
    sv.ab.fmax = (1+iv.f+iv.fib)*(cv.ab.tmax/sv.ft.t-1)/((cv.ab.n*cv.Q/sv.ft.t)*(cv.ab.mw/cv.R)*(cv.ab.y-1)/cv.ab.y - cv.ab.tmax/sv.ft.t);