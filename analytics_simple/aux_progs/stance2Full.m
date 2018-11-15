function [opt] = stance2Full(opt)
%UNTITLED Take an opt struct, extend the stance phase to
%flight-stance-flight phase
%   Detailed explanation goes here
opt.stanceStartTime = opt.t(1);
opt.stanceEndTime = opt.t(end);

N = opt.collParam.N;
deltaT = mean(diff(opt.t));


tTD = opt.dy(1) ./ -opt.param(10);
Nflight = round(tTD / deltaT);
tTemp = linspace(0,tTD,Nflight);
yapex = opt.y(1) - .5 * -opt.param(10) * tTemp(end).^2;
yf = yapex - .5 *opt.param(10) * tTemp.^2;
% figure; plot(tTemp, yf); hold on; plot(tTemp(end),opt.y(1),'bo')
xapex = opt.x(1) - opt.dx(1) * tTemp(end);
xf = xapex + opt.dx(1) * tTemp;
dyf = -opt.param(10)*tTemp;
% stanceStartTime = tTemp(end);

opt.stanceStartN = Nflight+1;
opt.stanceEndN = Nflight + 1 + opt.collParam.N;
opt.stanceStartTime = tTD;
opt.stanceEndTime = opt.t(end)+tTD;


tApex = -opt.dy(end)./-opt.param(10);
Napex = floor(tApex / deltaT);
tApex = linspace(0,tApex,Napex);
ylo = opt.y(end) + opt.dy(end) * tApex + .5 * -opt.param(10)* tApex.^2;
% figure; plot(tApex, ylo); hold on; plot(tApex(1),opt.y(end),'bo')
xlo = opt.x(end) + opt.dx(end) * tApex;
dylo = opt.dy(end) - opt.param(10) * tApex;
% stanceEndTime = opt.t(end) + tApex(end);

opt.t = [linspace(-tTemp(end),0,Nflight), opt.t, linspace(opt.t(end),opt.t(end)+tApex(end),Napex)] + tTemp(end);
opt.x = [xf, opt.x', xlo];
opt.dx = [ones(size(tTemp))*opt.dx(1), opt.dx', ones(size(tApex))*opt.dx(end)];
opt.y = [yf, opt.y', ylo];
opt.dy = [dyf, opt.dy', dylo];

%This continue at first/last value
list = {'r','r0'};
for i = 1:length(list)
    opt.(list{i}) = [ones(size(tTemp))*opt.(list{i})(1), opt.(list{i})', ones(size(tApex))*opt.(list{i})(end)];
end

%These are 0
list = {'dr0','ddr0','Tankle','dr','Fleg','xcop','Fankle'};
for i = 1:length(list)
    opt.(list{i}) = [0*ones(size(tTemp))*opt.(list{i})(1), opt.(list{i})', 0*ones(size(tApex))*opt.(list{i})(end)];
end


% opt.r0 = [ones(size(tTemp))*opt.r0(1), opt.r0', ones(size(tApex))*opt.r0(end)];
% opt.dr0 = [ones(size(tTemp))*opt.dr0(1), opt.dr0', ones(size(tApex))*opt.dr0(end)];
% opt.ddr0 = [ones(size(tTemp))*opt.ddr0(1), opt.ddr0', ones(size(tApex))*opt.ddr0(end)];
end

