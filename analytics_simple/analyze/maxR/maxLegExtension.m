clc; clear;

s = loadResults('rMax',0);

startInd = find(round(s.var_graph,3) == .6);
figure; subplot(3,1,1);
plot(s.var_graph(startInd:end),s.cost_graph(startInd:end))
xlabel('Maximum allowable leg extension'); ylabel('Cost of Transport');

subplot(3,1,2);
plot(s.var_graph(startInd:end),s.eLegMech(startInd:end));
xlabel('Maximum allowable leg extension'); ylabel('Energy input to complete gait');

subplot(3,1,3);
plot(s.var_graph(startInd:end),s.dist(startInd:end));
xlabel('Maximum allowable leg extension'); ylabel('Distance traveled');

%Percent changes

startInd = find(round(s.var_graph,3) == .605);
figure; subplot(2,1,1);
plot(s.var_graph(startInd:end),s.cost_graph(startInd:end))
xlabel('Maximum allowable leg extension'); ylabel('Cost of Transport');
title('Maximum Leg Extension and CoT')
subplot(2,1,2);
nLegMech = s.eLegMech(startInd:end)/s.eLegMech(startInd);
% pLegMech = s.eLegMech(startInd:end);
plot(s.var_graph(startInd:end),nLegMech);
hold on;
nDist = s.dist(startInd:end)/s.dist(startInd);
% pDist = s.dist(startInd:end);
plot(s.var_graph(startInd:end),nDist);
xlabel('Maximum allowable leg extension'); ylabel('Normalized CoT parameters');
legend('Input energy','Distance traveled')