% theory of operation
% Data flow happens through a series of vectors. 
%     cv - constant vector, contains constants
%     iv - input vector, contains input variables
%     sv - state vector, holds state of engine
%     ov - output vector, contains output variables

% main simulation entry point

function [sv] = simulate_engine(cv, iv, sv) 
    % simulate diffusor
    sv = diffuser(cv, iv, sv);
    
    % conditionally simulate fan
    if iv.fanEnable
        sv = fan(cv, iv, sv);
    else
        sv.f.t = sv.d.t;
        sv.f.p = sv.d.p;
    end
    
    % simulate compressor
    sv = compressor(cv, iv, sv);
    
    % simulate burner
    sv = burner(cv, iv, sv);
    
    % simulate turbine
    sv = turbine(cv, iv, sv);
    
    % simulate turbine mixer
    sv = turbine_mixer(cv, iv, sv);
    
    % conditionally simulate interturbine burner
    if iv.ibEnable
        sv = interturbine_burner(cv, iv, sv);
    else
        sv.ib.t = sv.tm.t;
        sv.ib.p = sv.tm.p;
        sv.ib.fmax = 0;
    end
    
    % conditionally simulate fan turbine
    if iv.fanEnable
        sv = fan_turbine(cv, iv, sv);
    else
        sv.ft.t = sv.ib.t;
        sv.ft.p = sv.ib.p;
    end
    
    % conditionally simulate afterburner
    if iv.abEnable
        sv = afterburner(cv, iv, sv);
    else
        sv.ab.t = sv.ft.t;
        sv.ab.p = sv.ft.p;
        sv.ab.fmax = 0;
    end
    
    % simulate the nozzles
    if iv.mixEnable
        sv = mixer(cv, iv, sv);
        sv = mixer_nozzle(cv, iv, sv);
        sv.he = sv.mn;
        sv.ce.t = iv.ta;
        sv.ce.p = iv.pa;
        sv.ce.u = 0;
        sv.ce.ratio = 0;
    else
        sv = nozzle(cv, iv, sv);
        
        if iv.fanEnable
            sv = fan_nozzle(cv, iv, sv);
        else
            sv.fn.t = iv.ta;
            sv.fn.p = iv.pa;
            sv.fn.u = 0;
            sv.fn.ratio = 0;
        end
        
        sv.he = sv.n;
        sv.ce = sv.fn;
    end