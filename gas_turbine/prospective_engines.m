% structures containing the prospective engines

function [engines] = prospective_engines()
    % ground-roll optimized engine
    engine0.prc = 30;
    engine0.prf = 1.5;
    engine0.beta = 8.5;
    engine0.b = 0.15;
    engine0.f = 0.0229;
    engine0.fib = 0;
    engine0.fab = 0;
    engine0.components = [1,0,0,0];

    % low-altitude subsonic engine
    engine1.prc = 30;
    engine1.prf = 1.5;
    engine1.beta = 7;
    engine1.b = 0.15;
    engine1.f = 0.0201;
    engine1.fib = 0;
    engine1.fab = 0;
    engine1.components = [1,0,0,0];

    % high-altitude subsonic engine
    engine2.prc = 30;
    engine2.prf = 1.5;
    engine2.beta = 0.8;
    engine2.b = 0.15;
    engine2.f = 0.02355;
    engine2.fib = 0;
    engine2.fab = 0;
    engine2.components = [1,0,0,0];

    % high-altitude supersonic engine
    engine3.prc = 30;
    engine3.prf = 1;
    engine3.beta = 0;
    engine3.b = 0.15;
    engine3.f = 0.0243;
    engine3.fib = 0;
    engine3.fab = 0;
    engine3.components = [0,0,0,0];

    % super awesome engine
    engine4.prc = 20;
    engine4.prf = 1.5;
    engine4.beta = 1.86;
    engine4.b = 0.15;
    engine4.f = 1;      % let program auto-compute
    engine4.fib = 1;    % let program auto-compute
    engine4.fab = 1;    % let program auto-compute
    engine4.components = [1,0,1,1];
    
    % test engine
    engine5.prc = 20;
    engine5.prf = 1.5;
    engine5.beta = 1;
    engine5.b = 0.04;
    engine5.f = 0.02344;
    engine5.fib = 0.0015;
    engine5.fab = 0.003;
    engine5.components = [1, 1, 1, 0];
    
    % less awesome engine
    engine6.prc = 20;
    engine6.prf = 1.3;
    engine6.beta = 6;
    engine6.b = 0.3;
    engine6.f = 1;
    engine6.fib = 1;
    engine6.fab = 1;
    engine6.components = [1,0,1,0];
    
    engines = [engine0, engine1, engine2, engine3, engine4, engine5, engine6];
    