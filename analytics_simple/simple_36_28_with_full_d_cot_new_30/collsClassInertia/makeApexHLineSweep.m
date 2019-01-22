%Use the colls class to make the grid of apex height and apex velocity
%collocations from scratch

%% Initialize
clear;
c = colls;
c.saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\combinedObj_sweep_apexH_line_noI_alpha1';
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

g.varName = 'apex_velocity';
g.varNamePretty = 'Apex Velocity';
g.varInd = 13;
g.nom = 1;
g.min = 1;
g.max = 1;
g.courseMax = 1.6/50; %Lets do same as apex height-ish
listLow = linspace(g.min,g.nom,ceil((g.nom-g.min)/g.courseMax)+1);
listHigh = linspace(g.nom,g.max,ceil((g.max-g.nom)/g.courseMax)+1);
g.list = [listLow listHigh(2:end)];
g.list =g.nom; %Disregard code above
c.grid{2} = g;
clear g;

%Copy seeds to save directory
copyfile('ankle_noI_alpha1.mat',strcat(c.saveDir,'\opt_ankle_seed.mat'));
copyfile('noAnkle_noI_alpha1.mat',strcat(c.saveDir,'\opt_noAnkle_seed.mat'));
c.utility.loadSavesNeeded = 1;
c = c.loadSaves;

try
    %Do the damn thing!
    c = c.updateSavedColls;
    c.utility.loadSavesNeeded = 1; c = c.loadSaves;
    % %% Update grid
    % %Update for interesting part of apex height
    c = c.updateInterestingPartsList(1,[.9 1], .001);
    c = c.updateDesiredPointsFromGrid;
    c = c.updateSavedColls;
    
    c = c.reSeedAreaV2([-inf inf -inf inf],{'ankle'})
    c = c.reSeedAreaV2([-inf inf -inf inf],{'noAnkle'})
    c.utility.loadSavesNeeded = 1; c = c.loadSaves;

catch
    datetime
    1+1;
end
