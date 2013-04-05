% create plots for efficiency vs Prc
ta = 217.0;
pa = 11.7;
M = 1.4;
Prc = 13:1:40;
Prf = 1;
beta = 0;
b = 0.15;
f = 0.0;
fib = 0;
fab = 0;
cmps = [0, 0, 0, 0];

ovs = run_permutations(ta, pa, M, Prc, Prf, beta, b, f, fib, fab, cmps, 1);

ordvec = [];
stvec = [];
tsfcvec = [];

for iov = ovs
    ordvec = [ordvec, iov.iv.prc];
    stvec = [stvec, iov.st];
    tsfcvec = [tsfcvec, iov.tsfc];
end

[ax, h1, h2] = plotyy(ordvec, stvec, ordvec, tsfcvec);
set(get(ax(1), 'Ylabel'), 'String', 'Specific Thrust (kN/(kg/s)');
set(get(ax(2), 'Ylabel'), 'String', 'Specific Fuel Consumption ((kN s)/kg');
set(h2, 'LineStyle', '--');
xlabel('Compressor Pressure Ratio');
title('Compressor Pressure Ratio Trade Study');
legend([h1, h2], 'Specific Thrust', 'Specific Fuel Consumption');