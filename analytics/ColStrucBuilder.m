%MHector
%7.25.18
%Coll sturcture builder

function [ColStrucArray] = ColStrucBuilder()
colls = 0;
%Damping
colStruc.direction = {'up'};
colStruc.varName = 'c';
colStruc.deltaVar = 1;
colStruc.varMax = 400;
colStruc.varMin = -1;
colStruc.var = 0; %Initial variable value
ColStrucArray.Damping = colStruc;
colls1 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls1;
clear colStruc

%Changing Apex Velocity
colStruc.direction = {'down'};
colStruc.varName = 'apex_velocity';
colStruc.deltaVar = .05;
colStruc.varMax = 3;
colStruc.varMin = .1;
colStruc.var = 1;
ColStrucArray.ApexVelocity = colStruc;
colls2 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls2;
clear colStruc

%Changing Force Disturbance
colStruc.direction = {'up','down'};
colStruc.varName = 'disturbance_f';
colStruc.deltaVar = 2;
colStruc.varMax = 200;
colStruc.varMin = -200;
colStruc.var = 0;
ColStrucArray.ForceDisturbance = colStruc;
colls3 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls3;
clear colStruc

%Changing Touch Down Angle Error
colStruc.direction = {'up','down'};
colStruc.varName = 'TD_disturb';
colStruc.deltaVar = .002;
colStruc.varMax = .3;
colStruc.varMin = -.3;
colStruc.var = 0;
ColStrucArray.TouchDownAngleError = colStruc;
colls4 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls4;
clear colStruc

%Changing Velocity Between Apexes
colStruc.direction = {'up','down'};
colStruc.varName = 'deltav';
colStruc.deltaVar = .02;
colStruc.varMax = 3;
colStruc.varMin = -.75;
colStruc.var = 0;
ColStrucArray.VelocityBetweenApexes = colStruc;
colls5 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls5;
clear colStruc

%Changing Heights Between Apexes
colStruc.direction = {'up','down'};
colStruc.varName = 'deltah';
colStruc.deltaVar = .005;
colStruc.varMax = .5;
colStruc.varMin = -.1;
colStruc.var = 0;
ColStrucArray.HeightBetweenApexes = colStruc;
colls6 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls6;
clear colStruc

%Changing R_ankle
colStruc.direction = {'down'};
colStruc.varName = 'R_ankle';
colStruc.deltaVar = 2;
colStruc.varMax = 215;
colStruc.varMin = 3;
colStruc.var = 214.5;
ColStrucArray.AnkleMotor = colStruc;
colls7 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls7;
clear colStruc

%Changing R_leg
colStruc.direction = {'up'};
colStruc.varName = 'R_leg';
colStruc.deltaVar = .2;
colStruc.varMax = 25;
colStruc.varMin = 0;
colStruc.var = 0;
ColStrucArray.LegMotor = colStruc;
colls8 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls8;
clear colStruc

end
