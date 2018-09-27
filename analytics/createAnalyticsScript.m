%Let's try to make this analytic
clear; close all; clc;
tic

%Setup
makefile = 1; makehessian = 0; optimize = 1;
assert(optimize == 0 || optimize == 1, 'optimize needs to be 0 or 1')

if makefile == 1
    %Make folder that new dynamics are going into
    dirname = 'NewOptimizationStructureApexApex';
    mkdir(dirname);
    addpath(dirname);
end

if makehessian ==1
    disp('This is gonna take a looooong time')
%     ['N, time'...
%      '35, 11 hours']; %Mostly hessians, also they took forever to
%      evaluate
    pause
end
%Set up collocation parameters - these are fixed for every compile
p.N = 70;
p.Nstance = 50;
p.Nflight = 20;
p.dof = 3;
p.cntrl_dof = 2;
smooth = 3;

assert(p.N == p.Nstance+p.Nflight,'stance and flight must add to N')

% Setup
disp('Making symbols')
[dv, vStruc, vList, Example] = makeParamSym(p);
disp('Done')

%Turn it into dv block and p structure
dvBlock = dvSymList2Block(dv,vStruc);

% Objective function
%Get symbolic: objective func - gradient - hessian
disp('Calculating objective function')
obj_func = OBJ_F(dvBlock, vStruc, smooth);
disp('Taking gradient')
grad_obj = jacobian(obj_func, dv).';
disp('Done')
if makehessian == 1
    disp('Calculating objective Hessian')
    hess_obj = cell(1,size(grad_obj,2));
    for i = 1:size(grad_obj,2)
        hess_obj{i} = jacobian(grad_obj(:,i),dv);
    end
    disp('Done')
end

