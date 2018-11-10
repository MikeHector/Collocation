function [] = slipPlot(opt)
    
    f = stance2Full(opt);
    
    
    makeVref = @(t, p) plot([t, t],p.Parent.YLim, 'LineStyle','--','Color','r');
    figure
    %t vs y
    %t vs x
    %t vs r0
    %t vs ddr0
    %t vs Tankle
    plotI = {'y','x','r0','ddr0','Tankle'};
    
    numPlots = numel(plotI);
    for i = 1:numPlots
        subplot(numPlots,1,i);
        p1 = plot(f.t, f.(plotI{i})); hold on;
        makeVref(f.stanceStartTime, p1);
        makeVref(f.stanceEndTime, p1); grid on;
        title(plotI{i}); xlabel('time');
    end
    
    
end
    
    