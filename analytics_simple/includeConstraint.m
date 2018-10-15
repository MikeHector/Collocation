function [C] = includeConstraint(optNumber)
%This function returns the constraints that should be used in CONST
%function

switch optNumber

    case 1
    % OPTIMIZATION 1: simple
    C.optNumber = optNumber;

    %Stance collocation constraints
    C.stanceCollocation = 1;

    %Fs starts at 0
    C.stanceStartWithNoForce = 1;

    %y - velocity + position. energy approach  
    C.touchdownEnergy = 1;

    %x - velocity 
    C.xVelTD = 1;

    %Force in spring is 0 at end
    C.stanceEndWithNoForce = 1;

    %Liftoff energy
    C.liftoffEnergy = 1;

    %Apex velocity x
    C.xVelLO = 1;

    %Leg velocity is 0 at TD
    C.dr0StartZero = 0;

    %R0 starts at r0 start at TD
    C.r0Start = 0;
    
    %r0 = r @ TD
    C.legStartUncompressed = 1;
    
    %Average velocity
    C.averageVelocity = 0;

    %Lock the TD angle
    C.lockTDangle = 0;

    %Leg force is bounded
    C.legForceBound = 1;

    %Constraint on length of spring
    C.rBound = 1;

    %Ankle torque bounds
    C.ankleBound = 1;

    %Minimum Distance traveled -- implemented as linear constraint
    C.minDist = 1;
end