classdef colls
    %colls Runs, saves, and perturbs optimization structures for SLIP
    %running
    %   Detailed explanation goes here
    
    properties
        noAnkle
        ankle
        saveDir
        grid   
        points
        utility
    end
    
    methods     
        
        function c = reSweep(c, collsList)
            %reSweep Smooths out saved colls by reseeding optimizations. 
            %Takes a list of var values {var1 var2} and for each one in
            %that list, finds a nearby coll, reseeds, and reruns the
            %optimization. The resulting optimization is saved if the cost
            %is lower than it was.
            
            for coll = 1:numel(collsList)
                
                
            end
            
        end
        
        function c = updateInterestingPartsList(c, varNum, range, courseness)
            %updateInterestingPartsList Updates the grid.list property
            %given a varNum (1 or 2 for var1 or var2), range of var to make
            %more course, and a desired courseness
            
            %Load saves
            c = c.loadSaves;
            
            %Load in list to be modified
            assert(varNum == 1 || varNum == 2, 'varNum must be 1 for var1 or 2 for var2');
            oldList = c.grid{varNum}.list;
            
            %Trucate old list by range
            assert(length(range) == 2, 'range must be length two: [low high]')
            lowInd = find(oldList <= range(1), 1, 'last' );
            highInd = find(oldList >= range(2), 1 );
            truncList = oldList(lowInd:highInd); %This is the old list truncated to desired range
            
            
            %Go through the truncList, figure out how many points need to be
            %put between points to reach desired courseness, add those
            %points
            tooCourse = 1;
            i = 1;
            while tooCourse %Not smooth enough
                if truncList(i+1) - truncList(i) > courseness
                    %Add some points
                    numPointsToAdd = floor((truncList(i+1) - truncList(i))/courseness);
                    pointsToAdd = linspace(truncList(i), truncList(i+1),2+numPointsToAdd);
                    truncList = [truncList(1:i),...
                        pointsToAdd(2:end-1),...
                        truncList(i+1:end)];
                    i = 0; %restart the sweep loop
                end
                i = i+1;
                if i == length(truncList)
                    tooCourse = 0;
                end
            end
            
            c.grid{varNum}.list = [oldList(1:(lowInd-1)), truncList, oldList((highInd+1):end)];
            
        end
        function c = refineGridCourseness(c)
            keepGoin = 1; %keep on trukin
            while keepGoin
                c.grid{1}.courseMax = c.grid{1}.courseMax * .7;
                c.grid{2}.courseMax = c.grid{2}.courseMax * .7;
                c = c.updateDesiredPointsFromGrid;
                c = c.updateSavedColls;
                if length(c.ankle.var1) > 2000
                    keepGoin = 0;
                end
            end
        end
                
        function c = refineMaxDiff(c)
            %refineMaxDiff Iterates through colls until difference between 
            % nearest coll is less than utility.maxDiff
            
            %Load saves
            c.utility.loadSavesNeeded = 1;
            c = c.loadSaves;
            
            %While we haven't gone through the whole list without change
            thingsChanged = 1;  %set this to get the loop started
            while thingsChanged
                thingsChanged = 0; %If we go through the whole loop and this is 0, it ends
                q = 1;
                [diff, nearTuple] = c.findDiff(c.points.saved.ankle{q});
                newLength = numel(c.points.desired);
                while q < newLength
                    %While we haven't gone through the whole list
                    %%%%%CHECK THIS
                    %%%%%LOOP!!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    if diff > c.utility.maxDiff
                        %Add a point between saved{q} and nearest
                        newTuple = [mean([c.points.saved.ankle{q}(1),nearTuple(1)]),...
                                    mean([c.points.saved.ankle{q}(2),nearTuple(2)])];       
                        assert(~c.tupleExists(newTuple,c.points.desired),'New tuple already Exists')
                        %Add to desired
                        c.points.desired{end+1} = newTuple;
                        %Update colls
                        c = c.updateSavedColls;
                        %Note that we changed something
                        thingsChanged = 1;
                        %Restart list
                        q = 1;
                        %Reset findDiff
                        [diff, nearTuple] = c.findDiff(c.points.saved.ankle{q});
                    else
                        q = q+1;
                        %Reset findDiff
                        [diff, nearTuple] = c.findDiff(c.points.saved.ankle{q});
                    end
                    newLength = numel(c.points.desired); %look at list len
                end
            end
            disp('Done')
        end
            
        function [diff, nearTuple] = findDiff(c,tuple)
                %findDiff Finds the difference in % decrease CoT between
                %tuple and nearest coll
                 
                %(If either tuple isn't found in both ankle and noAnkle,
                %shit breaks)
                [~, nearColl] = c.findNearestSeed(tuple(1),tuple(2),'ankle');
                nearCoT = c.getPercentDecreaseCoT(nearColl.param(c.grid{1}.varInd),nearColl.param(c.grid{2}.varInd));
                diff = abs(nearCoT - c.getPercentDecreaseCoT(tuple(1),tuple(2)));
                if nargout > 1
                    nearTuple = [nearColl.param(c.grid{1}.varInd),nearColl.param(c.grid{2}.varInd)];
                end
        end
        
        function c = sweepColls(c)
            %sweepColls Load in the grid, sweep up and down until nothing
            %changes
            
        end        
        
        function c = updateSavedColls(c)
            %updateGridColls Look at desired points property, identify missing 
            %colls, find a close seed, create those colls
            
            %Compare grid and colls to find discrepencies
            [c, d] = missingPoints(c);
            
            for p = 1:numel(d.ankle)
                for ana = {'ankle','noAnkle'}
                    %Go through d, findNearestSeed, runColl from that seed
                    
                    %Rename stuff for clarity
                    var1_temp = d.(ana{1}){p}(1);
                    var2_temp = d.(ana{1}){p}(2);

                    %Load nearby seed
                    seed = c.findNearestSeed(var1_temp,var2_temp,ana{1});
                    
                    %Change to desired var values
                    seed.param(c.grid{1}.varInd) = var1_temp;
                    seed.param(c.grid{2}.varInd) = var2_temp;

                    %Run collocation
                    c = c.collocation(seed);
                end %missing grid list
                disp([num2str(100*p/numel(d.ankle)), ' % Done'])
            end %ankle or noAnkle
            c.utility.loadSavesNeeded = 1;
            c = c.loadSaves;
            d = missingPoints(c); %Rerun to update colls struct
            assert((numel(d.ankle)+numel(d.noAnkle)) == 0,'There might be some vars that didnt work')

        end
        
        function [c, d] = missingPoints(c)
            %missingGridPoints Returns difference in saved points and
            %desired points
            %The difference returned is a struct of form d.ankle{i} = [var1 var2]
            
            %Check the saves - update points.saved
            c = c.loadSaves;
            %Make sure any changes to grid are found in desired points
            c = c.updateDesiredPointsFromGrid;

            %Look for differences between desired and saved in both ankle
            %and noAnkle structs, add it to d struct if it's in desired and
            %not in saved
            
            dTemp.ankle = []; dTemp.noAnkle = []; d.ankle = []; d.noAnkle = [];
            for ana = {'ankle', 'noAnkle'}
                for i = 1:numel(c.points.desired)
                    if ~c.tupleExists(c.points.desired{i},c.points.saved.(ana{1}))
                        dTemp.(ana{1}){end+1} = c.points.desired{i};
                    end
                end
                %Sort it by distance to nominal values for the case when
                %we're initializing the grid and only have nominal values.
                %This step doesn't really matter once we have a good grid
                
                %Go through list of ankle/noAnkle points and calculate
                %distances from nominal points
                dist = zeros(1,numel(dTemp.(ana{1}))); %initialize dist
                for i = 1:numel(dTemp.(ana{1}))
                    X = [c.grid{1}.nom c.grid{2}.nom; dTemp.(ana{1}){i}];
                    dist(i) = pdist(X,'euclidean'); 
                end
                [~, ind] = sort(dist); %sort and get the indicies of sort
                for i = 1:length(dist) %Go through distances and put the vars in order
                    d.(ana{1}){end+1} = dTemp.(ana{1}){ind(i)};
                end
            end   

            if (numel(dTemp.ankle) + numel(dTemp.noAnkle)) == 0
