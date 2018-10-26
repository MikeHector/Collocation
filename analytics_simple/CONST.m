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
    
    %Concatenate and reshape collocation constraints
    ceqColl = eqStance;
    ceq = reshape(ceqColl, [size(ceqColl,1)*size(ceqColl,2),1]);
    
    %Names
    stanceEnd = Parameters.N;
    x = dv(1,:);
    y = dv(2,:);
    r0 = dv(3,:);
    dx = dv(4,:);
    dy = dv(5,:);
    dr0 = dv(6,:);
    ddr0 = dv(7,:);
    Tankle = dv(8,:);
    r = sqrt(x.^2 + y.^2);
    dr = (x.*dx + y.*dy)./r;

    %Starting stance constraints
    %Fs starts at 0
    Fleg = Parameters.k * (r0 - r) + Parameters.c * (dr0 - dr);
%     if C.stanceStartWithNoForce == 1
%         eqCon = Fs(1);
%         disp('dont use this?')
%     end
%     
    if C.legStartUncompressed == 1
        %R0 = r @ TD
        eqCon = r0(1) - r(1);
    end

    if C.TDLOenergy == 1
        initialApexE = 1/2 * Parameters.m * Parameters.apex_velocity.^2 +...
                    Parameters.m * Parameters.g * Parameters.apex_height; %Velocity is the same for both with no deltav or deltah

        finalApexE = 1/2 * Parameters.m * (Parameters.apex_velocity + Parameters.deltav).^2 +...
                     Parameters.m * Parameters.g * Parameters.apex_height;
        
        iTemp = [1, stanceEnd];
        startEndE = 1/2 * Parameters.m * ((dx(iTemp)).^2 + dy(iTemp).^2) +...
                    Parameters.m * Parameters.g * y(iTemp);
        eqCon(end+1:end+2) = startEndE - [initialApexE, finalApexE];
    end
    
    if C.xVel == 1
    %x - velocity
        eqCon(end+1) = dx(1) - Parameters.apex_velocity;
        eqCon(end+1) = dx(end) - (Parameters.apex_velocity + Parameters.deltav);
    end
    
    %Ending stance constraints
    %Force in spring is 0
    if C.stanceEndWithNoForce == 1
        eqCon(end+1) = Fleg(stanceEnd);
    end
    
%     if C.liftoffEnergy == 1
%         %y - velocity + position. energy approach
%         eqCon(end+1) = Parameters.g * (y(stanceEnd) - Parameters.apex_height) +...
%                        .5* dy(stanceEnd)^2;
%     end
%     
%     if C.xVelLO == 1
%     %Apex velocity x
%         eqCon(end+1) = dx(stanceEnd) - (Parameters.apex_velocity + Parameters.deltav);
%     end
    
%     if C.dr0StartZero == 1
%         %Leg velocity is 0 at TD
%         eqCon(end+1) = dr0(1);
%     end
%     
%     if C.r0Start == 1
%         %R0 starts at r0 start at TD
%         eqCon(end+1) = r0(1) - Parameters.r0Start;
%     end
    

    
%     %Average velocity
%     if C.averageVelocity == 1
%         eqCon(end+1) = Parameters.average_velocity - (x(stanceEnd) - x(1)) / (dv(9,1));
%     end

%     %Lock the TD angle
    if C.lockTDA == 1
        eqCon(end+1) = Parameters.LockTDA .*...
        (atan2(y(1),x(1)) - (Parameters.baseline_TDA + Parameters.TD_disturb));
    end
    
    eqCon = reshape(eqCon, [numel(eqCon),1]);
    %Concatenate collocation constraints and other constraints
    ceq = [ceq; eqCon];
    
    if C.legForceBound == 1
    %Leg force is bounded
        legForcePos = Fleg - Parameters.fLegMax;
        legForceNeg = Parameters.fLegMin - Fleg;
    else
        legForcePos = [];
        legForceNeg = [];
    end
    
    if C.rBound == 1
        %Constraint on length of spring
        rPos = r - Parameters.rMax;
        rNeg = Parameters.rMin - r;
    else
        rPos = [];
        rNeg = [];
    end
    
    if C.TDLOenergy == 1
       dirYtd = dy(1);
       dirYlo = -dy(end);
    else
        dirYtd = [];
        dirYlo = [];
    end

    %Inequality constraints
%     %Ankle torque bounds
    if C.ankleBound == 1
        ankle_bound = Parameters.lf/2 .* Fleg(1:stanceEnd) .*...
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
    
    c = [Acon1'; Acon2'; minX; legForcePos'; legForceNeg'; rPos'; rNeg'; dirYtd; dirYlo];
    
    %Reshape
    c = reshape(c, [size(c,1)*size(c,2),1]);
    
end
