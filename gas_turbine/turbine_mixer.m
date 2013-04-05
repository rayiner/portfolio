% Turbine mixer model

function [sv] = turbine_mixer(cv, iv, sv)
    sigma = iv.b / (1 - iv.b + iv.f);
    y = cv.tm.y;
    
    % hot flow
    th = sv.t.t;
    ph = sv.t.p;
    
    % cold flow
    tc = sv.c.t;
    pc = sv.c.p - cv.tm.cb * iv.b;
    
    [sv.tm.t, sv.tm.p] = mix_flows(th, ph, tc, pc, sigma, y);