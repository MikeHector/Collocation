%Use the colls class to make the grid of apex height and apex velocity
%collocations from scratch

%% Initialize
clear;
c = colls;
c.saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\absIntFVobj_sweep_apex_height_vel';
c = c.initialize;

%Setup the grid
g.varName = 'apex_height';
g.varNamePretty = 'Apex Height';
g.varInd = 12;
g.nom = 1;
g.min = .7;
g.max = 1.2;
g.courseMax = .2/10; %10 points in .2 (for nominal part of apex height)
listLow = linspace(g.min,g.nom,ceil((g.nom-g.min)/g.courseMax)+1);
listHigh = linspace(g.nom,g.max,ceil((g.nom-g.min)/g.courseMax)+1);
g.list = [listLow listHigh(2:end)];
c.grid{1} = g;
clear g;

g.varName = 'apex_velocity';
g.varNamePretty = 'Apex Velocity';
g.varInd = 13;
g.nom = 1;
g.min = .4;
g.max = 1.2;
g.courseMax = .2/10; %Lets do same as apex height
listLow = linspace(g.min,g.nom,ceil((g.nom-g.min)/g.courseMax)+1);
listHigh = linspace(g.nom,g.max,ceil((g.nom-g.min)/g.courseMax)+1);
g.list = [listLow listHigh(2:end)];
c.grid{2} = g;
clear g;

%Copy seeds to save directory
copyfile('ankle.mat',strcat(c.saveDir,'\opt_ankle_seed.mat'));
copyfile('noAnkle.mat',strcat(c.saveDir,'\opt_noAnkle_seed.mat'));
c.utility.loadSavesNeeded = 1;

%Do the damn thing!
c = c.updateSavedColls;

%% Update grid
%Update for interesting part of apex height
c = c.updateInterestingPartsList(1,[.9 1], .003);
c = c.updateSavedColls;
%% Update grid again
%I NEED MORE DATA!!!!!!!!!!!!!!!!!!!
c = c.updateInterestingPartsList(1,[.9 1], .001); %He's become drunk with data
c = c.updateSavedColls;





