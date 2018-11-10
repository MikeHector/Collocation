function [cost] = get_energy2(OPT_RES, plotifone)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Tstance = OPT_RES.Tstance;
    r = sqrt(OPT_RES.x.^2 + OPT_RES.y.^2);
    Parameters = OPT_RES.param;
    hk = Tstance/OPT_RES.collParam.N * ones([1,OPT_RES.collParam.N]);
    cost_leg_e = 0;
    cost_leg_m = 0;
    cost_ankle_e = 0;
    cost_ankle_m = 0;
    m = Parameters(1);
    g = Parameters(10);
    k = Parameters(3);
    R_leg = Parameters(4);
    R_ankle = Parameters(5);
    transmission = Parameters(7);
    transmission_ankle = Parameters(9);
    mechA_leg = 1;
    mechA_ankle = 1;
    maxXzero = MikeMax(3);
    abSmooth = @(x) sqrt(x.^2 + eps.^2) - eps;
    for i = 1:OPT_RES.collParam.N
        cost_leg_e = cost_leg_e + 0 * 0.^2 * hk(i);  %electrical
        cle(i) = 0 * 0.^2;  %electrical
        
        cost_leg_m = cost_leg_m + abSmooth(OPT_RES.Fleg(i) * OPT_RES.dr0(i) * hk(i)); %mechanical
        clm(i) = abSmooth(OPT_RES.Fleg(i) * OPT_RES.dr0(i) * hk(i)); %mechanical
        
        cost_ankle_e = cost_ankle_e + 0 * OPT_RES.Tankle(i).^2 * hk(i); %electrical
        cae(i) = 0 * OPT_RES.Tankle(i).^2; %electrical
        
        cost_ankle_m = cost_ankle_m + abSmooth(OPT_RES.Tankle(i).* transmission_ankle *...
        (OPT_RES.x(i) * OPT_RES.dy(i) -OPT_RES.y(i) * OPT_RES.dx(i))/r(i)^2 * hk(i)); %mechanical
        
        cam(i) = abSmooth(OPT_RES.Tankle(i) * transmission_ankle *...
        (OPT_RES.x(i) * OPT_RES.dy(i) -OPT_RES.y(i) * OPT_RES.dx(i))/r(i)^2); %mechanical
    
        xyx(i) = transmission_ankle *...
        (OPT_RES.x(i) * OPT_RES.dy(i) -OPT_RES.y(i) * OPT_RES.dx(i))/r(i)^2; %mechanical
    end
    cost.leg_e = cost_leg_e;
    cost.leg_m = cost_leg_m;
    cost.ankle_e = cost_ankle_e;
    cost.ankle_m = cost_ankle_m;
    
    legPower = OPT_RES.dr0 .* OPT_RES.Fleg;
    anklePower = OPT_RES.Tankle.* transmission_ankle .*...
    (OPT_RES.x .* OPT_RES.dy -OPT_RES.y .* OPT_RES.dx)./OPT_RES.r.^2;

    cost.legPower = legPower;
    cost.anklePower = anklePower;

    
    TorqueToStand = m * g / (transmission/mechA_leg);
    cost.LegEtoStand = 0 * TorqueToStand^2 * Tstance;
    
    if plotifone == 1
        figure;
        plot(OPT_RES.t, cle); hold on;
        plot(OPT_RES.t, clm); plot(OPT_RES.t, cae); plot(OPT_RES.t, cam);
        stand = refline(0,cost.LegEtoStand); stand.LineStyle = '--';
        legend('Leg electrical', 'Leg mechanical', 'Ankle electrical', 'Ankle mechanical', 'Power to stand')
        title('Actuator power contributing to energy consumption')
        xlabel('Time'); ylabel('Actuator power')
    end
    
    if plotifone == 2
        figure;

        plot(OPT_RES.t, legPower); hold on; plot(OPT_RES.t, anklePower);
%         stand = refline(0,cost.LegEtoStand); stand.LineStyle = '--';
        legend('Leg mechanical', 'Ankle mechanical')
        title('Actuator power')
        xlabel('Time'); ylabel('Actuator power')
    end
    
    if plotifone == 3
        figure;
        subplot(7,1,1); plot(OPT_RES.t(1:OPT_RES.collParam.N), OPT_RES.x(1:OPT_RES.collParam.N)); title('x');
        subplot(7,1,2); plot(OPT_RES.t(1:OPT_RES.collParam.N), OPT_RES.y(1:OPT_RES.collParam.N)); title('y');
        subplot(7,1,3); plot(OPT_RES.t(1:OPT_RES.collParam.N), OPT_RES.dx(1:OPT_RES.collParam.N)); title('dx');
        subplot(7,1,4); plot(OPT_RES.t(1:OPT_RES.collParam.N), OPT_RES.dy(1:OPT_RES.collParam.N)); title('dy');
        subplot(7,1,5); plot(OPT_RES.t(1:OPT_RES.collParam.N), OPT_RES.x(1:OPT_RES.collParam.N).*OPT_RES.dy(1:OPT_RES.collParam.N)); title('x times dy');
        subplot(7,1,6); plot(OPT_RES.t(1:OPT_RES.collParam.N), OPT_RES.y(1:OPT_RES.collParam.N).*OPT_RES.dx(1:OPT_RES.collParam.N)); title('y times dx')
        subplot(7,1,7); plot(OPT_RES.t(1:OPT_RES.collParam.N), xyx(1:OPT_RES.collParam.N)); title('XY velocity')
    end
end

