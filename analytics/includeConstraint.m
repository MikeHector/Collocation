function [C] = includeConstraint(optNumber)
%This function returns the constraints that should be used in CONST
%function

switch optNumber

case 1
% OPTIMIZATION 1: Complex
C.optNumber = optNumber;
%Free apex height, average velocity, ankle constraints, swing leg dyn,
%TD angle toggle, foot height

%Stance collocation constraints
C.stanceCollocation = 1;

%Flight collocation constraints
C.flightCollocation = 1;

%Stance starts with force in the spring at 0 N
C.stanceStartWithNoForce = 0;

%Stance Ends with no force in the spring
C.stanceEndWithNoForce = 1;

%Average Velocity is prescribed
C.averageVelocity = 0;

%Leg starts and ends at same TD angle
C.thetaStartEnd = 0;

%Lock the TD angle
C.lockTDangle = 1;

%Ankle torque bounds based on statics
C.ankleBound = 1;

%Swing leg theta velocity constraints
C.thetaVelocity = 0;

%Swing leg foot height constraints
C.footHeight = 0;

%Match beginning and ending state shifted in x and xdot
C.matchStateDeltaV = 0;

%Set the minimum distance traveled
C.minDist = 0;

%Apex-Apex Constraints
%Touchdown energy
C.touchdownEnergy = 1;

%X velocity at touchdown
C.xVelTD = 1;

%Lift off energy
C.liftoffEnergy = 1;

%X velocity at liftoff
C.xVelLO = 1;

%dr0 start is 0
C.dr0StartZero = 0;

%r0 start is locked
C.r0Start = 0;

%Spring starts uncompressed
C.r0RTD = 1;

%Match beginning and ending state shifted in x
C.matchStateNoDeltaV = 1;

%Match beginning and ending state shifted in x and xdot
%(if deltav parameter is used)
C.matchStateDeltaV = 0;



case 2
% OPTIMIZATION 2: Prismatic leg
C.optNumber = optNumber;

%Stance collocation constraints
C.stanceCollocation = 1;

%Stance flight constraints
C.flightCollocation = 0;

%Stance starts with force in the spring at 0 N
C.stanceStartWithNoForce = 1;

%Stance Ends with no force in the spring
C.stanceEndWithNoForce = 1;

%Average Velocity is prescribed
C.averageVelocity = 0;

%Lock the TD angle
C.lockTDangle = 1;

%Ankle torque bounds based on statics
C.ankleBound = 1;

case 3
% OPTIMIZATION 3: Complex with no ankle torque bounds
C.optNumber = optNumber;
%Free apex height, average velocity, ankle constraints, swing leg dyn,
%TD angle toggle, foot height

%Stance collocation constraints
C.stanceCollocation = 1;

%Flight collocation constraints
C.flightCollocation = 1;

%Stance starts with force in the spring at 0 N
C.stanceStartWithNoForce = 1;

%Stance Ends with no force in the spring
C.stanceEndWithNoForce = 1;

%Average Velocity is prescribed
C.averageVelocity = 1;

%Leg starts and ends at same TD angle
C.thetaStartEnd = 1;

%Lock the TD angle
C.lockTDangle = 1;

%Ankle torque bounds based on statics
C.ankleBound = 0;

%Swing leg theta velocity constraints
C.thetaVelocity = 1;

%Swing leg foot height constraints
C.footHeight = 1;

%Match beginning and ending state shifted in x
C.matchState = 1;

%Match beginning and ending state shifted in x and xdot
C.matchStateDeltaV = 0;

%Set the minimum distance traveled
C.minDist = 1;

%Apex-Apex Constraints
%Touchdown energy
C.touchdownEnergy = 0;

%X velocity at touchdown
C.xVelTD = 0;

%Lift off energy
C.liftoffEnergy = 0;

%X velocity at liftoff
C.xVelLO = 0;

%dr0 start is 0
C.dr0StartZero = 0;

%r0 start is locked
C.r0Start = 0;

%Match beginning and ending state shifted in x
C.matchStateNoDeltaV = 1;

%Match beginning and ending state shifted in x and xdot
%(if deltav parameter is used)
C.matchStateDeltaV = 0;

    case 4
% OPTIMIZATION 3: Back to old constraints: just a flight phase with
% questionable constraints which Christian blessed
C.optNumber = optNumber;
%Free apex height, average velocity, ankle constraints, swing leg dyn,
%TD angle toggle, foot height

%Stance collocation constraints
C.stanceCollocation = 1;

%Flight collocation constraints
C.flightCollocation = 0;

