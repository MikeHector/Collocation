function [eqStance] = stanceConstraintsLeftReimann(dv, p)
%stanceConstraints runs collocation constraints and others
%   Takes in full decision variables, parameters and outputs the inequality
%   constraints and equality constraints.
    qLen = 2*p.dof;
    deltaT = dv(9,1) ./ p.N;
    
%     eqStance = zeros(qLen,p.N-1);
    %Collocation constraints (dynamics)
    for i = 1:p.N-1
        Fk = stanceDyn(dv(:, i), p);
        %Reimann Sum Collocation Constraints
        eqStance(:, i) = ...
            [deltaT * Fk...
            - dv(1:qLen, i + 1)...
            + dv(1:qLen, i)];
    end

end