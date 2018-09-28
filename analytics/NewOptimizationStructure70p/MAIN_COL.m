% MHector
% 9/4/18
% Master script to run a bunch of collocations from

%Let's run over several variable values using previous variable value
%solution as a seed for the next optimization
clear; clc;
%Add aux_prog folder
currdir = pwd;
aux_prog_dir = [currdir(1:47), '\aux_progs'];
addpath(aux_prog_dir);

colStrucArray = ColStrucBuilder();
% colStrucArray = ColStrucBuilderTest();
fieldNames = fieldnames(colStrucArray);

saveDir = getSaveDir('DRL-PC');

for m = [2]
    colStruc = colStrucArray.(fieldNames{m});

    for k = 1:numel(colStruc.direction)
        direction = colStruc.direction{k};

        %Load baseline seed and parameters
        load('seedC')
%         load('C:\Users\mike-\Documents\DRL\slip_opt\opt_results\opt_disturbance_f_180820182234015610.mat')
%         load( 'C:\Users\mike-\Documents\DRL\collocation\opt_results\opt_R_leg_150820181810270730.mat')
        opt_seed = opt.X;
        param = opt.param;
        param(colStruc.varInd) = colStruc.var;
        collParam = opt.collParam;
        seeParam = opt.seeParam;
        clear opt

        NumPerturb = 5;
        badCounterGlobe = 0;
        tryCounter = 1;
        while badCounterGlobe < 7 && param(colStruc.varInd) <= colStruc.varMax && param(colStruc.varInd) >= colStruc.varMin
            opt.collParam.flag = 0;
            while tryCounter <= NumPerturb && opt.collParam.flag <= 0
                [DV_out, opt] = RUN_COL(opt_seed, param, collParam, seeParam); %softmax
                
                %Perturb if it hasn't converged
                if opt.collParam.flag <= 0 && tryCounter < NumPerturb
                    for i = 1:size(opt.X,1)
                         opt_seed(i,:) = opt.X(i,:) +...
                         .5 * std(opt.X(i,:)) * rand(size(opt_seed(2,:)));
                    end
                end
                tryCounter = tryCounter + 1;
            end
            tryCounter = 0;

            %Save the coll
            uniqueID = string(datetime, 'dMMyHHmmssSSSS');
            filename = strcat('opt_', colStruc.varName, '_', uniqueID);
            save(strcat(saveDir,'\',filename),'opt');

            %Save optimized decision variables as new seed
            opt_seed = DV_out; 

            %Track infeasible counter
            if (opt.collParam.flag <= 0)
                badCounterGlobe = badCounterGlobe + 1;
            elseif opt.collParam.flag > 0
                badCounterGlobe = 0; %Reset counter if not infeasible/ bad
            end

            %Increment collocation variable
            param = opt.param;
            if strcmp(direction,'up')
                param(colStruc.varInd) = opt.param(colStruc.varInd) + colStruc.deltaVar;
            elseif strcmp(direction, 'down')
                param(colStruc.varInd) = opt.param(colStruc.varInd) - colStruc.deltaVar;
            end
            disp([colStruc.varName , ' has been incremented to ',num2str(param(colStruc.varInd))]);
            %Clean
            clear DV_out opt
        end
    end
end