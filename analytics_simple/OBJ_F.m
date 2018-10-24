function [ cost ] = OBJ_F( dv, Parameters, smooth )
%objective_function This function evaluates the objective function
%   This function uses Decision variables and calculates the objective
%   function or cost
    r = sqrt(dv(1,:).^2 + dv(2,:).^2);
    hk = dv(9,1)/Parameters.N;
    cost_leg = 0;
    cost_ankle = 0;
%     R_leg = Parameters.R_leg;
%     R_ankle = Parameters.R_ankle;
%     maxXzero = MikeMax(smooth);
    eps = .001;
    maxZero = MikeMax(smooth);
    x = dv(1,:);
    y = dv(2,:);
    r0 = dv(3,:);
    dx = dv(4,:);
    dy = dv(5,:);
    dr0 = dv(6,:);
    ddr0 = dv(7,:);
    Tankle = dv(8,:);
    dr = (x .* dx + y .* dy) ./ r;
    Fleg = Parameters.k * (r0 - r) + Parameters.c * (dr0 - dr);
    Tleg = Parameters.i_motor*Parameters.transmission*ddr0 + Fleg/Parameters.transmission;
    for i = 1:size(dv,2)
        cost_leg = cost_leg + ...
            (maxZero(Fleg(i) .* dr0(i)) + Parameters.R_leg*Tleg(i).^2) * hk;
        cost_ankle = cost_ankle + ...
            (maxZero(Tankle(i) * Parameters.transmission_ankle .*...
            (x(i) .* dy(i) - y(i) .* dx(i)) ./ (r(i)^2)) + Parameters.R_ankle*Tankle(i)^2)  * hk;
    end
    xTravel = maxZero(dv(1,end) - dv(1,1));
    cost = (cost_leg + cost_ankle) / (Parameters.m * Parameters.g * xTravel);
end