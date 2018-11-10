f = {'x','y','r0','dx','dy','dr0','ddr0','Tankle'};
oldTime = opt.t;
newN = 31;
newTime = linspace(0,opt.Tstance,newN);
X = [];
for i = 1:numel(f)
    newCol = interp1(oldTime,opt.(f{i}),newTime)';
    X = [X; newCol];
end

X(end+1) = opt.Tstance;
opt.collParam.N = newN;
opt.X = X;