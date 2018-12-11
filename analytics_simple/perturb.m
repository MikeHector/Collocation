% MHector
% 7/25/18
% Master script to run a bunch of collocations from

%Let's run over several variable values using previous variable value
%solution as a seed for the next optimization
clear; clc;

dirComp = getSaveDir('DRL-PC'); %Change if you're running on a different computer

% dirComp = 'C:\Users\mike-\Google Drive\Collocation\damping_highLegE_lowAnkleE';
varNames = {'apex_height'};
numOfSaves = 0;
passes = 0;
while 1<2
    for i = 1:length(varNames)
        dirname = strcat(dirComp, '\opt_', varNames{i}, '_sim*');
        strucc = dir(dirname);

        %High - low sweep
        downList = fliplr(1:numel(strucc));
        %Load last file
        filename = strucc(downList(end)).name;
        filename = strcat(dirComp, '\', filename);
        load(filename); prevSeed = opt.X;
        for ii = 2:numel(downList)
            %load next file
            filename = strucc(downList(ii)).name;
            filename = strcat(dirComp, '\', filename);
            load(filename)
            cost = opt.cost;
            %colocate
            [~, opt] = RUN_COL(prevSeed, opt.param, opt.collParam, opt.seeParam);
            
            if opt.cost < cost
%                 save(filename,'opt');
                numOfSaves = numOfSaves+1;
            end
        end
        
        %Low - High sweep
        upList = 1:numel(strucc);
        filename = strucc(1).name;
        filename = strcat(dirComp, '\', filename);
        load(filename); prevSeed = opt.X;
        for ii = 2:numel(upList)
            %load next file
            filename = strucc(upList(ii)).name;
            filename = strcat(dirComp, '\', filename);
            load(filename)
            cost = opt.cost;
            %colocate
            [~, opt] = RUN_COL(prevSeed, opt.param, opt.collParam, opt.seeParam);
            
            if opt.cost < cost
%                 save(filename,'opt');
                numOfSaves = numOfSaves+1;
            end
        end
    end
    passes = passes+1;    
end
