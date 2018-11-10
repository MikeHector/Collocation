clear; %close all;
load('noAnkleInf.mat');
x = [opt.x';opt.y';opt.r0';opt.dx';opt.dy';opt.dr0'];
u = [opt.ddr0';opt.Tankle'];
p.m = opt.param(1); p.k = opt.param(3); p.c = opt.param(2); p.transmission_ankle = opt.param(9);
p.g = opt.param(10);
tk = opt.t;
[t,x,c,xDotInterp] = interpolate(opt.t,x,u,p);

for i =1:length(t)
    f(:,i) = stanceDyn([x(:,i); c(:,i)],p);
end

error = f - xDotInterp;
figure; plot(t,abs(error')); legend('dx','dy','dr0','ddx','ddy','ddr0');
hk = mean(diff(tk));
for ii = 1:size(x,1)
    for i = 1:length(tk)-1
        inds = (i-1)*10+1:i*10;
        nk(ii,i) = trapz(abs(error(ii,inds)))*hk;
    end
end
figure; plot(tk(1:end-1),nk); legend('x','y','r0','dx','dy','dr0')
