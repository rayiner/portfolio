% run a given (condition, engine) scenario

function [ov] = run_scenario(c, e, autom)
    ov = run_simulation(c.ta, c.pa, c.M, e.prc, e.prf, e.beta, e.b, e.f, e.fib, e.fab, e.components, autom);

   