%                 disp('No missing grid points')
            end
        end
        
        function c = updateDesiredPointsFromGrid(c)
            %updatePoints Makes sure everything in grid is found in
            %points.desired
            
            c = c.updateGridList;
            %Build grid tuples
            gridTuple = []; %initialize
            for var1 = c.grid{1}.list
                for var2 = c.grid{2}.list
                    gridTuple{end+1} = [var1 var2];
                end
            end
            
            %Check that each grid tuple is in desired tuples if it's not,
            %then add it in
            for i = 1:numel(gridTuple)
                if ~c.tupleExists(gridTuple{i},c.points.desired)
                    c.points.desired{end+1} = gridTuple{i};
                end
            end
                    
        end
        
        function c = updateDesiredPointsFromSaved(c)
            %updateDesiredPointsFromSaved Makes sure everything in saved is found in
            %points.desired
            
            %Load saves
            c = c.loadSaves;
            
            %Choose the larger saved struct or grab one
            if numel(c.points.saved.ankle) >= numel(c.points.saved.noAnkle)
                saveTuple = c.points.saved.ankle;
            else
                saveTuple = c.points.saved.noAnkle;
            end
            
            %Check that each save tuple is in desired tuples if it's not,
            %then add it in
            for i = 1:numel(saveTuple)
                if ~c.tupleExists(saveTuple{i},c.points.desired)
                    c.points.desired{end+1} = saveTuple{i};
                end
            end          
        end
        
        function isIn = tupleExists(c,tuple,tupleCell)
            %tupleExists Takes a var tuple and a tupleCell cell array and checks
            %that tuple exists in tupleCell
            isIn = false; %initialize negative
            r = @(x) round(x,4);
            for i = 1:numel(tupleCell)
                if (r(tuple(1)) == r(tupleCell{i}(1))) && (r(tuple(2)) == r(tupleCell{i}(2)))
                    isIn = true;
                end
            end
        end
        
        function [seed, seedU] = findNearestSeed(c, var1, var2, ankleSwitch)
            %findNearestSeed Returns the seed struc that is closest to
            %input var1 and var2. ankleSwitch should be 'ankle' or
            %'noAnkle'
            
            %Check the saves
            c = c.loadSaves;
            
            %Go through list of saved points and calculate distances
            dist = zeros(1,numel(c.points.saved.(ankleSwitch)));
            for i = 1:numel(c.points.saved.(ankleSwitch))
                X = [var1 var2; c.points.saved.(ankleSwitch){i}];
                dist(i) = pdist(X,'euclidean');
            end
            
            %Find the smallest distance
            smol = c.points.saved.(ankleSwitch)(find(dist == min(dist), 1 ));
            
            %Return the closest opt struc
            seed = c.findColl(smol{1}(1), smol{1}(2), ankleSwitch);
            
            if nargout > 1
                %Find seed that is closest, but not the original
                distU = dist;
                distU(distU == min(distU)) = inf; %Set original min to inf

                %redo above
                %Find the smallest distance
                smolU = c.points.saved.(ankleSwitch)(find(distU == min(distU), 1 ));

                %Return the closest opt struc
                seedU = c.findColl(smolU{1}(1), smolU{1}(2), ankleSwitch);
            end
        end
        
        function c = updateGridList(c)
            %refineColls This method looks at properties grid: courseness, max/mins
            %makes changes to grid.list
            
            c = c.loadSaves; %load in the saves
            
            qRound = @(x) round(x,4); %Slightly easier to type
            
            for i = 1:2
                assert(c.grid{i}.max > c.grid{i}.min,'grid max must be greater than grid min')
            end
            
            %Step 1: Check min/max bounds
            %Mins
            if qRound(min(c.grid{1}.list)) > qRound(c.grid{1}.min)
                %Modify list
                listMod = linspace(c.grid{1}.min, min(c.grid{1}.list),ceil((min(c.grid{1}.list)-c.grid{1}.min)/c.grid{1}.courseMax)+1);
                c.grid{1}.list = [listMod(1:end-1), c.grid{1}.list];
            end
            if qRound(min(c.grid{2}.list)) > qRound(c.grid{2}.min)
                %Modify list
                listMod = linspace(c.grid{2}.min, min(c.grid{2}.list),ceil((min(c.grid{2}.list)-c.grid{2}.min)/c.grid{2}.courseMax)+1);
                c.grid{2}.list = [listMod(1:end-1), c.grid{2}.list];
            end
            %Maxes
            if qRound(max(c.grid{1}.list)) < qRound(c.grid{1}.max)
                %Modify list
                listMod = linspace(max(c.grid{1}.list),c.grid{1}.max,ceil((c.grid{1}.max-max(c.grid{1}.list))/c.grid{1}.courseMax)+1);
                c.grid{1}.list = [c.grid{1}.list, listMod(2:end)];
            end
            if qRound(max(c.grid{2}.list)) < qRound(c.grid{2}.max)
                %Modify list
                listMod = linspace(max(c.grid{2}.list),c.grid{2}.max,ceil((c.grid{2}.max-max(c.grid{2}.list))/c.grid{2}.courseMax)+1);
                c.grid{2}.list = [c.grid{2}.list, listMod(2:end)];
            end
            
            %Step 2: Update grid based on max courseness (courseMax)
            %Dumb approach: while it's not at the correct courseness, split
            %the difference between points
            v{1} = c.grid{1}.list;
            v{2} = c.grid{2}.list;
            for i = 1:2
                while round(max(diff(v{i})),4) > round(c.grid{i}.courseMax,4)
                    pointsToAdd = diff(v{i})/2 + v{i}(1:end-1); %make new points
                    v{i} = sort([c.grid{i}.list, pointsToAdd]); %append the new points and sort
                end
                c.grid{i}.list = v{i};
            end
            
            %Step 3: Update maxes/mins/courseness
            v{1} = c.grid{1}.list;
            v{2} = c.grid{2}.list;
            for i = 1:2
                c.grid{i}.max = max(v{i});
                c.grid{i}.min = min(v{i});
                c.grid{i}.courseMax = max(diff(v{i}));
            end
        end
                 
        function c = initialize(c)
           %Initialize Builds grid, loads save directory, adds aux progs to
           %path
            c.utility.maxDiff = 5;
