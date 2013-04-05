% run the nominal cases for the four cycles

function [ovs] = run_nominal_scenarios()
    conditions = flight_conditions();
    engines = prospective_engines();
    
    for i = 1:4
        ov = run_scenario(conditions(i), engines(i))
        ovs = [ovs, ov];
    end