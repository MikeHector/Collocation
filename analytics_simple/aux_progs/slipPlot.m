function [] = slipPlot(opt)
    
    f = stance2Full(opt);
    
    
    makeVref = @(t, p) plot([t, t],p.Parent.YLim, 'LineStyle','--','Color','r', 'LineWidth',1.4);
    figure
    %t vs y
    %t vs x
    %t vs r0
    %t vs ddr0
    %t vs Tankle
    plotI = {'y','x','r0','ddr0','Tankle','Fleg'};
    t = {'Center of mass height','Center of mass horizontal position','Leg extension, $r_0$','Leg acceleration, $\ddot{r}_{0}$ (control input)',' $\tau_{Ankle}$ (control input)','Ground Reaction Force'};
    y = {'Height, m','Position, m','Position, m', 'Acceleration, $\frac{m}{s^{2}}$','Torque, Nm','Force, N'};
    
%     plotI = {'dr0','ddr0'};
%     t = {'Leg velocity, $\dot{r}_{0}$','Leg acceleration, $\ddot{r}_{0}$ (control input)'};
%     y = {'Velocity, $\frac{m}{s}$', 'Acceleration, $\frac{m}{s^{2}}$'};
    
    
    numPlots = numel(plotI);
    for i = 1:numPlots
        subplot(numPlots,1,i);
        p1{i} = plot(f.t, f.(plotI{i}),'LineWidth',1); hold on;
        makeVref(f.stanceStartTime, p1{i});
        makeVref(f.stanceEndTime, p1{i}); grid on;
        ylabel(y{i},'Interpreter','latex','fontsize',14)
        title(t{i},'Interpreter','latex','fontsize',18)
    end
    
    subplot(numPlots,1,1);
    height = min(opt.y);
    p1{1}.Parent.YLim(1) = p1{1}.Parent.YLim(1) - diff(p1{1}.Parent.YLim)*.1;
    text(f.stanceStartTime-.02,height,'Flight','Interpreter','latex','fontsize',12,'HorizontalAlignment','right')
    text(f.stanceStartTime+.02,height,'Stance Start','Interpreter','latex','fontsize',12)
    text(f.stanceEndTime-.02,height,'Stance End','Interpreter','latex','fontsize',12,'HorizontalAlignment','right')
    text(f.stanceEndTime+.02,height,'Flight','Interpreter','latex','fontsize',12)
    
end
    
    