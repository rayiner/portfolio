% structures containing various flight conditions

function [conditions] = flight_conditions()
    % ground roll
    condition0.ta = 288;
    condition0.pa = 101.3;
    condition0.M = 0;

    % low altitude subsonic
    condition1.ta = 248;
    condition1.pa = 45.6;
    condition1.M = 0.5;

    % high altitude subsonic
    condition2.ta = 226;
    condition2.pa = 28.1;
    condition2.M = 0.85;

    % high altitude supersonic
    condition3.ta = 217;
    condition3.pa = 11.7;
    condition3.M = 1.4;
    
    % test scenario
    condition4.ta = 250;
    condition4.pa = 50.0;
    condition4.M = 0.60;

    conditions = [condition0, condition1, condition2, condition3, condition4];