%Do some stuff with my colls class
clear;

%% Test 1 - loading and initializing
clear
c = colls;
c = c.initialize;
assert(~isempty(c.grid),'grid not initialized');
assert(~isempty(c.saveDir),'save directory not initialized')

%% Test 2 - assume sweep grid works (test later)
clear
c = colls;
c = c.initialize;
c.saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\testSweepGrid';
c.sweepInitialGrid;

%% Test 3 - change grid, do later

%% Test 4 - Change grid (c.grid{i}.list) check stuff
clear
c = colls;
c = c.initialize;
%Change grid.list
c.grid{1}.list = [c.grid{1}.list(1:3), 1.0454543, c.grid{1}.list(4:end)];
c.grid{2}.list = [c.grid{2}.list(1:3), 1.06, c.grid{2}.list(4:end)];

%Check missing colls
d = c.missingGridPoints;

assert(numel(d) == (length(c.grid{1}.list)+length(c.grid{2}.list)))


%% Test 5 - Find nearby seed
clear
c = colls;
c = c.initialize;
%Change grid.list
newVar1 = 1.0454543;
newVar2 = 1.06;
c.grid{1}.list = [c.grid{1}.list(1:3), newVar1, c.grid{1}.list(4:end)];
c.grid{2}.list = [c.grid{2}.list(1:3), newVar2, c.grid{2}.list(4:end)];

%Find seed very close to new grid point (should not find new grid point)
nearSeed = c.findNearestSeed(newVar1, newVar2, 'ankle');
disp('These should not be the same')
[newVar1 newVar2]
[nearSeed.param(c.grid{1}.varInd) nearSeed.param(c.grid{2}.varInd)]
%% Test 6 - Update Saved Colls
clear
c = colls;
c = c.initialize;

%Change grid.list
c.grid{1}.min = .65;
% d = c.missingGridPoints;
c.updateSavedColls;

%% Test 7 - visualize flags uneven saved colls
clear
c = colls;
c = c.initialize;

newVars = [.9, .85]; %[var1 var2]
c.points.desired{end+1} = newVars; %Add a desired point
c = c.updateSavedColls;
% opt = c.findNearestSeed(newVars(1),newVars(2),'ankle');
% opt.param(12) = newVars(1); opt.param(13) = newVars(2);
% opt = c.collocation(opt);


% c = c.dumbRefine;
% c.grid{1}.min = .1;
% c.grid{2}.min = .1;
% c.grid{1}.max = 2;
% c.grid{2}.max = 2;
% c.grid{1}.courseMax = .1;
% c = c.updateGridList;
% c.grid{1}
% c.grid{2}
%Let's sweep our initial grid
% c.sweepInitialGrid;
% d = c.missingGridPoints;

% q = c.findNearestSeed(1,1,'noAnkle');
% q.param(12:13)
a = 1;
count_i = 1;
while count_i <= length(a)
%     a = [a,a(end)+1]
    count_i = count_i+1;
end