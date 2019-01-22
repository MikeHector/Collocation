function [out] = get_energy4(opt)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    r = opt.r;
    hk =opt.Tstance/opt.collParam.N;
    eps = .001;
    maxZero = MikeMax(3);
    abSmooth = @(x) sqrt(x.^2 + eps.^2) - eps;
    x = opt.x;
    y = opt.y;
    r0 = opt.r0;
    dx = opt.dx;
    dy = opt.dy;
    dr0 = opt.dr0;
    ddr0 = opt.ddr0;
    Tankle = opt.Tankle;
    dr = (x .* dx + y .* dy) ./ r;
    
    k = opt.param(3); c = opt.param(2); m = opt.param(1);
    I = opt.param(6); alpha = opt.param(25); cObj = opt.param(24);
    apexVel = opt.param(13); g = opt.param(10); ankleTrans = opt.param(9);
    
    wkFdamper = c * (dr0 - dr);
    Fleg = k * (r0 - r) + c * (dr0 - dr);
    Fmotor = Fleg - I * ddr0;
    wkLeg = maxZero((1-alpha) * Fmotor .* dr0 +...
            alpha * Fmotor.^2); %mech and electrical with weight to scale between each
    wkAnkle = maxZero((1-alpha) * Tankle * ankleTrans .*...
            (x .* dy - y .* dx) ./ (r.^2) + alpha * Tankle.^2); %mech and electrical with weight to scale between each
    wkSmooth = abSmooth(ddr0) * cObj;
    
    %calculate energies
    Jleg = trapz(wkLeg.*hk);
    Jankle = trapz(wkAnkle.*hk);
    Jsmooth = trapz(wkSmooth.*hk);
    
    xFlight = apexVel * (dy(end) - dy(1))/g;
    xTravel = x(end) - x(1) + xFlight;
    cost = (Jleg + Jankle + Jsmooth) / (m * g * xTravel);

    out.objEst = cost;
    out.eIn = Jleg+Jankle+Jsmooth;
    out.eOut = trapz(c * (dr0 - dr).^2 .* hk);
    out.dist = xTravel;

%     Tstance = OPT_RES.Tstance;
%     hk = Tstance/OPT_RES.collParam.N;
%     cost_leg_m = 0;
%     cost_ankle_m = 0;
%     m = OPT_RES.param(1);
%     g = OPT_RES.param(10);
%     k = OPT_RES.param(3);
%     c = OPT_RES.param(2);
%     I = OPT_RES.param(6);
% 
%     transmission_ankle = OPT_RES.param(9);    
%     eps = .001;
%     abSmooth = @(x) sqrt(x.^2 + eps.^2) - eps;
%     maxZero = MikeMax(3);
%     
%     Fleg = k * (OPT_RES.r0 - OPT_RES.r) + c *(OPT_RES.dr0 - OPT_RES.dr);
%     Fmotor = Fleg - I*OPT_RES.ddr0;
%     wkLeg = @(k) maxZero(Fmotor(k) .* OPT_RES.dr0(k));
%     wkAnkle = @(k) maxZero(OPT_RES.Tankle(k) * transmission_ankle .*...
%             (OPT_RES.x(k) .* OPT_RES.dy(k) - OPT_RES.y(k) .* OPT_RES.dx(k)) ./ (OPT_RES.r(k).^2));
%     
% 
%     for i = 1:OPT_RES.collParam.N-1
%         cost_leg_m = cost_leg_m + .5 * hk* (wkLeg(i) + wkLeg(i+1));
%         cost_ankle_m = cost_ankle_m + .5 * hk * (wkAnkle(i) + wkAnkle(i+1));
%     end
%     
%     cost.leg_m = cost_leg_m;
%     cost.ankle_m = cost_ankle_m;
%     cost.ringDamp = trapz(abSmooth(OPT_RES.ddr0)*hk*OPT_RES.param(24));
%     
%     %Damper energy
%     hk = diff(OPT_RES.t)';
%     cost.damper = trapz(OPT_RES.param(2) * (OPT_RES.dr0(1:end-1) - OPT_RES.dr(1:end-1)).^2 .* hk);
%     cumDamper = cumtrapz(OPT_RES.param(2) * (OPT_RES.dr0(1:end-1) - OPT_RES.dr(1:end-1)).^2 .* hk);
%     cumLeg = cumtrapz(hk.*wkLeg(1:length(OPT_RES.t)-1));
%     cumAnkle = cumtrapz(hk.*wkAnkle(1:length(OPT_RES.t)-1));
%     cost.cumIn = cumLeg + cumAnkle;
%     cost.cumOut = cumDamper;
% 
%     xFlight = OPT_RES.param(13) * (OPT_RES.dy(end) - OPT_RES.dy(1))/ g;
%     xTravel = xFlight + OPT_RES.x(end) - OPT_RES.x(1);
%     cost.objEst = (cost_leg_m+cost_ankle_m + cost.ringDamp) ./ (m*g*xTravel);
%     legPower = OPT_RES.dr0 .* OPT_RES.Fleg;
%     anklePower = OPT_RES.Tankle.* transmission_ankle .*...
%     (OPT_RES.x .* OPT_RES.dy -OPT_RES.y .* OPT_RES.dx)./OPT_RES.r.^2;
% 
%     cost.legPower = legPower;
%     cost.anklePower = anklePower; 
end

