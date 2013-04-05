% Mixer model

function [sv] = mixer(cv, iv, sv)
    sigma = iv.beta / (1 + iv.f + iv.fib + iv.fab);
    y = cv.m.y;
            
    % hot flow
    th = sv.ab.t;
    ph = sv.ab.p;
    
    % cold flow
    tc = sv.f.t;
    pc = sv.f.p;
    
    [sv.m.t, sv.m.p] = mix_flows(th, ph, tc, pc, sigma, y);