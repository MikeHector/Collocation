function [eqStance ineqStance] = stanceConstraintsLC(dv, p)
%stanceConstraints runs collocation constraints and others
%   Takes in full decision variables, parameters and outputs the inequality
%   constraints and equality constraints.
    qLen = 2*p.dof;
%     eqStance = zeros(qLen,p.Nstance-1);
    Tstance = dv(9,1);
    %Collocation constraints (dynamics)
    for i = 1:p.Nstance-1
        time_i = Tstance * (i - 1) / (p.Nstance - 1);
        time_i_plus_1 = Tstance * i / (p.Nstance - 1);
        Fk = stanceDynLC(dv(:, i), p);
        Fk_plus_1 = stanceDynLC(dv(:, i + 1), p);
        %Trapezoidal Collocation Constraints
        eqStance(:, i) = ...
            [.5 * (time_i_plus_1 - time_i) * (Fk_plus_1 + Fk)...
            - dv(1:qLen, i + 1)...
            + dv(1:qLen, i)];
        %Limit on ddr0
        r0ddUb(i) = Fk(end) - p.r0ddUb;
        r0ddLb(i) = -(p.r0ddLb + Fk(end));
    end
    ineqStance = [r0ddUb, r0ddLb];

end