% MHector
% 12.20.18
% Collocation of slip through stance
function [opt_res] = runOpt(opt)
    seed = opt.X; modelParam = opt.param; collParam = opt.collParam; seeParam = opt.seeParam;

    %Cost function
    cost_func = @(x) SymObjFuncFancy(x, modelParam);

    %Set up nonlinear constraint (which we'll be calling a lot)
    nonlcon = @(x) SymConFuncFancy(x, modelParam);
    

    %Set bounds
    cp = collParam.N; %Number of collocation points
    ub = zeros(size(seed)) + inf;
%     x = ub(1:1*cp); %x
%     y = ub(1+1*cp:2*cp); %y
    ub(1+2*cp:3*cp) = inf; %r0 inf for now
%     dx = ub(1+3*cp:4*cp); %dx
%     dy = ub(1+4*cp:5*cp); %dy
%     dr0 = ub(1+5*cp:6*cp); %dr0
    ub(1+6*cp:7*cp) = collParam.ddr0Max; %ddr0
    ub(1+7*cp:8*cp) = collParam.anklemax; %Tankle
    ub(8*cp+1) = collParam.tstancemax; %Tstance
    
    lb = zeros(size(seed)) - inf;
%     x = ub(1:1*cp); %x
%     y = ub(1+1*cp:2*cp); %y
%     lb(1+2*cp:3*cp) = -inf; %r0 -inf for now
%     dx = ub(1+3*cp:4*cp); %dx
%     dy = ub(1+4*cp:5*cp); %dy
%     dr0 = ub(1+5*cp:6*cp); %dr0
    lb(1+6*cp:7*cp) = collParam.ddr0Min; %ddr0
    lb(1+7*cp:8*cp) = -collParam.anklemax; %Tankle
    lb(8*cp+1) = collParam.tstancemin; %Tstance
    
    if collParam.ankles_on == 0 %Turn off ankle torques
        ub(1+7*cp:8*cp) = 0; lb(1+7*cp:8*cp) = 0;
    end

    
    %Optimizer parameters
    collParam.options = optimoptions('fmincon','Display','None','MaxFunctionEvaluations',20000,...
                    'MaxIterations',15000, 'ConstraintTolerance', 1e-8,...
                    'UseParallel', true, 'OptimalityTolerance',1e-8, ...
                    'SpecifyObjectiveGradient',true,'SpecifyConstraintGradient',true,...
                    'Algorithm','sqp');%,...
                    %'HessianFcn',hessian);%,'CheckGradients', true);

    %Optimize!
    [optimized, ~, collParam.flag, collParam.fmincon_stuff] = fmincon(cost_func,seed,[],[],[],[],lb,ub,nonlcon,collParam.options);

    opt_res.x = optimized(1:1*cp);
    opt_res.y = optimized(1+1*cp:2*cp);
    opt_res.r0 = optimized(1+2*cp:3*cp);
    opt_res.dx = optimized(1+3*cp:4*cp);
    opt_res.dy = optimized(1+4*cp:5*cp);
    opt_res.dr0 = optimized(1+5*cp:6*cp);
    opt_res.ddr0 = optimized(1+6*cp:7*cp);
    opt_res.Tankle = optimized(1+7*cp:8*cp);
    opt_res.Tstance = optimized(8*cp+1);
    
    
    opt_res.t = linspace(0, opt_res.Tstance, collParam.N); 
    opt_res.param = modelParam;
    opt_res.collParam = collParam;
    opt_res.r = sqrt(opt_res.x.^2+opt_res.y.^2);
    opt_res.cost = cost_func(optimized);
    opt_res.X = optimized; 
    opt_res.seeParam = seeParam;
    opt_res.dr = (opt_res.x .* opt_res.dx + opt_res.y .* opt_res.dy) ./ opt_res.r;
    opt_res.Fleg = opt_res.param(3) * (opt_res.r0 - opt_res.r) +...
                   opt_res.param(2) * (opt_res.dr0 - opt_res.dr);
    opt_res.xcop = (opt_res.Tankle * opt_res.param(9))...
            .* opt_res.r ./(opt_res.Fleg.* opt_res.y);
    opt_res.Fankle = opt_res.param(9) * opt_res.Tankle .*...
        (opt_res.x .* opt_res.dy - opt_res.y .* opt_res.dx) ./ opt_res.r.^2;
end