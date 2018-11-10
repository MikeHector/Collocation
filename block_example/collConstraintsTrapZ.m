function [collCon] = collConstraintsTrapZ(dv, p)
%stanceConstraints runs collocation constraints and others
%   Takes in full decision variables, parameters and outputs the inequality
%   constraints and equality constraints.
    qLen = 2*p.dof;
    deltaT = p.tEnd ./ p.N;
    
    collCon = zeros(qLen,p.N-1);
    %Collocation constraints (dynamics)
    for i = 1:p.N-1
        Fk = Dyn(dv(:, i), p);
        Fk_plus_1 = Dyn(dv(:, i + 1), p);
        %Trapezoidal Collocation Constraints
        collCon(:, i) = ...
            [.5 * deltaT * (Fk_plus_1 + Fk)...
            - dv(1:qLen, i + 1)...
            + dv(1:qLen, i)];
    end

end
