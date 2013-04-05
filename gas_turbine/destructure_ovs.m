% destructure a vector of ovs into a series of vectors

function [ivv, svv, stv, tsfcv] = destructure_ovs(ovs)
    ivv = [];
    svv = [];
    stv = [];
    tsfcv = [];
    for ov = ovs
        ivv = [ivv, ov.iv];
        svv = [svv, ov.sv];
        stv = [stv, ov.st];
        tsfcv = [tsfcv, ov.tsfc];
    end
