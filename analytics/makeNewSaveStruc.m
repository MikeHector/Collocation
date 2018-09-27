function [] = makeNewSaveStruc(p,e, currdir, dirname)
%UNTITLED2 Summary of this function goes here

load('saveStruc')
opt.x = [];
opt.y = [];
opt.r0 = [];
opt.dx = [];
opt.dy = [];
opt.dr0 = [];
opt.Tleg = [];
opt.Tankle = [];
opt.theta = [];
opt.Tstance = [];
opt.Tflight = [];
opt.tstance = [];
opt.tflight = [];
opt.t = [];
opt.param = e.vSymList;

opt.collParam.N = p.N;
opt.collParam.Nstance = p.Nstance;
opt.collParam.Nflight = p.Nflight;
opt.collParam.dof = p.dof;
opt.collParam.cntrl_dof = p.cntrl_dof;

q = rmfield(e.vNum,{'N','Nstance', 'Nflight','dof','cntrl_dof'});
opt.collParam.modelParamList = fields(q);

opt.r = [];
opt.cost = inf;
opt.X = rand(size(e.dvSym));
opt.seeParam = "[num2cell([1:numel(opt.param)]'), opt.collParam.modelParamList, num2cell(opt.param)']";

filename = [currdir,dirname,'\', 'newSaveStruc3'];
save(filename,'opt');

end