%             c.utility.loadSavesNeeded = 1;
%             c = c.gridSet;
%             c = c.getSaveDir;
            c = c.addAuxProgs;
%             c = c.loadSaves;
%             c = c.updateDesiredPointsFromSaved;

        end
        
        function c = collocation(c, opt)
            %collocation Runs collocation based on opt and seed structure.
            %Seed structure sould be close to opt, but slightly different
            
            %Set counters
            numPerturb = 3;
            tryCounter = 1;
            goAgain = 1;
            
            while tryCounter <= numPerturb && goAgain ~= 0

                %Run collocation
                opt = runOpt(opt);
                tryCounter = tryCounter + 1;

                %Perturb it if it hasn't converged                    
                if opt.collParam.flag <= 0 && tryCounter <= numPerturb
                    opt.X = awgn(opt.X,50);
                end

                %Save it if it's good
                if opt.collParam.flag > 0
                    uniqueID = string(datetime, 'dMMyHHmmssSSSS');
                    if opt.collParam.ankles_on == 1
                        ankleTag = 'ankle_';
                    elseif opt.collParam.ankles_on == 0
                        ankleTag = 'noAnkle_';
                    end
                    filename = strcat('opt_', ankleTag, uniqueID);
                    filename = strcat(c.saveDir,'\',filename);
                    save(filename,'opt');
                    disp('Got One!')
                    c = c.addSaves(opt, filename);
                    goAgain = 0;
                end %save if good
            end %while goAgain ~= 0            
        end
        
        function c = sweepLine(c, gridSweepInd, sweepVarList, gridConstInd, constVarVal, seed)
            %sweepLine Do a line sweep!
            %One variable will sweep while one variable stays constant. The
            %constant variable must match the seed's initial value
            
            %Double check that the constant variable value is the seed's
            %value
            assert(constVarVal == seed.param(c.grid{gridConstInd}.varInd));
            
            %Make sweep lists
            upList = sweepVarList(sweepVarList > c.grid{gridSweepInd}.nom);
            downList = fliplr(sweepVarList(sweepVarList < c.grid{gridSweepInd}.nom)); %This one needs to be flipped
            sweepList = {upList, downList};
            
            %Declare opt struct which starts identical to seed
            opt = seed;
            opt.collParam.flag = 0; %Little hack to get the loop to start
            
            for j = 1:2
                list = sweepList{j};
                for i = 1:length(list)
                    %Set the new sweep parameter (collocation struct
                    %currently not optimal - it's slightly perturbed)
                    opt.param(c.grid{gridSweepInd}.varInd) = list(i);
                    opt = collocation(c, opt);
                    c.utility.loadSavesNeeded = 1;
                end %for every var change in upList and downList
                opt = seed; %Bring the seed back to nominal value and restart upList/downlist
            end %for both lists in full variable sweep
        end %function
        
        function c = sweepInitialGrid(c)
            %sweepGrid Sweep the full grid starting from nominals
            
            ankleTag = {'ankle','noAnkle'};
            for anklesOnOff = [1,2]
                %Load the nominal point (nominal for both var1 and var2)
                assert(isfile(strcat(ankleTag{anklesOnOff},'.mat')),'Make sure that the nominal files (ankle.mat, noAnkle.mat are in current dir')
                load(ankleTag{anklesOnOff},'opt')
                seed = opt; 
                
                %Make sure the nominal matches the grid nominal
                for i = 1:numel(c.grid)
                    assert(seed.param(c.grid{i}.varInd) == c.grid{i}.nom);
                end
                
                %Copy the nominal to save dir
                uniqueID = string(datetime, 'dMMyHHmmssSSSS');
                filename = strcat('opt_', ankleTag{anklesOnOff}, '_', uniqueID);
                save(strcat(c.saveDir,'\',filename),'opt');
                
                clear opt;
                
                %Do a linesweep of var1 with var2 nominal - these will be
                %the nominal seeds from which the rest of the grid will be
                %built
                c.sweepLine(1, c.grid{1}.list, 2, c.grid{2}.nom, seed)
                
                %Do a linesweep of var2 for each var1 starting at nominal
                for var1 = c.grid{1}.list
                    %Find the seed (whatever var1 value, nominal var2)
                    seed = c.findColl(var1, c.grid{2}.nom, ankleTag{anklesOnOff});
                    c.sweepLine(2, c.grid{2}.list, 1, var1, seed);
                end
            end
        end

        function seed = findColl(c, var1, var2, ankleSwitch)
            %findColl Finds collocation file given var1 and var2 values
            %Takes var1 and var2 scalars, ankleOn 1 or 0, returns opt struct
            c = loadSaves(c);
            sigFig = 6; %The number of digits to round to and match
            
            %Load ankle or no ankle depending on ankle input
            
            if strcmp('noAnkle',ankleSwitch)
                s = c.noAnkle;
            elseif strcmp('ankle',ankleSwitch)
                s = c.ankle;
            else
                s = []; disp('No opts loaded to colls, 3rd input to findColl should be ankle or noAnkle');
            end
            
            %Check to make sure something was loaded
            if numel(s) > 0
                %sweep through to find the opt we want
                seed = []; sweepI = 1; seedsFound = 0;%initialize
                while numel(seed) == 0 && sweepI <= length(s.var1)
                    %Note the vars for this opt
                    var1_temp = round(s.var1(sweepI),sigFig);
                    var2_temp = round(s.var2(sweepI),sigFig);

                    %Save it if it's the right one
                    if (var1_temp == round(var1,sigFig)) && (var2_temp == round(var2,sigFig))
                        try
                            load(s.filename{sweepI}); 
                        catch
                            pause(5)
                            load(s.filename{sweepI}); 
                        end
                        seed = opt; clear opt;
                        seedsFound = seedsFound +1;
                    end
                    sweepI = sweepI + 1; %Increment
                end
                assert(seedsFound > 0, 'Opt with those vars not found')
                assert(seedsFound <= 1, 'Multiple opts with those vars were found')
            else
                disp(['Nothing found at ',ankleSwitch, ' class property']);
                seed = [];
            end
        end

        function c = addSaves(c, opt, optFileName)
            %addSaves Takes an input opt and updates points, ankle/noAnkle
            
            %Get var tuple
            varTuple = [opt.param(c.grid{1}.varInd), opt.param(c.grid{2}.varInd)];
            
            %Determine whether its an ankle/noAnkle coll
            if opt.collParam.ankles_on == 1
                ana = 'ankle';
            elseif opt.collParam.ankles_on == 0
                ana = 'noAnkle';
            end
            
            %Put it in points.saved
            c.points.saved.(ana){end+1} = varTuple;
            
            %Update ankle/noAnkle structure
            newInd = length(c.(ana).var1)+1;
            c.(ana).var1(newInd) = varTuple(1);
            c.(ana).var2(newInd) = varTuple(2);
            c.(ana).cost(newInd) = opt.cost;
            c.(ana).filename{newInd} = optFileName;
            
        end
        
        function c = loadSaves(c)
            %loadSaves Load saved coll files in current save directory
            %Updates the ankle and noAnkle properties, sorts by var1                
            if c.utility.loadSavesNeeded == 1
                for ankleSwitch = [0 1]
                    %Decide which files to call
                    if ankleSwitch == 1
                        dirname = strcat(c.saveDir, '\opt_ankle*');
                        c.points.saved.ankle = []; %initialize (remove anything existing)
                    elseif ankleSwitch == 0
                        dirname = strcat(c.saveDir, '\opt_noAnkle*');
                        c.points.saved.noAnkle = []; %initialize (remove anything existing)
                    end

                    %Look for coll files by that name
                    strucc = dir(dirname);

                    %Check to make sure something was actually loaded
                    if numel(strucc) ~= 0
                        %load in optimization structs, noting var1 value
                        for i = 1:length(strucc)
                            filename = strucc(i).name;
                            filename = strcat(c.saveDir, '\', filename);
                            load(filename)
                            opt.filename = filename;
                            results{i} = opt;
                            varr(i) = opt.param(c.grid{1}.varInd); %list var1, we'll sort by this later

    %                         if round(varr(i),5) == .98
    %                             1+1;
    %                             varr(i);
    %                         end
                        end
                        [~,i] = sort(varr); %sort by var1

                        q=1;
                        for k = 1:length(i)
    %                         results_sorted_var{k} = results{i(k)};
    %                         flags(k) = results{i(k)}.collParam.flag;
                            if results{i(k)}.collParam.flag > 0
    %                             res{q} = results_sorted_var{k};
    %                             full = stance2Full(results{i(k)});
                                s.var1(q) = results{i(k)}.param(c.grid{1}.varInd);
                                s.var2(q) = results{i(k)}.param(c.grid{2}.varInd);
                                s.cost(q) = results{i(k)}.cost;
    %                             s.rInitial(q) = results{i(k)}.r(1);
    %                             s.rFinal(q) = results{i(k)}.r(end);
    %                             s.yInitial(q) = results{i(k)}.y(1);
    %                             s.yFinal(q) = results{i(k)}.y(end);
    %                             s.xInitial(q) = results{i(k)}.x(1);
    %                             s.xFinal(q) = results{i(k)}.x(end);
    %                             s.dyInitial(q) = results{i(k)}.dy(1);
    %                             s.dyFinal(q) = results{i(k)}.dy(end);
    %                             s.fDamperFinal(q) = results{i(k)}.param(2)*(results{i(k)}.dr0(end) -results{i(k)}.dr(end));
    %                             s.fSpringFinal(q) = results{i(k)}.param(3)*(results{i(k)}.r0(end) -results{i(k)}.r(end));
    %                             s.tdA(q) = atan2(results{i(k)}.y(1),results{i(k)}.x(1));
    %                             flightTime = full.apexToGroundTime + full.groundToApexTime;
    %                             s.groundedRunMeasure(q) = flightTime/results{i(k)}.Tstance; %Flight Time / Stance Time
    %                             s.peakGRF(q) = max(results{i(k)}.Fleg);
    %                             energy = get_energy3(results{i(k)});
    %                             s.eLegMech(q) = energy.leg_m;
    %                             s.eAnkleMech(q) = energy.ankle_m;
    %                             s.damper(q) = energy.damper;
    %                             s.deltaRtdLO(q) = results{i(k)}.r(end) - results{i(k)}.r(1);
    %                             s.deltaR0tdLO(q) = results{i(k)}.r0(end) - results{i(k)}.r0(1);
    %                             s.maxPush(q) = max(results{i(k)}.r0) - min(results{i(k)}.r0);
    %                             s.tdCentripedalVel(q) = (results{i(k)}.dx(1).*results{i(k)}.y(1) - results{i(k)}.dy(1) .* results{i(k)}.x(1))./ results{i(k)}.r(1);
    %                             s.tdCentripedalF(q) = results{i(k)}.param(1).*s.tdCentripedalVel(q).^2./results{i(k)}.r(1);        
    %                             xFlight = results{i(k)}.param(13) * (results{i(k)}.dy(end) - results{i(k)}.dy(1))/ results{i(k)}.param(10);
    %                             s.distance(q) = xFlight + results{i(k)}.x(end) - results{i(k)}.x(1);
    %                             costEst = (energy.leg_m + energy.ankle_m + energy.ringDamp) ./ s.distance(q);
                                s.filename{q} = results{i(k)}.filename;

                                %Update saved points
                                if ankleSwitch == 1
                                    c.points.saved.ankle{end+1} = [s.var1(q) s.var2(q)];
                                elseif ankleSwitch == 0
                                    c.points.saved.noAnkle{end+1} = [s.var1(q) s.var2(q)];
                                end
                                q = q+1;
                            end
                        end
    %                     s.res = res;
    %                     s.varInd = c.grid{1}.varInd;

                        %update class property
                        if ankleSwitch == 0
                            c.noAnkle = s;
                        elseif ankleSwitch == 1
                            c.ankle = s;
                        end
                    else
                        disp(['Nothing found at ', dirname])
                    end %if there's something to load
                end %For ankle or noAnkle
                c.utility.loadSavesNeeded = 0;
            end %If loadSavesNeed == 1
        end 
        
        function c = gridSet(c)
            %setGrid setup grid structure
            g.varName = 'apex_height';
            g.varNamePretty = 'Apex Height';
            g.varInd = 12;
            g.nom = 1;
            g.min = .7;
            g.max = 1.2;
            g.courseMax = .3;
            listLow = linspace(g.min,g.nom,ceil((g.nom-g.min)/g.courseMax)+1);
            listHigh = linspace(g.nom,g.max,ceil((g.nom-g.min)/g.courseMax)+1);
            g.list = [listLow listHigh(2:end)];
            c.grid{1} = g;
            
            g.varName = 'apex_velocity';
            g.varNamePretty = 'Apex Velocity';
            g.varInd = 13;
            g.nom = 1;
            g.min = .4;
            g.max = 1.2;
            g.courseMax = .3;
            listLow = linspace(g.min,g.nom,ceil((g.nom-g.min)/g.courseMax)+1);
            listHigh = linspace(g.nom,g.max,ceil((g.nom-g.min)/g.courseMax)+1);
            g.list = [listLow listHigh(2:end)];
            c.grid{2} = g;
            
            %setup points structure
            %set initial desired points to grid
            c.points.desired = [];
            count = 1;
            for var1ind = 1:length(c.grid{1}.list)
                for var2ind = 1:length(c.grid{2}.list)
                    c.points.desired{count} = [c.grid{1}.list(var1ind) c.grid{2}.list(var2ind)];
                    count = count+1;
                end
            end
                
            c.points.saved.ankle = [];
            c.points.saved.noAnkle = [];
        end

        function [X,Y,Z,dots] = getZmesh(c, extents)
            %getCoTmesh Looks at saved points and returns an interpolated
            %mesh of x,y,percentCoT data
            
            %If ankle and noAnkle saves don't match, take the smaller one so that calculating
            %percentDecreaseCoT makes sense and throw a warning
            saves = c.ankle;
            assert(numel(c.ankle.var1) == numel(c.points.saved.ankle))
            assert(numel(c.noAnkle.var1) == numel(c.points.saved.noAnkle))
            if (numel(c.ankle.var1) ~= numel(c.noAnkle.var1)) || (numel(c.ankle.var2) ~= numel(c.noAnkle.var2))
                warning('mismatch between ankle saves and noAnkle saves') 
                if numel(c.ankle.var1) < numel(c.noAnkle.var1)
                    saves = c.ankle;
                elseif numel(c.points.saved.ankle) > numel(c.points.saved.noAnkle)
                    saves = c.noAnkle;
                end
            end
            
            %Get saved vars as a list
            var1 = saves.var1;
            var2 = saves.var2;

            %filter them by the extents
%             var1Min = extents(1); var1Max =extents(2); var2Min = extents(3); var2Max = extents(4);
            var1Inds = find(var1>=extents(1)) & (var1<=extents(2));
            var1 = var1(var1Inds); var2 = var2(var1Inds);
            var2Inds = find((var2>=extents(3)) & (var2<=extents(4)));
            var1 = var1(var2Inds); var2 = var2(var2Inds);
            
            %Get z (this is pretty modular)
            z = c.getPercentDecreaseCoT(var1,var2);
            
            %Now make linspaces to build the meshgrid/griddata
            res = 500;
            xlin = linspace(min(var1),max(var1),res); %You can change the 100
            ylin = linspace(min(var2),max(var2),res); %You can change the 100
            [X,Y] = meshgrid(xlin,ylin);
            Z = griddata(var1,var2,z,X,Y,'linear');
            dots.x = var1; dots.y = var2; dots.z = z;
        end
        
        function z = getPercentDecreaseCoT(c,var1,var2)
            %getPercentDecreaseCoT Take a list of var1 and var2 values and
            %return the %decreaseCoT for each var tuple
            
            assert(length(var1) == length(var2),'Input to getPercentDecreaseCoT must be same length')
            %Make sure saves and ankle/noAnkle match
            assert(numel(c.ankle.var1) == numel(c.points.saved.ankle))
            assert(numel(c.noAnkle.var1) == numel(c.points.saved.noAnkle))
            
            %Make sure the requested var1 and var2 values are in
            %ankle/noAnkle
            cot.ankle = []; cot.noAnkle = [];
            for ana = {'ankle','noAnkle'}
                for i = 1:length(var1)
                    %Find where each var value is in the list
                    var1Inds = find(c.(ana{1}).var1 == var1(i));
                    var2Inds = find(c.(ana{1}).var2 == var2(i));
                    %Make sure there's overlap
                    ind = min(intersect(var1Inds,var2Inds));
                    assert(~isempty(ind), ...
                        ['var tuple ' num2str(var1(i)), ', ' num2str(var2(i)), ' not found in ', ana{1}])
                    try
                        cot.(ana{1})(i) = c.(ana{1}).cost(ind);
                    catch
                        1+1; 
                    end
                end
            end
            
            %Now calculate percent decrease in CoT
            z = 100*(cot.noAnkle - cot.ankle)./cot.noAnkle;
        end
            
        function c = visualize(c, extents)
            %Visualize Make a surface of %CoT decrease
            if nargin == 1
                extents = [-inf inf -inf inf];
            end
%             c.utility.loadSavesNeeded = 1;
%             c = c.loadSaves;
            [X,Y,Z, dots] = c.getZmesh(extents);
            figure;
%             contourf(X,Y,Z);
            surf(X,Y,Z,'LineStyle','none');
            hold on;
%             plot3(dots.x,dots.y,dots.z,'r.','MarkerSize',15);
            xlabel(c.grid{1}.varNamePretty)
            ylabel(c.grid{2}.varNamePretty)
            zlabel('Percent Decrease')
            title('Ankle Utility')
            cb = colorbar;
            ylabel(cb,'Ankle Utility (Percent Decrease CoT)');
            cb.Label.FontSize = 12;
        end
        
        function c = animateVis(c)
            %animateVis Makes a gif of last figure
            fig =gcf;
            camDist = norm(fig.Children(2).CameraPosition(1:2));
            res = 60*5;
            for i = 0:res
                %Set Camera position
                fig.Children(2).CameraPosition(1:2) = camDist*[cos(2*pi*i/res) sin(2*pi*i/res)];

                if i == 0
                    filename = 'newGif.gif';
                    gif(filename,'frame',fig);
                elseif i > 0
                    gif
                end  
            end            
        end
        
        function c = deleteColl(c, var, val)
            assert(var == 1 || var == 2);
            q = 1; filenameList = [];
            uniqueID = string(datetime, 'dMMyHHmmssSSSS');
            newDir = strcat(c.saveDir, '\deletedColls_',num2str(uniqueID));
            mkdir(newDir);
            
            %Find the bastards
            for ana = {'ankle','noAnkle'}
                for i = 1:numel(c.points.saved.(ana{1}))
                    if c.points.saved.(ana{1}){i}(var) <= val
                        disp([c.points.saved.(ana{1}){i}(var) c.(ana{1}).(['var', num2str(var)])(i)]);
                        filenameList{q} = c.(ana{1}).filename{i};
                        q = q+1;
                    end
                end
            end
            
            %Move em
            for i = 1:numel(filenameList)
                try
                    movefile(filenameList{i}, newDir)
                catch
                    1+1
                end
            end
            
        end
            
        
        function c = addAuxProgs(c)
            if strcmp(pwd,'C:\Users\Mike\Google Drive\DRL- Mike Hector\Collocation\analytics_simple\simple_36_28_with_full_d_cot_new_30')
                addpath('C:\Users\Mike\Google Drive\DRL- Mike Hector\Collocation\analytics_simple\aux_progs');
            elseif strcmp(pwd,'C:\Users\DRL-Valkyrie\Google Drive\DRL- Mike Hector\Collocation\analytics_simple\simple_36_28_with_full_d_cot_new_30')
                addpath('C:\Users\DRL-Valkyrie\Google Drive\DRL- Mike Hector\Collocation\analytics_simple\aux_progs\');
            end
        end

        function c = getSaveDir(c)
            if strcmp(pwd,'C:\Users\Mike\Google Drive\DRL- Mike Hector\Collocation\analytics_simple\simple_36_28_with_full_d_cot_new_30')
                c.saveDir = 'C:\Users\Mike\Google Drive\CollocationResults\absIntFVobj_sweep_apex_height_vel';
            elseif strcmp(pwd,'C:\Users\DRL-Valkyrie\Google Drive\DRL- Mike Hector\Collocation\analytics_simple\simple_36_28_with_full_d_cot_new_30\collsClass')
                c.saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\absIntFVobj_sweep_apex_height_vel';
            else
                disp('NO SAVE DIRECTORY SET!')
            end
        end
    end
end