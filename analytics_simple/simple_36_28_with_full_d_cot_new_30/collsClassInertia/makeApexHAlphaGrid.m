%Use the colls class to make the grid of apex height and apex velocity
%collocations from scratch

%% Initialize
clear;
c = colls;
c.saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\combinedObj_sweep_apexH_alpha';
c = c.initialize;

%Setup the grid
g.varName = 'apex_height';
g.varNamePretty = 'Apex Height';
g.varInd = 12;
g.nom = 1;
g.min = .7;
g.max = 1.2;
g.courseMax = .5/50; %50 points in .5 (for nominal part of apex height)
listLow = linspace(g.min,g.nom,ceil((g.nom-g.min)/g.courseMax)+1);
listHigh = linspace(g.nom,g.max,ceil((g.max-g.nom)/g.courseMax)+1);
g.list = [listLow listHigh(2:end)];
c.grid{1} = g;
clear g;

g.varName = 'c_objWeight';
g.varNamePretty = '\alpha';
g.varInd = 25;
g.nom = 0;
g.min = 0;
g.max = .35; %Checked!
g.courseMax = .35/50; %Lets do same as apex height
listLow = linspace(g.min,g.nom,ceil((g.nom-g.min)/g.courseMax)+1);
listHigh = linspace(g.nom,g.max,ceil((g.max-g.nom)/g.courseMax)+1);
g.list = [listLow listHigh(2:end)];
c.grid{2} = g;
clear g;

%Copy seeds to save directory
copyfile('ankle.mat',strcat(c.saveDir,'\opt_ankle_seed.mat'));
copyfile('noAnkle.mat',strcat(c.saveDir,'\opt_noAnkle_seed.mat'));
c.utility.loadSavesNeeded = 1;
c = c.loadSaves;

%Do the damn thing!
c = c.updateSavedColls;


%Add more points for apex height between .9 and 1
c = c.updateInterestingPartsList(1,[.9 1], .001);
% 
% %Update desired points
% % c = c.updateDesiredPointsFromGrid;
% c.utility.loadSavesNeeded = 1;
% c = c.loadSaves;
% 
% %Do the damn thing!
% c = c.updateSavedColls;
% 
% 
% %Add more points for apex height between .9 and 1
% c = c.updateInterestingPartsList(1,[.955 .98], .001);
% 
% %Update desired points
% % c = c.updateDesiredPointsFromGrid;
% c.utility.loadSavesNeeded = 1;
% c = c.loadSaves;
% 
% %Do the damn thing!
% c = c.updateSavedColls;