if makefile == 1
    %Objective function file
    currdir = [pwd filesep];
    filename = [currdir,dirname,'\' 'SymObjFunc.m'];
    disp('Making objective + grad file')
    if optimize == 1
    matlabFunction(obj_func,grad_obj,'file',filename,'vars',{dv, vList});
    elseif optimize == 0
    matlabFunction(obj_func,grad_obj,'file',filename,'vars',{dv, vList}, 'Optimize', false);
    end
    disp('Done')
    
    if makehessian == 1
        %Objective Hessian
        filename = [currdir, 'zhessenergy.m'];
        disp('Making objective hessian file')
        matlabFunction(hess_obj{size(grad_obj,2)},'file',filename,'vars',{dv, vList}, 'Optimize', false);
        disp('Done')
    end
end

%Check objective function
oldObj = OBJ_F(Example.dvNum, Example.vNum, smooth);
newObj = SymObjFunc(Example.dvSym, Example.vSymList);

disp(['Error in analytical objective function is ',...
    num2str(oldObj-newObj)]);
assert(oldObj-newObj < 1e-10, 'Error in analytical objective func is too high');

% Constraints
%Linear equality constraints - state at beginning is same as end translated
%in x!
rowLen = p.dof*2 + p.cntrl_dof;
Aeq = zeros(rowLen, size(dv,1));
for i = 2:rowLen
    Aeq(i,1+(p.N-1)*(i-1)) = 1; %state(1) = 1
    Aeq(i,(p.N-1)*(i)) = -1; %state(end) = -1
end
Aeq = Aeq(2:end,:);
beq = zeros(rowLen-1,1);
%Save linear equality constraints
save([currdir,dirname,'\', 'Aeq_array'],'Aeq');
save([currdir,dirname,'\', 'beq_array'],'beq');

%Linear inequality constraints
%Min distance
A = zeros(1,length(dv));
A(1) = 1; A(p.N-1) = -1;
% b = 1; %Change me later
save([currdir,dirname,'\','A_array'],'A');

%Non-linear constraints
%Get symbolic constraints
disp('Fetching symbolic constraints')
[c_ineq, c_eq] = CONST(dvBlock,vStruc);
disp('Done')

% [c_ineq_from_old, c_eq_from_old] = nonlinear_constraint_func2(dv_num_block, symparamEX);

%Make symbolic files (Just to check!)
if makefile == 1
    filename = 'c_ineq_func';
    disp('Making c_ineq file')
    matlabFunction(c_ineq,'file',filename,'vars',{dv, vList},...
        'outputs',{'c_ineq'}, 'Optimize', false);
    disp('Done')
end

if makefile == 1
    filename = 'c_eq_func';
    disp('Making c_eq file')
    matlabFunction(c_eq,'file',filename,'vars',{dv, vList},...
        'outputs',{'c_eq'},'Optimize', false);
    disp('Done')
end

%Check Constraint function
[oldc, oldceq] = CONST(Example.dvNum, Example.vNum);
newcineq = c_ineq_func(Example.dvSym, Example.vSymList);
newceq = c_eq_func(Example.dvSym, Example.vSymList);

disp(['Error in analytical eq constraint function is ',...
    num2str(max(max(abs(oldc-newcineq))))]);

disp(['Error in analytical ineq constraint function is ',...
    num2str(max(max(abs(oldceq-newceq))))]);

sumOfError = max(max(abs(oldc-newcineq))) + max(max(abs(oldceq-newceq)));
assert(sumOfError < 1e-10, 'Error in analytical constraints is too high');

%Get gradients
disp('Generating constraint gradients')
grad_c_eq = jacobian(c_eq, dv).';
grad_c_ineq = jacobian(c_ineq,dv).';
disp('Done')

%Make constraint function file
disp('Making constraint file - this will take a bit')
if makefile == 1
    filename = [currdir,dirname,'\' 'SymConFunc.m'];
    if optimize == 1
    matlabFunction(c_ineq,c_eq,grad_c_ineq,grad_c_eq,'file',filename,'vars',{dv, vList},...
        'outputs',{'c_ineq','c_eq','grad_c_ineq','grad_c_eq'},'Optimize', false);
    elseif optimize == 0
    matlabFunction(c_ineq,c_eq,grad_c_ineq,grad_c_eq,'file',filename,'vars',{dv, vList},...
        'outputs',{'c_ineq','c_eq','grad_c_ineq','grad_c_eq'},'Optimize', false);
    end
end
disp('Done')

%Constraint Hessians
if makehessian == 1
    i_c_eq = size(grad_c_eq,2);
    hess_c_eq = cell(1,i_c_eq);
    for i = 1:i_c_eq
        hess_c_eq{i} = jacobian(grad_c_eq(:,i),dv);
        disp('Equality constraint Hessian generating...')
        disp(['Progress: ', num2str(i/i_c_eq*100), ' %'])
    end

    i_c_ineq = size(grad_c_ineq,2);
    hess_c_ineq = cell(1,i_c_ineq);
    for i = 1:i_c_ineq
        hess_c_ineq{i} = jacobian(grad_c_ineq(:,i),dv);
        disp('Inequality constraint Hessian generating...')
        disp(['Progress: ', num2str(i/i_c_ineq*100), ' %'])
    end

    %Build equality constraint Hessian
    disp('Equality constraint Hessian file generating...')
    for i = 1:i_c_eq
        ii = num2str(i);
        thename = ['zhessceq',ii];
        filename = [currdir,dirname,'\', thename '.m'];
        matlabFunction(hess_c_eq{i}, 'file',filename,'vars',{dv, vList},'Optimize', false);
        disp(['Progress: ', num2str(i/i_c_eq*100), ' %'])
    end

    %Build inequality constraint Hessian
    disp('Inequality constraint Hessian file generating...')
    for i = 1:i_c_ineq
        ii = num2str(i);
        thename = ['zhesscineq',ii];
        filename =  [currdir,dirname,'\', thename '.m'];
        matlabFunction(hess_c_ineq{i}, 'file',filename,'vars',{dv, vList},'Optimize', false);
        disp(['Progress: ', num2str(i/i_c_ineq*100), ' %'])
    end
    
    %Compile Hessians together
    filename = 'hessfinal.m';
    makeHessianFinal(i_c_eq, i_c_ineq, filename);
end

load('saveStruc')
opt.collParam.N = p.N;
opt.collParam.Nstance = p.Nstance;
opt.collParam.Nflight = p.Nflight;
opt.collParam.dof = p.dof;
opt.collParam.cntrl_dof = p.cntrl_dof;
opt.X = rand(size(dv));
filename = [currdir,dirname,'\', 'newSaveStruc'];
save(filename,'opt');

time2gen = toc;
disp(['It took ' num2str(time2gen/3600), ' hours to generate analytics'])

%Put RUN_COL and MAIN_COL in target dir
copyfile('RUN_COL.m',dirname)
copyfile('MAIN_COL.m',dirname)
copyfile('FIND_SEED.m',dirname)

%check gradients
try
    checkGradients(opt.X, opt.param, opt.collParam )
catch
    disp('If any gradient difference is larger than 1e-3, inspect')
    disp('Small differences are expected as analytics are different than finite diff')
    rmpath(dirname)
end
disp('If any gradient difference is larger than 1e-3, inspect')
disp('Small differences are expected as analytics are different than finite diff')
rmpath(dirname)