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
    abSmooth = @(x) sqrt(x.^2 + eps.^2) - eps;
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
%     Tleg = Parameters.i_motor*Parameters.transmission*ddr0;% + Fleg/Parameters.transmission;
    Tleg = Fleg/Parameters.transmission;
    wkLeg = @(k) abSmooth(Fleg(k) .* dr0(k));
    wkAnkle = @(k) abSmooth(Tankle(k) * Parameters.transmission_ankle .*...
            (x(k) .* dy(k) - y(k) .* dx(k)) ./ (r(k)^2));
    Jleg = 0;
    Jankle = 0;
    for i = 1:size(dv,2)-1
        Jleg = Jleg + .5 * hk * (wkLeg(i) + wkLeg(i+1));
        Jankle = Jankle + .5 * hk * (wkAnkle(i) + wkAnkle(i+1));
    end
    xFlight = Parameters.apex_velocity * (dv(5,end) - dv(5,1))/Parameters.g;
    xTravel = dv(1,end) - dv(1,1) + xFlight;
    cost = (Jleg + Jankle + sum(abSmooth(ddr0)*hk*Parameters.objWeight))...
        / (Parameters.m * Parameters.g * xTravel);
end