% function used to perform several trials with input value ranges

function [ovs] = run_permutations(ta, pa, m, prc, prf, beta, b, f, fib, fab, e, autom)
    ovs = [];
    for iprc = prc
        for iprf = prf
            for ibeta = beta
                for ib = b
                    for iff = f
                        for ifib = fib
                            for ifab = fab
                                ov = run_simulation(ta, pa, m, iprc, iprf, ibeta, ib, iff, ifib, ifab, e, autom);
                                ovs = [ovs, ov];
                            end
                        end
                    end
                end
            end
        end
    end   