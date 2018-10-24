function [obj] = objectiveFunction(dv)
%OBJECTIVEFUNCTION Summary of this function goes here
%   Detailed explanation goes here
F = dv(end,:);
obj = sum(F.^2);
end

