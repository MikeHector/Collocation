% MHector
% 4.26.18
% Collocation of slip through stance; v2 includes stance duration as a
% decision variable
function [] = checkGradients(seed, modelParam, collParam ) %TD_angle should be nan unless it is dictated
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
    load('Aeq_array','Aeq') %Aeq
    load('beq_array','beq') %beq
    A = []; b = [];

    %Set bounds
    ub = zeros(size(seed)) + inf;
    lb = zeros(size(seed)) - inf;

    
    %Optimizer parameters
    collParam.options = optimoptions('fmincon','Display','iter','MaxFunctionEvaluations',1,...
                    'MaxIterations',1, 'ConstraintTolerance', 1e-3,...
                    'UseParallel', true, 'OptimalityTolerance',1e-3, ...
                    'SpecifyObjectiveGradient',true,'SpecifyConstraintGradient',true,...
                    'CheckGradients', true,'FiniteDifferenceType','central');

    %Optimize!
    [optimized, ~, collParam.flag, collParam.fmincon_stuff] = fmincon(cost_func,seed,A,b,Aeq,beq,lb,ub,nonlcon,collParam.options);

end