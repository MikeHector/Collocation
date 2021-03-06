function [full] = stance2Full(opt)
%UNTITLED Take an full struct, extend the stance phase to
%flight-stance-flight phase
%   Detailed explanation goes here
    full = opt;

    full.stanceStartTime = full.t(1);
    full.stanceEndTime = full.t(end);

    %% Apex 2 ground
    yApex = opt.param(12);
    deltaY = yApex - opt.y(1);
    if deltaY > 1e-6
        Nflight = full.collParam.N;
        tTD = sqrt((2*deltaY)/(opt.param(10)));
        tTemp = linspace(0,tTD,Nflight);
        yf = yApex - .5 * full.param(10) * tTemp(1:end-1).^2;
        % figure; plot(tTemp, yf); hold on; plot(tTemp(end),full.y(1),'bo')
        xapex = full.x(1) - full.dx(1) * tTemp(end);
        xf = xapex + full.dx(1) * tTemp(1:end-1);
        dyf = -full.param(10)*tTemp(1:end-1);
        % stanceStartTime = tTemp(end);  
        full.stanceStartTime = tTD;
        full.stanceEndTime = full.t(end)+tTD;
        t1 = linspace(-max(tTemp),0,length(tTemp)) + tTemp(end);
        t1 = t1(1:end-1);
    else 
        Nflight = 1;
        xf = [];
        yf = [];
        dyf = [];
        full.stanceStartTime = 0;
        full.stanceEndTime = full.t(end);
        t1 = [];
    end
    full.stanceStartN = Nflight;
    full.stanceEndN = Nflight + full.collParam.N -1;
    full.apexToGroundTime = opt.dy(1) ./ -full.param(10);
    



    %% Ground 2 apex
    tApex = -full.dy(end)./-full.param(10);
    full.groundToApexTime = tApex;

    if tApex > 1e-6
        Napex = full.collParam.N;
        tApex = linspace(0,tApex,Napex);
        ylo = full.y(end) + full.dy(end) * tApex(2:end) + .5 * -full.param(10)* tApex(2:end).^2;
        % figure; plot(tApex, ylo); hold on; plot(tApex(1),full.y(end),'bo')
        xlo = full.x(end) + full.dx(end) * tApex(2:end);
        dylo = full.dy(end) - full.param(10) * tApex(2:end);
    %     stanceEndTime = full.t(end) + tApex(end);
        t2 = linspace(full.t(end),full.t(end)+tApex(end),length(tApex)) + full.stanceStartTime;
        t2 = t2(2:end);
    else
        Napex = full.collParam.N;
        tApex = 0;
        ylo = [];
        xlo = [];
        dylo = [];
        t2 = [];
    end

    full.t = [t1, full.t + full.stanceStartTime,t2];
    full.x = [xf, full.x', xlo];
    full.dx = [ones(size(t1))*full.dx(1), full.dx', ones(size(t2))*full.dx(end)];
    full.y = [yf, full.y', ylo];
    full.dy = [dyf, full.dy', dylo];

    %This continue at first/last value
    list = {'r','r0'};
    for i = 1:length(list)
        full.(list{i}) = [ones(size(t1))*full.(list{i})(1), full.(list{i})', ones(size(t2))*full.(list{i})(end)];
    end

    %These are 0
    list = {'dr0','ddr0','Tankle','dr','Fleg','xcop','Fankle'};
    for i = 1:length(list)
        full.(list{i}) = [0*ones(size(t1))*full.(list{i})(1), full.(list{i})', 0*ones(size(t2))*full.(list{i})(end)];
    end

    if length(full.t) ~= length(full.x)
        1+1;
    end
    
    assert(full.x(full.stanceStartN) == opt.x(1),'Stance start mismatch - x')
    assert(full.y(full.stanceStartN) == opt.y(1),'Stance start mismatch - y')
end

