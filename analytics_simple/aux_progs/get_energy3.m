function [cost] = get_energy3(OPT_RES)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Tstance = OPT_RES.Tstance;
    hk = Tstance/OPT_RES.collParam.N;
    cost_leg_m = 0;
    cost_ankle_m = 0;
    m = OPT_RES.param(1);
    g = OPT_RES.param(10);
    k = OPT_RES.param(3);
    c = OPT_RES.param(2);

    transmission_ankle = OPT_RES.param(9);    
    eps = .001;
    abSmooth = @(x) sqrt(x.^2 + eps.^2) - eps;
    
    Fleg = k * (OPT_RES.r0 - OPT_RES.r) + c *(OPT_RES.dr0 - OPT_RES.dr);
    wkLeg = @(k) abSmooth(Fleg(k) .* OPT_RES.dr0(k));
    wkAnkle = @(k) abSmooth(OPT_RES.Tankle(k) * transmission_ankle .*...
            (OPT_RES.x(k) .* OPT_RES.dy(k) - OPT_RES.y(k) .* OPT_RES.dx(k)) ./ (OPT_RES.r(k)^2));
    

    for i = 1:OPT_RES.collParam.N-1
        cost_leg_m = cost_leg_m + .5 * hk* (wkLeg(i) + wkLeg(i+1));
        cost_ankle_m = cost_ankle_m + .5 * hk * (wkAnkle(i) + wkAnkle(i+1));
    end
    
    cost.leg_m = cost_leg_m;
    cost.ankle_m = cost_ankle_m;
    cost.ringDamp = sum(abSmooth(OPT_RES.ddr0)*hk*OPT_RES.param(24));
    
    %Damper energy
    hk = diff(OPT_RES.t)';
    cost.damper = trapz(OPT_RES.param(2) * (OPT_RES.dr0(1:end-1) - OPT_RES.dr(1:end-1)).^2 .* hk);

    xFlight = OPT_RES.param(13) * (OPT_RES.dy(end) - OPT_RES.dy(1))/ g;
    xTravel = xFlight + OPT_RES.x(end) - OPT_RES.x(1);
    cost.objEst = (cost_leg_m+cost_ankle_m + cost.ringDamp) ./ (m*g*xTravel);
    legPower = OPT_RES.dr0 .* OPT_RES.Fleg;
    anklePower = OPT_RES.Tankle.* transmission_ankle .*...
    (OPT_RES.x .* OPT_RES.dy -OPT_RES.y .* OPT_RES.dx)./OPT_RES.r.^2;

    cost.legPower = legPower;
    cost.anklePower = anklePower; 
end

