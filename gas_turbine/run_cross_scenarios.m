% run the cross scenarios
function [fm, stm, tsfcm] = run_cross_scenarios()
    fm = zeros(4,4);
    stm = zeros(4,4);
    tsfcm = zeros(4,4);
     
    conditions = flight_conditions();
    engines = prospective_engines();

    for i = 1:4
        for j = 1:4
            ov = run_scenario(conditions(i), engines(j), 1);
            fm(i,j) = ov.sv.b.fmax;
            stm(i,j) = ov.st;
            tsfcm(i,j) = ov.tsfc;
        end
    end