function [ cost ] = OBJ_F( dv, Parameters, smooth )
%objective_function This function evaluates the objective function
%   This function uses Decision variables and calculates the objective
%   function or cost
    r = sqrt(dv(1,:).^2 + dv(2,:).^2);
    hk = dv(9,1)/Parameters.N;
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
    Fmotor = Fleg - Parameters.i_motor * ddr0;
    wkLeg = maxZero((1-Parameters.c_objWeight) * Fmotor .* dr0 +...
            Parameters.c_objWeight * Fmotor.^2); %mech and electrical with weight to scale between each
    wkAnkle = maxZero((1-Parameters.c_objWeight) * Tankle * Parameters.transmission_ankle .*...
            (x .* dy - y .* dx) ./ (r.^2) + Parameters.c_objWeight * Tankle.^2); %mech and electrical with weight to scale between each
    wkSmooth = abSmooth(ddr0) * Parameters.objWeight;
    
    %calculate energies
    Jleg = trapz(wkLeg.*hk);
    Jankle = trapz(wkAnkle.*hk);
    Jsmooth = trapz(wkSmooth.*hk);
    
    xFlight = Parameters.apex_velocity * (dv(5,end) - dv(5,1))/Parameters.g;
    xTravel = dv(1,end) - dv(1,1) + xFlight;
    cost = (Jleg + Jankle + Jsmooth) / (Parameters.m * Parameters.g * xTravel);
end