function [c, ceq] = const(dv, p)
%CONST Summary of this function goes here
%   Detailed explanation goes here
    x = dv(1,:);
    dx = dv(2,:);
    F = dv(3,:);

    collCon = collConstraintsLeftReimann(dv, p);

    eqCon(1) = x(1); %block starts at 0 m
    eqCon(2) = x(end) - 1; %block stops at 1 m
    eqCon(3) = dx(1); %Block starts with no vel
    eqCon(4) = dx(end); %block stops with no velocity

    
    eqCon = reshape(eqCon, [2*p.dof,2]);
    ceq = [collCon, eqCon];
    c = 0;
end

