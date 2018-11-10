clear; close all;
load('trapzRes.mat');
[t,x,c,f] = interpolate(opt,F,p);


for i =1:length(t)
    xDotInterp(i,:) = Dyn([x(i,1); x(i,2); c(i)],p);
end

error = f - xDotInterp;
figure; plot(error)

for i = 1:length(opt)
    nk(i) = trapz(error((i-1)*10+1:i*10));
end
figure; plot(time,nk)