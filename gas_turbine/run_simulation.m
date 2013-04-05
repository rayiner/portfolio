% utility function to make things easier to use

function [ov] = run_simulation(ta, pa, m, prc, prf, beta, b, f, fib, fab, e, autom)
    iv = setup_inputs(ta, pa, m, prc, prf, beta, b, f, fib, fab, e);
    cv = setup_constants(iv);
    sv = setup_state(cv, iv);
    sv = simulate_engine(cv, iv, sv);
    
    if autom
        for i = 1:3
            iv.f = sv.b.fmax;
            if iv.ibEnable
                iv.fib = sv.ib.fmax;
            else
                iv.fib = 0;
            end
            if iv.abEnable
                iv.fab = sv.ab.fmax;
            else
                iv.fab = 0;
            end
            sv = simulate_engine(cv, iv, sv);
        end
    end

    ov = generate_output(cv, iv, sv);