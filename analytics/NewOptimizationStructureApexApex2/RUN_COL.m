% MHector
% 4.26.18
% Collocation of slip through stance; v2 includes stance duration as a
% decision variable
function [optimized, opt_res] = RUN_COL(seed, modelParam, collParam, seeParam) %TD_angle should be nan unless it is dictated
%     assert(length(seed) == param.N-1,'Seed was not the expected dimension')
%     assert(param.Nstance+param.Nflight == param.N, 'Collocation points of stance and flight do not add up to param.N!')

%     %Cost function
    cost_func = @(x) SymObjFunc(x, modelParam);
% 
%     %Set up nonlinear constraint (which we'll be calling a lot)
    nonlcon = @(x) SymConFunc(x, modelParam);
    
    %Set up hessian
%     hessian = @(x,lambda) hessfinal(x, lambda, modelParam);

    %Set other constraints
%     load('Aeq_array','Aeq') %Aeq %None for apex2apex
%     load('beq_array','beq') %beq
    Aeq = []; beq = [];
    load('A_array','A'); %A
    b = -modelParam(cellfun(@(x)isequal(x,'xDist'),collParam.modelParamList));

    %Set bounds
    cp = collParam.N -1; %Number of collocation points
    ub = zeros(size(seed)) + inf;
%     x = ub(1:1*cp); %x
%     y = ub(1+1*cp:2*cp); %y
    ub(1+2*cp:3*cp) = collParam.r0max; %r0
    
%     dx = ub(1+3*cp:4*cp); %dx
%     dy = ub(1+4*cp:5*cp); %dy
%     dr0 = ub(1+5*cp:6*cp); %dr0
    ub(1+6*cp:7*cp) = collParam.legmax; %Tleg
    ub(1+7*cp:8*cp) = collParam.anklemax; %Tankle
    ub(1+7*cp+collParam.Nstance:8*cp) = 0; %Tankle flight
    ub(8*cp+1:8*cp+collParam.Nflight) = collParam.thetamax; %theta
    ub(8*cp+collParam.Nflight +3) = collParam.apexheightmax; %apex_height
    ub(8*cp+collParam.Nflight +1) = collParam.tstancemax; %Tstance
    ub(8*cp+collParam.Nflight +2) = collParam.tflightmax; %Tflight
    
    lb = zeros(size(seed)) - inf;
%     x = ub(1:1*cp); %x
%     y = ub(1+1*cp:2*cp); %y
    lb(1+2*cp:3*cp) = collParam.r0min; %r0
%     dx = ub(1+3*cp:4*cp); %dx
%     dy = ub(1+4*cp:5*cp); %dy
%     dr0 = ub(1+5*cp:6*cp); %dr0
    lb(1+6*cp:7*cp) = -collParam.legmax; %Tleg
    lb(1+7*cp:8*cp) = -collParam.anklemax; %Tankle
    lb(1+7*cp+collParam.Nstance:8*cp) = 0; %Tankle flight
    lb(8*cp+1:8*cp+collParam.Nflight) = collParam.thetamin; %theta
    lb(8*cp+collParam.Nflight +3) = collParam.apexheightmin; %apex_height
    lb(8*cp+collParam.Nflight +1) = collParam.tstancemin; %Tstance
    lb(8*cp+collParam.Nflight +2) = collParam.tflightmin; %Tflight
    
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
                    'MaxIterations',15000, 'ConstraintTolerance', 1e-4,...
                    'UseParallel', true, 'OptimalityTolerance',1e-1, ...
                    'SpecifyObjectiveGradient',true,'SpecifyConstraintGradient',true)%,...
                    %'Algorithm','sqp');%,...
                    %'HessianFcn',hessian);%,'CheckGradients', true);

    %Optimize!
    [optimized, ~, collParam.flag, collParam.fmincon_stuff] = fmincon(cost_func,seed,A,b,Aeq,beq,lb,ub,nonlcon,collParam.options);

    opt_res.x = optimized(1:1*cp);
    opt_res.y = optimized(1+1*cp:2*cp);
    opt_res.r0 = optimized(1+2*cp:3*cp);
    opt_res.dx = optimized(1+3*cp:4*cp);
    opt_res.dy = optimized(1+4*cp:5*cp);
    opt_res.dr0 = optimized(1+5*cp:6*cp);
    opt_res.Tleg = optimized(1+6*cp:7*cp);
    opt_res.Tankle = optimized(1+7*cp:8*cp);
    opt_res.theta = optimized(8*cp+1:8*cp+collParam.Nflight);
    opt_res.apex_height = optimized(8*cp+collParam.Nflight +3);
    opt_res.Tstance = optimized(8*cp+collParam.Nflight +1);
    opt_res.Tflight = optimized(8*cp+collParam.Nflight +2);
    
    opt_res.tstance = linspace(0, opt_res.Tstance, collParam.Nstance); 
    opt_res.tflight =...
    linspace(opt_res.Tstance, opt_res.Tstance+opt_res.Tflight, collParam.Nflight);
    opt_res.t = [opt_res.tstance, opt_res.tflight(2:end)];
    
    opt_res.param = modelParam;
    opt_res.collParam = collParam;
    opt_res.r = sqrt(opt_res.x.^2+opt_res.y.^2);
    opt_res.cost = cost_func(optimized);
    opt_res.X = optimized; 
    opt_res.seeParam = seeParam;
    
end