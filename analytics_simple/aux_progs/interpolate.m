function [t,x,c,xDotInterp] = interpolate(t,state,control, p)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%%%
mesh = 10;
tk = t;
hk = mean(diff(tk));
xk = state(1:6,:);
for i =1:length(xk)
    fk(:,i) = stanceDyn([state(:,i);control(:,i)],p);
end
x = [];
t = [];
for i = 1:length(tk)-1
    xTemp = [];
    if i < length(tk) -1
        tTemp = linspace(tk(i),tk(i+1),mesh+1).';
    elseif i == length(tk) -1
        tTemp = linspace(tk(i),tk(i+1),mesh).';
    end
    tau = tTemp - tk(i);
    for ii = 1:length(tau)
        xTemp(end+1,:) = xk(:,i) + fk(:,i) .* tau(ii) + tau(ii).^2./(2*hk) .* (fk(:,i+1)-fk(:,i));
    end
    if i < length(tk)-1
        t = [t; tTemp(1:end-1)];
        x = [x; xTemp(1:end-1,:)];
    elseif i == length(tk)-1
        t = [t; tTemp(1:end)];
        x = [x; xTemp(1:end,:)];
    end
end

c1 = interp1(tk, control(1,:),t);
c2 = interp1(tk, control(2,:),t);
c = [c1, c2];

f_linInt = [];
for i = 1:size(fk,1)
    f_linInt = [f_linInt,interp1(tk,fk(i,:),t)];
end

xDotInterp = [x(:,4:6), f_linInt(:,4:6)];
t = t'; x = x'; c = c'; xDotInterp = xDotInterp';
end
