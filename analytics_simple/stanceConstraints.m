function [eqStance] = stanceConstraints(dv, p)
%stanceConstraints runs collocation constraints and others
%   Takes in full decision variables, parameters and outputs the inequality
%   constraints and equality constraints.
    qLen = 2*p.dof;
    deltaT = dv(9,1) ./ p.N;
    
    %Collocation constraints (dynamics)
    for i = 1:p.N-1
        Fk = stanceDyn(dv(:, i), p);
        Fk_plus_1 = stanceDyn(dv(:, i + 1), p);
        %Trapezoidal Collocation Constraints
        eqStance(:, i) = ...
            [.5 * deltaT * (Fk_plus_1 + Fk)...
            - dv(1:qLen, i + 1)...
            + dv(1:qLen, i)];
    end
end