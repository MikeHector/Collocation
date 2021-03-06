% MHector
% 7/25/18
% Master script to run a bunch of collocations from

%Let's run over several variable values using previous variable value
%solution as a seed for the next optimization
clear; clc;

BigCount =0;
while 1<2


    for q = 1
        if q == 1
            varName = 'c';
            varInd = 2;
            dirComp = getSaveDir('DRL-PC'); %Change if you're running on a different computer
            dirname = strcat(dirComp, '\opt_', varName, '*');
            strucc = dir(dirname);
%         elseif q == 2
%             varName = 'apex_velocity';
%             varInd = 13;
%             dirComp = getSaveDir('DRL-PC'); %Change if you're running on a different computer
%             dirname = strcat(dirComp, '\opt_', varName, '*');
%             strucc = dir(dirname);
        end

        newSave = 0;
        for i = 1:numel(strucc)
            filename = strcat(dirComp,'\',strucc(i).name);
            load(filename)
            if opt.param(varInd) < 100 && opt.param(varInd) > -1
                opt_seed = opt.X;
                param = opt.param;  
                collParam = opt.collParam;
                seeParam = opt.seeParam;

                iterationCounter = 0;
                lowest_cost = opt.cost;
                goodCounter = 0;

                %Perturb it a little
                opt_seed = awgn(opt_seed,50);
                while iterationCounter < 4
                    disp(['Iteration - ' num2str(iterationCounter)])
                    disp(['Variable value - ' num2str(opt.param(varInd))])
                    opt.param(varInd)
                    [~, opt] = RUN_COL(opt_seed, param, collParam, seeParam);
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
                        newSave = newSave+1;
                        %Perturb it a little
                        opt_seed = awgn(opt.X,50);
                    else
                        %Load best seed and
                        %Perturb it a little more
                        load(filename)
                        opt_seed = awgn(opt.X,50);
                    end

                    %Increment counter
                    iterationCounter = iterationCounter + 1;

                end
            else
                i = i + 1;
            end
        end
    end
    BigCount = BigCount+1;
end