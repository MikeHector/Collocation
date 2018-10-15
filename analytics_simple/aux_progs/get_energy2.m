function [cost] = get_energy2(OPT_RES, plotifone)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Tstance = OPT_RES.Tstance;
    Tflight = OPT_RES.Tflight;
    r = sqrt(OPT_RES.x.^2 + OPT_RES.y.^2);
    Parameters = OPT_RES.param;
    hk = [Tstance/OPT_RES.collParam.Nstance * ones([1,OPT_RES.collParam.Nstance]),...
          Tflight/OPT_RES.collParam.Nflight * ones([1,OPT_RES.collParam.Nflight])];
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
    
    for i = 1:OPT_RES.collParam.N-1
        cost_leg_e = cost_leg_e + R_leg * OPT_RES.Tleg(i).^2 * hk(i);  %electrical
        cle(i) = R_leg * OPT_RES.Tleg(i).^2;  %electrical
        
        cost_leg_m = cost_leg_m + maxXzero(OPT_RES.Tleg(i) * transmission / mechA_leg * OPT_RES.dr0(i) * hk(i)); %mechanical
        clm(i) = maxXzero(OPT_RES.Tleg(i) * transmission / mechA_leg * OPT_RES.dr0(i)); %mechanical
        
        cost_ankle_e = cost_ankle_e + R_ankle * OPT_RES.Tankle(i).^2 * hk(i); %electrical
        cae(i) = R_ankle * OPT_RES.Tankle(i).^2; %electrical
        
        cost_ankle_m = cost_ankle_m + maxXzero(OPT_RES.Tankle(i).* transmission_ankle *...
        (OPT_RES.x(i) * OPT_RES.dy(i) -OPT_RES.y(i) * OPT_RES.dx(i))/r(i)^2 * hk(i)); %mechanical
        
        cam(i) = maxXzero(OPT_RES.Tankle(i) * transmission_ankle *...
        (OPT_RES.x(i) * OPT_RES.dy(i) -OPT_RES.y(i) * OPT_RES.dx(i))/r(i)^2); %mechanical
    
        xyx(i) = transmission_ankle *...
        (OPT_RES.x(i) * OPT_RES.dy(i) -OPT_RES.y(i) * OPT_RES.dx(i))/r(i)^2; %mechanical
    end
    cost.leg_e = cost_leg_e;
    cost.leg_m = cost_leg_m;
    cost.ankle_e = cost_ankle_e;
    cost.ankle_m = cost_ankle_m;
    
    TorqueToStand = m * g / (transmission/mechA_leg);
    cost.LegEtoStand = R_leg * TorqueToStand^2 * Tstance;
    
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
        plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), cle(1:OPT_RES.collParam.Nstance)); hold on;
        plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), clm(1:OPT_RES.collParam.Nstance)); plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), cae(1:OPT_RES.collParam.Nstance)); plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), cam(1:OPT_RES.collParam.Nstance));
        stand = refline(0,cost.LegEtoStand); stand.LineStyle = '--';
        legend('Leg electrical', 'Leg mechanical', 'Ankle electrical', 'Ankle mechanical', 'Power to stand')
        title('Actuator power contributing to energy consumption')
        xlabel('Time'); ylabel('Actuator power')
    end
    
    if plotifone == 3
        figure;
        subplot(7,1,1); plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), OPT_RES.x(1:OPT_RES.collParam.Nstance)); title('x');
        subplot(7,1,2); plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), OPT_RES.y(1:OPT_RES.collParam.Nstance)); title('y');
        subplot(7,1,3); plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), OPT_RES.dx(1:OPT_RES.collParam.Nstance)); title('dx');
        subplot(7,1,4); plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), OPT_RES.dy(1:OPT_RES.collParam.Nstance)); title('dy');
        subplot(7,1,5); plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), OPT_RES.x(1:OPT_RES.collParam.Nstance).*OPT_RES.dy(1:OPT_RES.collParam.Nstance)); title('x times dy');
        subplot(7,1,6); plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), OPT_RES.y(1:OPT_RES.collParam.Nstance).*OPT_RES.dx(1:OPT_RES.collParam.Nstance)); title('y times dx')
        subplot(7,1,7); plot(OPT_RES.t(1:OPT_RES.collParam.Nstance), xyx(1:OPT_RES.collParam.Nstance)); title('XY velocity')
    end
end

