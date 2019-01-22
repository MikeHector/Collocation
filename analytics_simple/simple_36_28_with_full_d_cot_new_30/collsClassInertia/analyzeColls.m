%Make some plots

s = c.noAnkle;
sa = c.ankle;

[~,~,~,dots] = c.getZmesh([-inf inf -inf inf]);
auStart = .9342;
auEnd = .9835;
%High level: ankleUtility vs apex height
figure
% nu = 100*(s.cost_graph - sa.cost_graph)./s.cost_graph;
% plot(.9291,2.8,'bo');
% hold on; plot(.9272,2.65,'rs')
p = plot(s.var1, dots.z); hold on;
%vertical lines
% axis([p.Parent.XLim, p.Parent.YLim])
% makeVref = @(t, p) plot([t, t],p.Parent.YLim, 'LineStyle','--','Color','r', 'LineWidth',.2);
% makeVref(auStart,p); hold on;
% makeVref(auEnd,p); hold on;

% text(.8, 1.6,'1','FontSize',30,'interpreter','latex','HorizontalAlignment','center');
% text(.935, 1.6,'2','FontSize',30,'interpreter','latex','HorizontalAlignment','center');
% text(.968, 1.6,'3','FontSize',30,'interpreter','latex','HorizontalAlignment','center');
% text(1.15, 1.6,'4','FontSize',30,'interpreter','latex','HorizontalAlignment','center');
title('Ankle Utility')
ylabel('Percent CoT Decrease'); xlabel('Apex Height')
% text(1,3.5,'\% Decrease in $COT = 100 * \frac{COT_{No \ Ankle} - COT_{Ankle}}{COT_{No \ Ankle}}$','Interpreter','latex','FontSize',20,'HorizontalAlignment','center')
% text(.8,3,'$COT = \frac{\int \ max(0, \ Fv) \ dt}{mgd}$','Interpreter','latex','FontSize',20,'HorizontalAlignment','center')
% legend('Optimal with ankle','Optimal without ankle')






figure;
plot(sa.var1, dots.z);
% hold on; plot(s.var1, s.rInitial);
title('ankle Utility');
% legend('ankle', 'noAnkle')

figure;
p4 = subplot(2,2,4);
plot(sa.var1, sa.rInitial);
hold on; plot(s.var1, s.rInitial);
p4.XLim = [auStart, auEnd];
title('rInitial');
legend('ankle', 'noAnkle','Location','southeast')
grid on

% figure;
% plot(sa.var1, sa.rFinal);
% hold on; plot(s.var1, s.rFinal);
% title('rFinal');
% legend('ankle', 'noAnkle')

% figure;
p3 = subplot(2,2,3);
plot(sa.var1, sa.yInitial);
hold on; plot(s.var1, s.yInitial);
p3.XLim = [auStart, auEnd];
title('yInitial');
legend('ankle', 'noAnkle','Location','southeast')
grid on

% figure;
p2 = subplot(2,2,2);
plot(sa.var1, sa.distance);
hold on; plot(s.var1, s.distance);
p2.XLim = [auStart, auEnd];h
title('distance traveled');
legend('ankle', 'noAnkle','Location','southeast')
grid on

% figure;
p1 = subplot(2,2,1);
plot(sa.var1, sa.eIn);
hold on; plot(s.var1, s.eIn);
p1.XLim = [auStart, auEnd];
title('Energy Input');
legend('ankle', 'noAnkle','Location','southeast')
grid on