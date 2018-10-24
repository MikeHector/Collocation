function [ c, ceq] = CONST( dv, Parameters, C)
%nonlcon This function determines the violation of the constraints
%   Using trapezoidal collocation, the violation of the constraints is
%   determined by plugging in the decision variables into formulated
%   dynamics such that we expect 0. The difference from that and 0 is our
%   violation


    %Stance collocation constraints
    if C.stanceCollocation ==1
        eqStance = stanceConstraints(dv, Parameters);
    else 
        eqStance = [];
    end
    
    %Flight collocation constraints
    if C.flightCollocation == 1
        eqFlight = flightConstraints(dv, Parameters);
    else
        eqFlight = [];
    end
    
    %Concatenate and reshape collocation constraints
    ceqColl = [eqStance, eqFlight];
    ceq = reshape(ceqColl, [size(ceqColl,1)*size(ceqColl,2),1]);
    
    %Names
    stanceEnd = Parameters.Nstance;
    x = dv(1,:);
    y = dv(2,:);
    r0 = dv(3,:);
    dx = dv(4,:);
    dy = dv(5,:);
    dr0 = dv(6,:);
%     Tleg = dv(7,:);
    Tankle = dv(8,:);
    theta = dv(9,stanceEnd:end);
    r = sqrt(x.^2 + y.^2);
    dr = (x.*dx + y.*dy)./r;
%     apex_height = dv(9,3);
    
%     eqCon = [];  

    %Starting stance constraints
    %Fs starts at 0
    Fs = Parameters.k * (r0 - r) + Parameters.c * (dr0 - dr);
    if C.stanceStartWithNoForce == 1
        eqCon(end+1) = Fs(1);
    end
    
    if C.touchdownEnergy == 1
    %y - velocity + position. energy approach
        eqCon = .5 * dy(1)^2 - Parameters.g * (Parameters.apex_height - y(1));
    end
    
    if C.xVelTD == 1
    %x - velocity
        eqCon(end+1) = dx(1) - Parameters.apex_velocity;
    end
    
    %Ending stance constraints
    %Force in spring is 0
    if C.stanceEndWithNoForce == 1
        eqCon = Fs(stanceEnd);
    end
    
    if C.liftoffEnergy == 1
    %Liftoff energy
        eqCon(end+1) = Parameters.g * (Parameters.apex_height - y(stanceEnd)) - .5 * dy(stanceEnd)^2;
    end
    
    if C.xVelLO == 1
    %Apex velocity x
        eqCon(end+1) = dx(stanceEnd) - (Parameters.apex_velocity + Parameters.deltav);
    end
    
    if C.dr0StartZero == 1
        %Leg velocity is 0 at TD
        eqCon(end+1) = dr0(1);
    end
    
    if C.r0Start == 1
        %R0 starts at r0 start at TD
        eqCon(end+1) = r0(1) - Parameters.r0Start;
    end
    
    if C.r0RTD == 1
        %r0 equals r at TD
        eqCon(end+1) = r0(1) - r(1);
    end
    
    %Ending flight constraints - match initial stance translated in x
    %This could be a linear constraint, but it is implemented here for code
    %robustness
    if C.matchStateNoDeltaV == 1
        inds = [2:8]; 
        eqCon = [eqCon, [dv(inds,end) - dv(inds,1)]'];
    end
    
    if C.matchStateDeltaV == 1
        inds = [2:3, 5:8];  %Also not x dot
        eqCon = [eqCon, [dv(inds,end) - dv(inds,1)]'];
    end
    
    %Average velocity
    if C.averageVelocity == 1
        eqCon(end+1) = Parameters.average_velocity - (x(end) - x(1)) / (dv(9,1) + dv(9,2));
    end

    %Theta stuff
    if C.thetaStartEnd == 1
        %Flight ends at TD angle
        eqCon(end+1) = theta(end) - atan2(y(1), x(1));
        %Flight starts at LO angle
        eqCon(end+1) = theta(1) - atan2(y(stanceEnd), x(stanceEnd));
    end    
    
%     %Lock the TD angle
    if C.lockTDangle == 1
        eqCon(end+1) = Parameters.LockTDA .*...
        (atan2(y(1),x(1)) - (Parameters.baseline_TDA + Parameters.TD_disturb));
    end
    
    eqCon = reshape(eqCon, [numel(eqCon),1]);
    %Concatenate collocation constraints and other constraints
    ceq = [ceq; eqCon];

    %Inequality constraints
    %Ankle torque bounds
    if C.ankleBound == 1
        ankle_bound = Parameters.lf/2 .* Fs(1:stanceEnd) .*...
                      y(1:stanceEnd) ./ r(1:stanceEnd);
        
        Acon1 = Tankle(1:stanceEnd) * Parameters.transmission_ankle - ankle_bound;
        Acon2 = -(Tankle(1:stanceEnd) * Parameters.transmission_ankle + ankle_bound);
    else
        Acon1 = [];
        Acon2 = [];
    end
    
    %Minimum Distance traveled -- implemented as linear constraint
    if C.minDist == 1
        minX = Parameters.xDist - (x(end) - x(1));
    else
        minX = [];
    end
    
    %Theta constraints
    if C.thetaVelocity == 1
        %Angle velocity constraint
        dTFlight = dv(9,2)/Parameters.Nflight;
        for i = 1: numel(theta)-1
            diffTheta(i) = theta(i+1) - theta(i);
        end
        dTheta = diffTheta/dTFlight;
        dThetaConPos = dTheta - Parameters.dthetaMax;
        dThetaConNeg = -(dTheta + Parameters.dthetaMax);
    else
        dThetaConPos = [];
        dThetaConNeg = [];
    end
    
    if C.footHeight == 1
        %Foot height constraints
        footHeight = -(y(stanceEnd+1:end) - r0(stanceEnd+1:end) .* sin(theta(2:end)));
    else
        footHeight = [];
    end
    
    c = [Acon1'; Acon2'; minX; dThetaConPos'; dThetaConNeg'; footHeight'];
    
    %Reshape
    c = reshape(c, [size(c,1)*size(c,2),1]);
    
end
