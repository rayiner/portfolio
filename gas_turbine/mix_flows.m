function [t, p] = mix_flows(th, ph, tc, pc, sigma,y)
    t = 1/(sigma+1)*(th-tc)+tc;
    p = pc * ((ph/pc)^(1/(sigma+1)) * (t/tc)^(y/(y-1)) * (tc/th)^(y/(y-1)*(1/(sigma+1))));
