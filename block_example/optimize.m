clc; clear all; close all;
p.N = 100;
p.m = 1;
p.tEnd = 1;
p.dof = 1;
p.cntrlIn = 1;
% dv = zeros(2*p.dof+p.cntrlIn,p.N); %x, dx, Force

seedX = linspace(0,1,p.N);
seedDX = linspace(0,0,p.N);
seedF = linspace(1,1,p.N);
seed = [seedX; seedDX; seedF];

nonlincon = @(dv) const(dv, p);

objF = @(dv) objectiveFunction(dv);

ub = zeros(size(seed))+inf;
lb = -ub;

options = optimoptions('fmincon','Display','iter','MaxFunctionEvaluations',20000,...
                    'MaxIterations',15000, 'ConstraintTolerance', 1e-6,...
                    'UseParallel', true, 'OptimalityTolerance',1e-6, ...
                    'Algorithm','interior-point','StepTolerance',1e-9);
                
                
[opt] = fmincon(objF, seed, [], [], [], [],lb,ub,nonlincon,options);

x = opt(1,:);
dx = opt(2,:);
F = opt(3,:);
time = linspace(0,p.tEnd,p.N);

figure; subplot(3,1,1); plot(time,x); title('position');
subplot(3,1,2); plot(time,dx); title('velocity');
subplot(3,1,3); plot(time,F); title('force');

