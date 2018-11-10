function [ cost ] = OBJ_F_absFV( dv, Parameters, smooth )
%objective_function This function evaluates the objective function
%   This function uses Decision variables and calculates the objective
%   function or cost
    r = sqrt(dv(1,:).^2 + dv(2,:).^2);
    hk = dv(9,1)/Parameters.N;
    cost_leg = 0;
    cost_ankle = 0;
%     R_leg = Parameters.R_leg;
%     R_ankle = Parameters.R_ankle;
    maxXzero = MikeMax(smooth);
    eps = .001;
    abSmooth = @(x) sqrt(x.^2 + eps.^2) - eps;
    x = dv(1,:);
    y = dv(2,:);
    r0 = dv(3,:);
    dx = dv(4,:);
    dy = dv(5,:);
    dr0 = dv(6,:);
    dr = (x .* dx + y .* dy) ./ r;
    Fleg = Parameters.k * (r0 - r) + Parameters.c * (dr0 - dr);
    wkLeg = @(k) abSmooth(Fleg(k) .* dr0(k));
    wkAnkle = @(k) abSmooth(Tankle(k) * Parameters.transmission_ankle .*...
            (x(k) .* dy(k) - y(k) .* dx(k)) ./ (r(k)^2));
    Jleg = 0;
    Jankle = 0;
    for i = 1:size(dv,2)-1
        Jleg = Jleg + hk * wkLeg(i);
        Jankle = Jankle + hk * wkAnkle(i);
    end
    xTravel = maxZero(dv(1,end) - dv(1,1));
    cost = (Jleg + Jankle + sum(abSmooth(ddr0)*hk*Parameters.objWeight))...
        / (Parameters.m * Parameters.g * xTravel);
end