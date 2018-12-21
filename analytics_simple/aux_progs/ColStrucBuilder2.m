%MHector
%7.25.18
%Coll sturcture builder

function [ColStrucArray] = ColStrucBuilder()
colls = 0;
%Damping
%1
colStruc.direction = {'up','down'};
colStruc.varName = 'c';
colStruc.deltaVar = .01;
colStruc.varMax = 1.5;
colStruc.varMin = -.001;
colStruc.var = .5; %Initial variable value
colStruc.varInd = 2;
ColStrucArray.Damping = colStruc;
colls1 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls1;
clear colStruc

%Changing Average Apex Velocity
%2
colStruc.direction = {'up','down'};
colStruc.varName = 'apex_velocity';
colStruc.deltaVar = .005;
colStruc.varMax = 3;
colStruc.varMin = .2;
colStruc.var = 1;
colStruc.varInd = 13;
ColStrucArray.ApexVelocity = colStruc;
colls2 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls2;
clear colStruc

%Changing Apex Height
%3
colStruc.direction = {'up','down'};
colStruc.varName = 'apex_height';
colStruc.deltaVar = .001;
colStruc.varMax = 1.3;
colStruc.varMin = .7;
colStruc.var = 1;
colStruc.varInd = 12;
ColStrucArray.ApexHeight = colStruc;
colls3 = (abs(colStruc.varMax - colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls3;
clear colStruc

%Changing Force Disturbance
%4
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
%5
colStruc.direction = {'up','down'};
colStruc.varName = 'TD_disturb';
colStruc.deltaVar = .005;
colStruc.varMax = .3;
colStruc.varMin = -.3;
colStruc.var = 0;
colStruc.varInd = 18;
ColStrucArray.TouchDownAngleError = colStruc;
colls4 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls4;
clear colStruc

%Changing Velocity Between Apexes
%6
colStruc.direction = {'up','down'};
colStruc.varName = 'deltav';
colStruc.deltaVar = .02;
colStruc.varMax = 1;
colStruc.varMin = -1;
colStruc.var = 0;
colStruc.varInd = 14;
ColStrucArray.VelocityBetweenApexes = colStruc;
colls5 = (abs(colStruc.varMax) + abs(colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls5;
clear colStruc

%Changing Heights Between Apexes
%7
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
%8
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
%9
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

%Changing Max Leg extension
%10
colStruc.direction = {'up','down'};
colStruc.varName = 'rMax';
colStruc.deltaVar = .005;
colStruc.varMax = 1.1;
colStruc.varMin = .5;
colStruc.var = 1;
colStruc.varInd = 23;
ColStrucArray.rMax = colStruc;
colls3 = (abs(colStruc.varMax - colStruc.varMin))/colStruc.deltaVar;
colls = colls + colls3;
clear colStruc

end
