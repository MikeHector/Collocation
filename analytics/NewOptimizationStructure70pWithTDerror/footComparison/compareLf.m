clear
close all
load("seedC_quartermFoot.mat")
quarter = opt;
load("seedC_halfmFoot.mat")
half = opt;
load("seedC_1mFoot.mat")
one = opt;
load("seedC_2mFoot.mat")
two = opt;
load('seedC');
pOneFive = opt;
load('seedC_4mFoot.mat');
four = opt;
load('seedC_8mFoot.mat');
eight = opt;
load('seedC_16mFoot.mat');
sixteen = opt;
load('seedC_32mFoot.mat');
thirtytwo = opt;
load('seedC_64mFoot.mat');
sixtyfour = opt;
load('seedC_10000Foot.mat');
tenk = opt;
opts = {pOneFive, quarter, half, one, two, four, eight, sixteen, thirtytwo, sixtyfour, tenk};
names = {'0.15m','0.25m','0.5m','1m','2m', '4m', '8m', '16m', '32m', '64m', '10000m'};
posAF = 1:numel(names);
posT = numel(names)+1:2*numel(names);
figure;
for i = 1:length(opts)
    o = opts{i};
    ankleF = o.param(o.collParam.modelParamList == 'transmission_ankle') * o.Tankle .*...
        (o.x .* o.dy - o.y .* o.dx) ./o.r.^2;
    subplot(2,numel(names),posAF(i));
    plot(o.t, ankleF)
    title(['Foot length = ',names(i)])
    xlabel('Time of stance')
    ylabel('Ankle force on COM')
    axis([0 .6, 0 70])
    
    subplot(2,numel(names),posT(i));
    plot(o.t, o.Tankle)
    title('Ankle Torque');
    xlabel('Time of stance')
    ylabel('Ankle Force on COM')
    axis([0 .6, -2 0])
end
    
    