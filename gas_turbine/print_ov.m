% print an output vector

function [] = print_ov(name, ov)
    disp(sprintf('Cycle Name:                                               %s', name))
    disp(sprintf('Effective Specific Thrust:                                %d', ov.st))
    disp(sprintf('Thrust-Specific Fuel Consumption:                         %d', ov.tsfc))
    disp(sprintf('Exhaust Velocities (Hot Flow, Cold Flow):                 %d %d', ov.sv.he.u, ov.sv.ce.u))
    disp(sprintf('Fuel Air Ratios (Main, Inter-Turbine, After):             %d %d %d', ov.iv.f, ov.iv.fib, ov.iv.fab))
    disp(sprintf('Maximum Fuel Air Ratios (Main, Inter-Turbine, After):     %d %d %d', ov.sv.b.fmax, ov.sv.ib.fmax, ov.sv.ab.fmax))
    disp(sprintf('Overall Efficiencies (Propulsive, Thermal, Overall):      %d %d %d', ov.np, ov.nth, ov.n0))
    disp(sprintf('Required Power (Compressor, Fan):                         %d %d', ov.wc, ov.wf))
    disp(sprintf('Output Power (Turbine, Fan Turbine):                      %d %d', -ov.wt, -ov.wft))
    disp(sprintf('Ambient Conditions (Temperature, Pressure):               %d %d', ov.sv.a.t, ov.sv.a.p))
    disp(sprintf('Diffuser Conditions (Temperature, Pressure):              %d %d', ov.sv.d.t, ov.sv.d.p))
    if ov.iv.fanEnable
        disp(sprintf('Fan Conditions (Temperature, Pressure):                   %d %d', ov.sv.f.t, ov.sv.f.p))
    end
    disp(sprintf('Compressor Conditions (Temperature, Pressure):            %d %d', ov.sv.c.t, ov.sv.c.p))
    disp(sprintf('Burner Conditions (Temperature, Pressure):                %d %d', ov.sv.b.t, ov.sv.b.p))
    disp(sprintf('Turbine Conditions (Temperature, Pressure):               %d %d', ov.sv.t.t, ov.sv.t.p))
    disp(sprintf('Turbine Mixer Conditions (Temperature, Pressure):         %d %d', ov.sv.tm.t, ov.sv.tm.p))
    if ov.iv.ibEnable
        disp(sprintf('Inter-Turbine-Burner Conditions (Temperature, Pressure):  %d %d', ov.sv.ib.t, ov.sv.ib.p))
    end
    if ov.iv.fanEnable
        disp(sprintf('Fan Turbine Conditions (Temperature, Pressure):           %d %d', ov.sv.ft.t, ov.sv.ft.p))
    end
    if ov.iv.abEnable
        disp(sprintf('After-burner Conditions (Temperature, Pressure):          %d %d', ov.sv.ab.t, ov.sv.ab.p))
    end
    if ov.iv.mixEnable
        disp(sprintf('Mixer Conditions (Temperature, Pressure):                 %d %d', ov.sv.m.t, ov.sv.m.p))
        disp(sprintf('Mixer Nozzle Conditions (Temperature, Pressure):          %d %d', ov.sv.mn.t, ov.sv.mn.p))
    else
        disp(sprintf('Nozzle Conditions (Temperature, Pressure):                %d %d', ov.sv.n.t, ov.sv.n.p))
        if ov.iv.fanEnable
            disp(sprintf('Fan Nozzle Conditions (Temperature, Pressure):            %d %d', ov.sv.fn.t, ov.sv.fn.p))
        end
    end

    disp(sprintf('Hot Exhaust Conditions (Temperature, Pressure):           %d %d', ov.sv.he.t, ov.sv.he.p))
    disp(sprintf('Cold Exhaust Conditions (Temperature, Pressure):          %d %d', ov.sv.ce.t, ov.sv.ce.p))