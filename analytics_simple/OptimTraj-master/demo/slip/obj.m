function [ cost ] = obj(t, dv, u, Parameters)
%objective_function This function evaluates the objective function
%   This function uses Decision variables and calculates the objective
%   function or cost
    r = sqrt(dv(1,:).^2 + dv(2,:).^2);
%     R_leg = Parameters.R_leg;
%     R_ankle = Parameters.R_ankle;
    
    eps = .001;
%     abSmooth = @(x) sqrt(x.^2 + eps.^2) - eps;
    abSmooth = @(x) abs(x);
%     maxXzero = MikeMax(3);
    maxXzero = @(x) max(0,x);
    x = dv(1,:);
    y = dv(2,:);
    r0 = dv(3,:);
    dx = dv(4,:);
    dy = dv(5,:);
    dr0 = dv(6,:);
    ddr0 = u(1,:);
    Tankle = u(2,:);
    dr = (x .* dx + y .* dy) ./ r;
    Fleg = Parameters.k * (r0 - r) + Parameters.c * (dr0 - dr);
    Jleg = abSmooth(Fleg .* dr0);
%     Jankle = abSmooth(Tankle * Parameters.transmission_ankle .*...
%             (x .* dy - y .* dx) ./ (r.^2));
    Jankle = 0;
    xTravel = maxXzero(dv(1,end) - dv(1,1));
    cost = (Jleg + Jankle + sum(abSmooth(ddr0).*Parameters.objWeight))...
        ./ (Parameters.m * Parameters.g .* xTravel);
end