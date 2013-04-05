function [cv] = setup_constants(iv)
    cv.R = 8.314;  % kJ/kmol
    cv.Q = 45000;  % kJ/kg
    cv.y = 1.4;

    % handle supersonic diffuser loss
    if iv.M > 1
        cv.d.r = 1 - 0.075 * (iv.M - 1)^1.35;
    else
        cv.d.r = 1.0;
    end;
        
    cv.d.n = 0.92;
    cv.d.mw = 28.8;
    cv.d.y = 1.4;
    
    cv.f.cb = 0.24;     % kN s / kg
    cv.f.n = 0.90;
    cv.f.mw = 28.8;
    cv.f.y = 1.4;
    
    cv.c.n = 0.90;
    cv.c.mw = 28.8;
    cv.c.y = 1.36;
    
    cv.b.pr = 0.98;
    cv.b.n = 0.99;
    cv.b.mw = 28.8;
    cv.b.y = 1.32;
    cv.b.cp = cv.b.y / (cv.b.y - 1) * cv.R / cv.b.mw;
    
    cv.t.tmax0 = 1300;
    cv.t.bmax = 0.15;
    cv.t.cb = 600;
    cv.t.tmax = cv.t.tmax0 + cv.t.cb * sqrt(iv.b/cv.t.bmax);
    cv.t.n = 0.92;
    cv.t.mw = 28.8;
    cv.t.y = 1.32;
    cv.t.cp = cv.t.y / (cv.t.y - 1) * cv.R / cv.t.mw;
    
    cv.tm.cb = 2900;
    cv.tm.mw = 28.8;
    cv.tm.y = 1.33;
    
    cv.ib.pr = 0.99;
    cv.ib.tmax = 1300;
    cv.ib.n = 0.99;
    cv.ib.mw = 28.8;
    cv.ib.y = 1.33;
    cv.ib.cp = cv.ib.y / (cv.ib.y - 1) * cv.R / cv.ib.mw;
    
    cv.ft.n = 0.92;
    cv.ft.mw = 28.8;
    cv.ft.y = 1.33;
    cv.ft.cp = cv.ft.y / (cv.ft.y - 1) * cv.R / cv.ft.mw;
    
    cv.ab.pr = 0.97;
    cv.ab.tmax = 2100;
    cv.ab.n = 0.95;
    cv.ab.mw = 28.8;
    cv.ab.y = 1.32;
    cv.ab.cp = cv.ab.y / (cv.ab.y - 1) * cv.R / cv.ab.mw;
    
    cv.m.mw = 28.8;
    cv.m.y = 1.4;
    
    cv.n.n = 0.95;
    cv.n.mw = 28.8;
    cv.n.y = 1.35;
    
    cv.fn.n = 0.97;
    cv.fn.mw = 28.8;
    cv.fn.y = 1.4;
    
    cv.mn.n = 0.96;
    cv.mn.mw = 28.8;
    cv.mn.y = 1.4;