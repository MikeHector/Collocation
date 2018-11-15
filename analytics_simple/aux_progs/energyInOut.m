function [beginEndError, inOutError] = energyInOut(o, plotStuff)
%ENERGYINOUT Summary of this function goes here
%   Detailed explanation goes here

    v = sqrt(o.dx.^2 + o.dy.^2);  
    dr = (o.dx.*o.x + o.dy .* o.y) ./ o.r;
    km = .5 * o.param(1) * v.^2; %Kinetic energy of the COM
    vm = o.param(1) * o.param(10) * o.y; %Potenetial energy of the COM    
    
    vs = .5 * o.param(3) * (o.r0 - o.r).^2;%Potential energy of the spring

    %System energy should be the same at the beginning and end of limit
    %cycle
    sysE = km+ vm+ vs;
    
    %Energy inputs/ outputs
    %Integrate over time
    hk = diff(o.t)';
    hk = [hk;hk(end)];
    d = cumtrapz(o.param(2) * (o.dr0 - dr).^2 .* hk);%Dissipation of the damper
    lm = cumtrapz(o.Fleg .* o.dr0.*hk); %mechanical energy added by leg
    am = cumtrapz(o.Tankle .* o.param(9) .*(o.x .* o.dy - o.y .* o.dx) ./ o.r.^2 .* hk); %mechanical energy added by ankle
    
    Ein = lm + am;
    Eout = d;
 
    beginEndError = abs(sysE(1) - sysE(end));
    inOutError =abs(Ein(end) - Eout(end));
    %Fact 1
    disp(['Difference between system energy at the beginning and end is ',...
           num2str(beginEndError)]);
    %Fact 2
    disp(['Difference between energy inserted by actuators and energy disapated by damper is ',...
           num2str(inOutError)]);
   
   if plotStuff == 1
       figure; 
       subplot(3,1,1); plot(o.t, sysE); title('System energy over time');
       ylabel('Energy of mass');
       xlabel('Time')
       grid on

       subplot(3,1,2); plot(o.t, [Ein, Eout]); title('Energy in and out of cycle');
       ylabel('Cumulative energy contribution');
       xlabel('Time')
       legend('Energy in through actuators','Energy dissipated by damper','Location','Northwest')
       grid on
       
       subplot(3,1,3); plot(o.t, [lm, am]); title('Actuator contributions');
       ylabel('Cumulative energy contribution');
       xlabel('Time')
       legend('Leg motor','Ankle motor','Location','Northwest')
       grid on
   end
end