%Stance starts with force in the spring at 0 N
C.stanceStartWithNoForce = 1;

%Stance Ends with no force in the spring
C.stanceEndWithNoForce = 1;

%Average Velocity is prescribed
C.averageVelocity = 0;

%Leg starts and ends at same TD angle
C.thetaStartEnd = 0;

%Lock the TD angle
C.lockTDangle = 1;

%Ankle torque bounds based on statics
C.ankleBound = 1;

%Swing leg theta velocity constraints
C.thetaVelocity = 0;

%Swing leg foot height constraints
C.footHeight = 0;

%Match beginning and ending state shifted in x
C.matchState = 0;

%Match beginning and ending state shifted in x and xdot
C.matchStateDeltaV = 0;

%Set the minimum distance traveled
C.minDist = 0;

%Apex-Apex Constraints
%Touchdown energy
C.touchdownEnergy = 1;

%X velocity at touchdown
C.xVelTD = 1;

%Lift off energy
C.liftoffEnergy = 1;

%X velocity at liftoff
C.xVelLO = 1;

%Leg velocity is 0 at TD
C.dr0StartZero = 1;

%R0 starts at r0 start at TD
C.r0Start = 1;

case 5
% OPTIMIZATION 5: apex apex
C.optNumber = optNumber;
%Free apex height, average velocity, ankle constraints, swing leg dyn,
%TD angle toggle, foot height

%Stance collocation constraints
C.stanceCollocation = 1;

%Flight collocation constraints
C.flightCollocation = 1;

%Stance starts with force in the spring at 0 N
C.stanceStartWithNoForce = 1;

%Stance Ends with no force in the spring
C.stanceEndWithNoForce = 1;

%Average Velocity is prescribed
C.averageVelocity = 0;

%Leg starts and ends at same TD angle
C.thetaStartEnd = 1;

%Lock the TD angle
C.lockTDangle = 1;

%Ankle torque bounds based on statics
C.ankleBound = 1;

%Swing leg theta velocity constraints
C.thetaVelocity = 1;

%Swing leg foot height constraints
C.footHeight = 1;

%Match beginning and ending state shifted in x
C.matchState = 1;

%Match beginning and ending state shifted in x and xdot
C.matchStateDeltaV = 0;

%Set the minimum distance traveled
C.minDist = 1;

%Apex-Apex Constraints
%Touchdown energy
C.touchdownEnergy = 1;

%X velocity at touchdown
C.xVelTD = 1;

%Lift off energy
C.liftoffEnergy = 1;

%X velocity at liftoff
C.xVelLO = 1;

%dr0 start is 0
C.dr0StartZero = 0;

%r0 start is locked
C.r0Start = 0;

%Match beginning and ending state shifted in x
C.matchStateNoDeltaV = 1;

%Match beginning and ending state shifted in x and xdot
%(if deltav parameter is used)
C.matchStateDeltaV = 0;

case 6
% OPTIMIZATION 1: Complex with dr0(0) = 0 
C.optNumber = optNumber;
%Free apex height, average velocity, ankle constraints, swing leg dyn,
%TD angle toggle, foot height

%Stance collocation constraints
C.stanceCollocation = 1;

%Flight collocation constraints
C.flightCollocation = 1;

%Stance starts with force in the spring at 0 N
C.stanceStartWithNoForce = 1;

%Stance Ends with no force in the spring
C.stanceEndWithNoForce = 1;

%Average Velocity is prescribed
C.averageVelocity = 1;

%Leg starts and ends at same TD angle
C.thetaStartEnd = 1;

%Lock the TD angle
C.lockTDangle = 1;

%Ankle torque bounds based on statics
C.ankleBound = 1;

%Swing leg theta velocity constraints
C.thetaVelocity = 1;

%Swing leg foot height constraints
C.footHeight = 1;

%Match beginning and ending state shifted in x
C.matchState = 1;

%Match beginning and ending state shifted in x and xdot
C.matchStateDeltaV = 0;

%Set the minimum distance traveled
C.minDist = 1;

%Apex-Apex Constraints
%Touchdown energy
C.touchdownEnergy = 0;

%X velocity at touchdown
C.xVelTD = 0;

%Lift off energy
C.liftoffEnergy = 0;

%X velocity at liftoff
C.xVelLO = 0;

%dr0 start is 0
C.dr0StartZero = 1;

%r0 start is locked
C.r0Start = 0;

%Match beginning and ending state shifted in x
C.matchStateNoDeltaV = 1;

%Match beginning and ending state shifted in x and xdot
%(if deltav parameter is used)
C.matchStateDeltaV = 0;

end