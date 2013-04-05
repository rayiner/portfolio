% search for an engine meeting given specific-thrust critereon

function [m, dnm, ovs] = search_for_engine(ta, pa, m, prc, prf, beta, b, f, fib, fab, e, lim)
    ovs = run_permutations(ta, pa, m, prc, prf, beta, b, f, fib, fab, e, 1);
    m = []
    dnm = []
    for ov = ovs
        if ov.st >= limit
            m = [m, ov];
        else
            dnm = [dnm, ov];
        end
    end
