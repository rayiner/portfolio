% output report generator

function [ov] = generate_output(cv, iv, sv)
    ov.cv = cv;
    ov.iv = iv;
    ov.sv = sv;
    
    % record work rates
    ov.wc = sv.c.wdot;
    ov.wt = sv.t.wdot;
    
    if iv.fanEnable
        ov.wf = sv.f.wdot;
        ov.wft = sv.ft.wdot;
    end

    % compute some basic properties
    ov.a = sqrt(cv.y * cv.R*1000 / 28.8 * iv.ta);
    ov.u = iv.M * ov.a;
    
    % compute drag loss
    ov.dloss = cv.f.cb * iv.M^2*(iv.pa / 101.3)*iv.beta^1.5 *1000;
    
    % compute specific thrust
    
    ov.st = (sv.he.ratio*sv.he.u + sv.ce.ratio * sv.ce.u - (1+iv.beta)*ov.u - ov.dloss)/1000;
    
    % compute tsfc
    ov.tsfc = (iv.f+iv.fib+iv.fab)/ov.st;
    
    % compute kinetic energy change
    ov.kedot = (sv.he.ratio*sv.he.u^2 + sv.ce.ratio*sv.ce.u^2 - (1+iv.beta)*ov.u^2)/2000;
    
    % compute propulsive efficiency
    ov.np = ov.st * ov.u / ov.kedot;
    
    % compute overall efficiency
    n0 = ov.st*ov.u/((iv.f+iv.fib+iv.fab)*cv.Q);
    
    % compute thermal efficiency
    if ov.np > 0
        ov.nth = n0 / ov.np;
    else
        ov.nth = 0;
    end
    
    % set the thermal efficiency
    ov.n0 = n0;