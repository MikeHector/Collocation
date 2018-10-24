function [] = energyInOut(o, plotStuff)
%ENERGYINOUT Summary of this function goes here
%   Detailed explanation goes here

    stanceEnd = o.collParam.Nstance;
    v = sqrt(o.dx.^2 + o.dy.^2);  
    dr = (o.dx.*o.x + o.dy .* o.y) ./ o.r;
    km = .5 * o.param(1) * v.^2; %Kinetic energy of the COM
    vm = o.param(1) * o.param(10) * o.y; %Potenetial energy of the COM
    ki = .5 * o.param(6) * o.param(7)^2 * (o.dr0).^2; %Kinetic energy of the rotor
    
    vs = zeros(size(ki));
    vs(1:stanceEnd) = .5 * o.param(3) * (o.r0(1:stanceEnd) - o.r(1:stanceEnd)).^2;%Potential energy of the spring

    %System energy should be the same at the beginning and end of limit
    %cycle
    sysE = km+ vm+ ki+ vs;
    
    %Energy inputs/ outputs
    %Integrate over time
    hk = diff(o.t)';
    hk = [hk;hk(end)];
    d = zeros(size(hk));
    d(1:stanceEnd) = cumsum(o.param(2) * (o.dr0(1:stanceEnd) - dr(1:stanceEnd)).^2 .* hk(1:stanceEnd));%Dissipation of the damper
    d(stanceEnd+1:end) = d(stanceEnd);
    lm = cumsum(o.Tleg .* o.param(7) .* o.dr0.*hk); %mechanical energy added by leg
    am = cumsum(o.Tankle .* o.param(9) .*(o.x .* o.dy - o.y .* o.dx) ./ o.r.^2 .* hk); %mechanical energy added by ankle
    
    Ein = lm + am;
    Eout = d;
    
 
    %Fact 1
    disp(['Difference between system energy at the beginning and end is ',...
           num2str(abs(sysE(1) - sysE(end)))]);
    %Fact 2
    disp(['Difference between energy inserted by actuators and energy disapated by damper is ',...
           num2str(abs(Ein(end) - Eout(end)))]);
   
   if plotStuff == 1
       figure; 
       subplot(2,1,1); plot(o.t, sysE); title('System energy over time');
       ylabel('Kinetic and potential energy of mass and rotor');
       xlabel('Time')

       subplot(2,1,2); plot(o.t, [Ein, Eout]); title('Energy in and out of cycle');
       ylabel('Kinetic and potential energy of mass and rotor');
       xlabel('Time')
       legend('Energy in through actuators','Energy out through damper')
   end
end

