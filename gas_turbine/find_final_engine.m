% find canidates for the final engine

% ground roll
grta = 288;
grpa = 101.3;
grM = 0;

% high altitude supersonic
scta = 217;
scpa = 11.7;
scM = 1.4;

prc = 30;
prf = 1.5;
beta = 5.35;
b = 0.1:0.01:0.15;
f = 0.02344;
fib = 0.0233;
fab = 0.003;
e = [1, 1, 1];

ovs = run_permutations(scta, scpa, scM, prc, prf, beta, b, f, fib, fab, e, 1);

for ov = ovs
    ov.iv
    if ov.st >= 0.80
        ov2 = run_simulation(grta, grpa, grM, ov.iv.prc, ov.iv.prf, ov.iv.beta, ov.iv.b, ov.iv.f, ov.iv.fib, ov.iv.fab, e, 1);
        ov2
        if ov2.st >= 0.20
            ov2.st
        end
    end
end