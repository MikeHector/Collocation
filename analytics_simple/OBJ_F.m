function [ cost ] = OBJ_F( dv, Parameters, smooth )
%objective_function This function evaluates the objective function
%   This function uses Decision variables and calculates the objective
%   function or cost
    r = sqrt(dv(1,:).^2 + dv(2,:).^2);
    hk = [dv(9,1)/Parameters.N * ones([1,Parameters.N])];
    cost_leg = 0;
    cost_ankle = 0;
%     R_leg = Parameters.R_leg;
%     R_ankle = Parameters.R_ankle;
%     maxXzero = MikeMax(smooth);
    abSmooth = @(x) sqrt(x.^2 + .001.^2) - .001;
    r0 = dv(3,:); dr0 = dv(6,:);
    dr = (dv(4,:) .* dv(1,:) + dv(6,:) .* dv(2,:)) ./ r;
    Fleg = Parameters.k * (r0 - r) + Parameters.c * (dr0 - dr);
    for i = 1:size(dv,2)
        cost_leg = cost_leg + ...
            abSmooth(Fleg(i) .* dv(6,i)) * hk(i);
        cost_ankle = cost_ankle + ...
            abSmooth(dv(8,i) * Parameters.transmission_ankle .*...
            (dv(1,i) * dv(5,i) - dv(2,i) * dv(4,i)) / (r(i)^2))  * hk(i);
    end
    xTravel = abSmooth(dv(1,end) - dv(1,1));
    cost = (cost_leg + cost_ankle) / (Parameters.m * Parameters.g * xTravel);
end