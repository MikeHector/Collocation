% MHector
% 4.26.18
% Collocation of slip through stance; v2 includes stance duration as a
% decision variable
function [optimized, opt_res] = RUN_COL(seed, modelParam, collParam, seeParam) %TD_angle should be nan unless it is dictated
%     assert(length(seed) == param.N-1,'Seed was not the expected dimension')
%     assert(param.Nstance+param.Nflight == param.N, 'Collocation points of stance and flight do not add up to param.N!')

%     %Cost function
    cost_func = @(x) SymObjFuncFancy(x, modelParam);
% 
%     %Set up nonlinear constraint (which we'll be calling a lot)
    nonlcon = @(x) SymConFuncFancy(x, modelParam);
    
    %Set up hessian
%     hessian = @(x,lambda) hessfinal(x, lambda, modelParam);

    %Set other constraints
%     load('Aeq_array','Aeq') %Aeq
%     load('beq_array','beq') %beq
%     load('A_array','A'); %A
%     b = -modelParam(end);

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
    
%     assert( any(seed(1+2*cp:3*cp) < collParam.r0max) && any(seed(1+2*cp:3*cp) > collParam.r0min), 'error in r0min')
%     assert( any(seed(1+6*cp:7*cp) < collParam.legmax) && any(seed(1+6*cp:7*cp) > -collParam.legmax), 'error in legT')
%     assert( any(seed(1+7*cp:8*cp) < collParam.anklemax) && any(seed(1+6*cp:7*cp) > -collParam.anklemax), 'error in ankleT')
%     assert( any(seed(1+7*cp+collParam.Nstance:8*cp) < 0.01) && any(seed(1+7*cp+collParam.Nstance:8*cp) > -0.01),'ankleT flight error')
%     assert( any(seed(8*cp+collParam.Nflight +3) < collParam.thetamax) && any(seed(8*cp+collParam.Nflight +3) > -collParam.thetamax), 'error in theta')
%     assert( seed(8*cp+collParam.Nflight +3) < collParam.apexheightmax && seed(8*cp+collParam.Nflight +3) > collParam.apexheightmin, 'apex height error')
%     assert( seed(8*cp+collParam.Nflight +1) < collParam.tstancemax && seed(8*cp+collParam.Nflight +1) > collParam.tstancemin, 'time stance error')
%     assert( seed(8*cp+collParam.Nflight +2) < collParam.tflightmax && seed(8*cp+collParam.Nflight +2) > collParam.tflightmin, 'time flight error')

    if collParam.ankles_on == 0 %Turn off ankle torques
        ub(1+7*cp:8*cp) = 0; lb(1+7*cp:8*cp) = 0;
    end

    
    %Optimizer parameters
    collParam.options = optimoptions('fmincon','Display','iter','MaxFunctionEvaluations',20000,...
                    'MaxIterations',15000, 'ConstraintTolerance', 1e-6,...
                    'UseParallel', true, 'OptimalityTolerance',1e-6, ...
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