function [symDvBlock] = dvSymList2Block(symDvList,collParam, flightphase)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if flightphase ==1
    cp = collParam.N -1; %Number of collocation points
    x = symDvList(1:1*cp);
    y = symDvList(1+1*cp:2*cp);
    r0 = symDvList(1+2*cp:3*cp);
    dx = symDvList(1+3*cp:4*cp);
    dy = symDvList(1+4*cp:5*cp);
    dr0 = symDvList(1+5*cp:6*cp);
    Tleg = symDvList(1+6*cp:7*cp);
    Tankle = symDvList(1+7*cp:8*cp);
    theta = symDvList(8*cp+1:8*cp+collParam.Nflight);
    apex_height = symDvList(8*cp+collParam.Nflight +3);
    Tstance = symDvList(8*cp+collParam.Nflight +1);
    Tflight = symDvList(8*cp+collParam.Nflight +2);
    
%     symDvBlock = zeros(9,collParam.N-1);
    symDvBlock(1,:) = x;
    symDvBlock(2,:) = y;
    symDvBlock(3,:) = r0;
    symDvBlock(4,:) = dx;
    symDvBlock(5,:) = dy;
    symDvBlock(6,:) = dr0;
    symDvBlock(7,:) = Tleg;
    symDvBlock(8,:) = Tankle;
    symDvBlock(9,collParam.Nstance:end) = theta;
    symDvBlock(9,1) = Tstance;
    symDvBlock(9,2) = Tflight;
    symDvBlock(9,3) = apex_height;
    

else
    cp = collParam.N;
    x = symDvList(1:1*cp);
    y = symDvList(1+1*cp:2*cp);
    r0 = symDvList(1+2*cp:3*cp);
    dx = symDvList(1+3*cp:4*cp);
    dy = symDvList(1+4*cp:5*cp);
    dr0 = symDvList(1+5*cp:6*cp);
    Tleg = symDvList(1+6*cp:7*cp);
    Tankle = symDvList(1+7*cp:8*cp);
    
    symDvBlock(1,:) = x;
    symDvBlock(2,:) = y;
    symDvBlock(3,:) = r0;
    symDvBlock(4,:) = dx;
    symDvBlock(5,:) = dy;
    symDvBlock(6,:) = dr0;
    symDvBlock(7,:) = Tleg;
    symDvBlock(8,:) = Tankle;
        
    
    
end

    
end

