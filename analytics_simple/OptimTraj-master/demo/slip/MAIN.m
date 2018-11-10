% MAIN - Point Mass
%
% Finds the optimal trajectory to slide a point-mass across a 1d
% frictionless plane, using a variety of cost functions.
%
% This script optimizes the trajectory using a "smoothed" version of the
% abs() in the objective function. 
%
% The Integral{abs(power)} cost function is difficult to optimize for two
% reasons:
%   1) The objective function is non-smooth. This is addressed here by
%   directly smoothing the objective. The alternative method is to
%   introduce slack variables, as illustrated in MAIN_cstWork.
%
%   2) The second problem is that the solution itself is non-smooth. This
%   means that the piece-wise polynomial representation will fail to
%   accurately represent the solution, making the optimization difficult.
%   One solution to this problem is to add additional smoothing terms to
%   the cost function. Integral of of the input squared is good, as is the
%   integral of the input rate squared.
%
%

clc; clear;
addpath ../../

load('noAnkleNoDamp')
%Make parameters
p = opt.collParam;
for i = 1:numel(opt.collParam.modelParamList)
    p.(opt.collParam.modelParamList{i}) = opt.param(i);
end

%Turn dv list into blocks
Xguess = dvSymList2Block(opt.X,opt.collParam,0);

% User-defined dynamics and objective functions
problem.func.dynamics = @(t,x,u)( stanceDyn(t,x,u,p) );
problem.func.pathObj = @(t,x,u)( obj(t,x,u,p) );
problem.func.pathCst = @(t,x,u)( pathCon(t,x,u,p) );
problem.func.bndCst = @(t0,x0,tf,xf,u)( boundaryCon(t0,x0,tf,xf,p) );

% State
% x = [x; y; r0; dx; dy; dr0];
% u = [ddr0; Tankle];

% Problem bounds
problem.bounds.initialTime.low = 0;
problem.bounds.initialTime.upp = 0;
problem.bounds.finalTime.low = 3.0;
problem.bounds.finalTime.upp = 3.0;

problem.bounds.state.low = [-inf;-inf;opt.collParam.r0min;-inf;-inf;-inf];
problem.bounds.state.upp = [inf;inf;opt.collParam.r0max;inf;inf;inf];
problem.bounds.initialState.low = -inf*[1;1;1;1;1;1];
problem.bounds.initialState.upp = inf*[1;1;1;1;1;1];
problem.bounds.finalState.low = zeros([6,1]) - inf; 
problem.bounds.finalState.upp = zeros([6,1]) + inf;

problem.bounds.control.low = [p.ddr0Min; 0]; %-p.anklemax
problem.bounds.control.upp = [p.ddr0Max; 0]; %p.anklemax

% Guess at the initial trajectory
problem.guess.time = linspace(0,opt.Tstance,p.N);
problem.guess.state = Xguess(1:6,:);
problem.guess.control = Xguess(7:8,:);

% Options for fmincon
problem.options.nlpOpt = optimset(...
    'Display','iter',...
    'GradObj','off',...
    'GradConstr','off',...
    'MaxFunEval',200000,...
    'DerivativeCheck','off');   %Fmincon automatic gradient check

problem.options.method = 'trapezoid';
problem.options.trapezoid.nGrid = 30;
problem.options.defaultAccuracy = 'medium';

% Solve the problem
soln = optimTraj(problem);
t = soln.grid.time;
y = soln.grid.state(2,:);
r0 = soln.grid.state(3,:);
ddr0 = soln.grid.control(1,:);
r = sqrt(soln.grid.state(1,:).^2 +y.^2);

% Plot the solution:
figure; clf;

subplot(4,1,1)
plot(t,y)
ylabel('pos')
title('SLIP Height');

subplot(4,1,2)
plot(t,r0)
ylabel('Spring Position')

subplot(4,1,3)
plot(t,ddr0)
ylabel('Spring Acceleration')

subplot(4,1,4)
plot(t,r)
ylabel('r')

