% Diffuser model

function [sv] = diffuser(cv, iv, sv)
    sv.d.t = sv.a.t * (1 + (cv.d.y-1)/2 * iv.M^2);
    sv.d.p = sv.a.p * cv.d.r * (1 + cv.d.n * (cv.d.y-1)/2 * iv.M^2)^(cv.d.y/(cv.d.y-1));