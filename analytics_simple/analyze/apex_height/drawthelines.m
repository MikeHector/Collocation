function drawthelines(p)
%DRAWTHELINES Summary of this function goes here
%   Detailed explanation goes here
    axis([p.Parent.XLim, p.Parent.YLim])
    makeVref = @(t, p) plot([t, t],p.Parent.YLim, 'LineStyle','--','Color','r', 'LineWidth',.2);
    makeVref(.926,p); hold on;
    makeVref(.948,p); 
    makeVref(.99,p);

end

