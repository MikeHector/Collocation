% MHector
% 7/25/18
% Master script to run a bunch of collocations from

%Let's run over several variable values using previous variable value
%solution as a seed for the next optimization
clear; clc;

filename = 'goodSeed2';
load('goodSeed2')
opt_seed = opt.X;
param = opt.param;  
collParam = opt.collParam;

iterationCounter = 0;
lowest_cost = 10e6;
goodCounter = 0;

while iterationCounter < 20000
    [~, opt] = RUN_COL(opt_seed, param, collParam);
    opt_seed = opt.X;
    param = opt.param;  
    collParam = opt.collParam;
    if opt.collParam.flag > 0
        goodCounter = goodCounter + 1
    end
    if opt.cost < lowest_cost && opt.collParam.flag > 0
        lowest_cost = opt.cost;
        %Save the coll
        save(filename,'opt');
        %Perturb it a little
        opt_seed = opt.X + .25*rand(size(opt.X));
    else
        %Load best seed and
        %Perturb it a little more
        load(filename)
        opt_seed = opt.X + .25*rand(size(opt.X));
    end

    %Increment counter
    iterationCounter = iterationCounter + 1;

end