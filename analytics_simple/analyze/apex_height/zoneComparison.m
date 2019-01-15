%MHector
%1.13.19
%Make a fancy figure showing some example trajectories to illustrate
%affects of each zone

close all; clear;
varName = 'apex_height';

sa = loadResults('apex_height',1);

s = loadResults('apex_height',0);

%Make the baseline figure (axes and rmax circle)
figure;
% subplot(1,2,2)
% mainAx = axes('Position',[0.1 0.1 .85 .85]);
maxApexH = max(sa.var_graph);
yaxis = plot([0 0],[0 maxApexH], 'k','LineWidth', 2); hold on; 
xaxis = plot([-maxApexH maxApexH],[0 0], 'k', 'LineWidth', 2);
t = 0:.001:pi;
rMax = sa.res{1}.param(23);
rMaxCircle = plot(rMax*cos(t),rMax*sin(t),'k--', 'LineWidth', 2);
axis equal

%Make the Ankle Utility figure?
% ankleU = axes('Position',[.5 .5 .2 .2]);
% axes(mainAx); axis equal;
% axes(ankleU);
% subplot(1,2,1)



%Zone 1: Low apexH to .926
%High level: During this zone, apex height is much lower than the max leg
%extension, so the SLIP is able to choose touchdown and liftoff points
%extremely close to the apex heights while maintaining reasonable touchdown
%angles. Thus trajectories in this zone dissipate very little energy
%through dampers and travel reasonably far.
%The advantage of using an ankle in this zone is reducing the energy
%dissipated by the damper very slightly at an even smaller cost of
%decreasing the distance traveled. Improvements from the ankle in this zone
%are below 5%.

% zone1LowerB = plot([-maxApexH maxApexH], [min(sa.var_graph) min(sa.var_graph)], 'r--');
% zone1UpperB = plot([-maxApexH maxApexH], [.926 .926], 'r--');

upBoundInd = find(round(sa.var_graph,5) == .926); %Index of example trajectory
q = 1;
exampleTrajAnkle = [];
for i = floor(linspace(1,upBoundInd,3))
% exampleTrajApexH = plot([-maxApexH maxApexH],sa.var_graph(exInd)*[1 1], 'k', 'LineWidth', .5);
    exampleTrajAnkle{q} = plot(sa.full{i}.x, sa.full{i}.y, 'b', 'LineWidth', .5);
% exampleTrajNoAnkle = plot(s.res{exInd}.x, s.res{exInd}.y, 'g', 'LineWidth', 2)
    q = q+1;
end

%Zone 2: .926 to .948
%High level: This zone begins when the apex height is high enough that
%the optimizer chooses to land at that height with maximum leg extension.
%This starts a zone where significant differences can be found between trajectories
%with and without ankles. Trajectories without an ankle immediately  

%Fade the previous zone
for i = 1:numel(exampleTrajAnkle)
    exampleTrajAnkle{i}.Color = [.92 .92 1];
end
%Find new bounds
lowBoundInd = upBoundInd;
upBoundInd = find(round(sa.var_graph,5) == .948); %Index of example trajectory

%Draw trajectories
for i = floor(linspace(lowBoundInd,upBoundInd,3))
% exampleTrajApexH = plot([-maxApexH maxApexH],sa.var_graph(exInd)*[1 1], 'k', 'LineWidth', .5);
    exampleTrajAnkle{q} = plot(sa.full{i}.x, sa.full{i}.y, 'b', 'LineWidth', .5);
% exampleTrajNoAnkle = plot(s.res{exInd}.x, s.res{exInd}.y, 'g', 'LineWidth', 2)
    q = q+1;
end

%Zone 3: .948 to .990
%Fade the previous zone
for i = 1:numel(exampleTrajAnkle)
    exampleTrajAnkle{i}.Color = [.92 .92 1];
end
%Find new bounds
lowBoundInd = upBoundInd;
upBoundInd = find(round(sa.var_graph,5) == .99); %Index of example trajectory

%Draw trajectories
for i = floor(linspace(lowBoundInd,upBoundInd,3))
% exampleTrajApexH = plot([-maxApexH maxApexH],sa.var_graph(exInd)*[1 1], 'k', 'LineWidth', .5);
    exampleTrajAnkle{q} = plot(sa.full{i}.x, sa.full{i}.y, 'b', 'LineWidth', .5);
% exampleTrajNoAnkle = plot(s.res{exInd}.x, s.res{exInd}.y, 'g', 'LineWidth', 2)
    q = q+1;
end

axis equal;