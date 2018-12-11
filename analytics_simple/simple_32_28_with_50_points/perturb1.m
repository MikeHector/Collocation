% MHector
% 7/25/18
% Master script to run a bunch of collocations from

%Let's run over several variable values using previous variable value
%solution as a seed for the next optimization
clear; clc;

dirComp = getSaveDir('DRL-PC'); %Change if you're running on a different computer

% dirComp = 'C:\Users\mike-\Google Drive\Collocation\damping_highLegE_lowAnkleE';
varNames = {'apex_height'};
varInd = 12;
ankleNoAnkle = {'_simpleAn*','simpleNoAn*'};
for ana = 1:2
numOfSaves = 0;
passes = 0;
previousPassSaves = 0; 
shwifty = 1;
tic
while previousPassSaves > 0 || shwifty
    shwifty = 0;
    for i = 1:length(varNames)
        dirname = strcat(dirComp, '\opt_', varNames{i}, ankleNoAnkle{ana});
        strucc = dir(dirname);
        
        %Order filenames
        for j = 1:numel(strucc)
            filenameList{j} = strucc(j).name;
            filename = strucc(j).name;
            filename = strcat(dirComp, '\', filename);
            load(filename);
            param(j) = opt.param(varInd(i));
        end
        
        [p, sortInd] = sort(param);
        highLowList = filenameList(sortInd);
        
        %High - low filename list
        lowHighList = fliplr(filenameList);

        %High - Low sweep
        %Load first filename
        filename = lowHighList{1};
        filename = strcat(dirComp, '\', filename);
        load(filename); prevSeed = opt.X;
        for ii = 2:numel(lowHighList)
            %load next file
            filename = lowHighList{ii};
            filename = strcat(dirComp, '\', filename);
            load(filename)
            cost = opt.cost;
            %colocate
            [~, opt] = RUN_COL(prevSeed, opt.param, opt.collParam, opt.seeParam);
            
            if opt.cost < cost
                save(filename,'opt');
                numOfSaves = numOfSaves+1;
            end
        end
        
        %Low - High sweep
        filename = highLowList{1};
        filename = strcat(dirComp, '\', filename);
        load(filename); prevSeed = opt.X;
        for ii = 2:numel(highLowList)
            %load next file
            filename = highLowList{ii};
            filename = strcat(dirComp, '\', filename);
            load(filename)
            cost = opt.cost;
            %colocate
            [~, opt] = RUN_COL(prevSeed, opt.param, opt.collParam, opt.seeParam);
            
            if opt.cost < cost
                save(filename,'opt');
                numOfSaves = numOfSaves+1;
            end
        end
    end
    passes = passes+1;    
    previousPassSaves = numOfSaves - previousPassSaves;
end
end
toc
