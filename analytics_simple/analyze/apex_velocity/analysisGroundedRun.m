% MHector
% 8.14.18
% COL analysis
clc; clear; %close all
record_video = 0;
if record_video==1
    v=VideoWriter('Apex_velocity','MPEG-4');
    v.FrameRate=5;
    open(v);
end

varName = 'apex_velocity';

sa = loadResults('apex_velocity',1);

s = loadResults('apex_velocity',0);

varmaxplot = 1.1;
varminplot = .9;
energyMax = .7;
plotName = 'Apex Velocity';

fig = figure;
an1 = plot(1,1,'b'); hold on; an2 = plot(1,1, 'r'); %an11 = plot(1,1,'bo'); an21 = plot(1,1,'ro');

Ylim =1.2;
% makeVref = @(t, p) plot([t, t],[Ylim,Ylim], 'LineStyle','--','Color','r', 'LineWidth',1.4);
% an2 = makeVref(0,an1);
% an3 = makeVref(1,an1);
% axis([-1.2,1.2, 0, Ylim]); 
axis([-.1,1.1, .7, Ylim]); 
title1 = title('anklesRkool');
legend('no ankle','ankle')

tc = 0:.01:pi;
% plot(cos(tc),sin(tc),'k');

i = 1;
while s.var_graph(i) < varmaxplot

   if (s.res{i}.collParam.flag > 0) && (s.var_graph(i) > varminplot)

        full = stance2Full(s.res{i});

        an1.XData = full.t./full.t(end);
%         an1.XData = full.x;
        an1.YData = full.r0;
%         an1.YData = full.r;
%         an1.YData = full.y;

        
%         an11.XData = [full.t(full.stanceStartN)./full.t(end), full.t(full.stanceEndN)./full.t(end)];
%         an11.XData = [full.x(full.stanceStartN), full.x(full.stanceEndN)];
%         an11.YData = [full.r0(full.stanceStartN), full.r0(full.stanceEndN)];
%        an11.YData = [full.r(full.stanceStartN), full.r(full.stanceEndN)];

%         an2.XData = [full.stanceStartTime./full.t(end), full.stanceStartTime./full.t(end)];
%         an2.YData = an2.Parent.YLim;
%         an3.XData = [full.stanceEndTime./full.t(end), full.stanceEndTime./full.t(end)];
%         an3.YData = an3.Parent.YLim;
        
%         an2.XData = [full.x(full.t == full.stanceStartTime), full.x(full.t == full.stanceStartTime)];
%         an2.YData = an2.Parent.YLim;
%         an3.XData = [full.x(full.t == full.stanceEndTime), full.x(full.t == full.stanceEndTime)];
%         an3.YData = an3.Parent.YLim;

        
        fullsa = stance2Full(sa.res{i});

        an2.XData = fullsa.t./fullsa.t(end);
%         an2.XData = fullsa.x;
        an2.YData = fullsa.r0;
%         an2.YData = fullsa.r;
%         an2.YData = fullsa.y;
        
%         an21.XData = [fullsa.t(full.stanceStartN)./full.t(end), fullsa.t(full.stanceEndN)./full.t(end)];
%         an21.XData = [fullsa.x(full.stanceStartN), fullsa.x(full.stanceEndN)];
%         an21.YData = [fullsa.r0(full.stanceStartN), fullsa.r0(full.stanceEndN)];
%         an21.YData = [fullsa.r(full.stanceStartN), fullsa.r(full.stanceEndN)];
        axis equal
        
        title1.String = ['Apex Height = ', num2str(s.var_graph(i))];
        drawnow
        pause(.1)
        if record_video==1
            F=getframe(gcf);
            writeVideo(v,F);
        end
    end
    i = i + 1;
end

if record_video == 1
    close(v)
end

% Energy figure
figure;
plot(sa.var_graph, sa.eLegMech); hold on;
plot(sa.var_graph, sa.eAnkleMech);
legend('Leg mechanical','Ankle mechanical')

% figure; plot(s.var_graph,s.groundedRunMeasure); ylabel('Time in air / Time in stance'); xlabel('Apex height')

figure;
yyaxis left
plot(sa.var_graph,sa.groundedRunMeasure); ylabel('Time in air / Time in stance','Color',[0 .447 .741]);
yyaxis right
plot(sa.var_graph,sa.rInitial); ylabel('Touchdown leg length','Color',[.85 .325 .098])
xlabel('Apex Height');
title('Grounded running in actuated SLIP')

figure; subplot(3,1,1)
plot(sa.var_graph,sa.rInitial); hold on; plot(s.var_graph, s.rInitial); 
title('Touchdown leg length as apex height increases')
ylabel('Touchdown leg length'); xlabel('Apex height')
axis([.5,1.35,.55,1.1])
hold on; plot([.92, .92],[.55,1.1], 'LineStyle','--','Color','r', 'LineWidth',1.4)
hold on; plot([1.07, 1.07],[.55,1.1], 'LineStyle','--','Color','r', 'LineWidth',1.4)
legend('With Ankle','Without Ankle')

subplot(3,1,3)
plot(sa.var_graph,sa.eAnkleMech)
ylabel('Energy contribution from ankle')
plot(sa.var_graph,sa.eAnkleMech/(sa.eAnkleMech+sa.eLegMech)*100)
plot(sa.var_graph,sa.eAnkleMech./(sa.eAnkleMech+sa.eLegMech)*100)
title('Ankle energy contribution to total energy of gait, percent')
ylabel('Ankle energy contribution')
xlabel('Apex Height')
hold on; plot([.93, .93],[0,80], 'LineStyle','--','Color','r', 'LineWidth',1.4)
hold on; plot([1.07, 1.07],[0,80], 'LineStyle','--','Color','r', 'LineWidth',1.4)
axis([.5,1.35,0,80])

subplot(3,1,2)
plot(sa.var_graph,sa.rFinal); hold on; plot(s.var_graph, s.rFinal); 
title('Liftoff leg length as apex height increases')
ylabel('Liftoff leg length'); xlabel('Apex height')
axis([.5,1.35,.55,1.1])
hold on; plot([.92, .92],[.55,1.1], 'LineStyle','--','Color','r', 'LineWidth',1.4)
hold on; plot([1.07, 1.07],[.55,1.1], 'LineStyle','--','Color','r', 'LineWidth',1.4)
legend('With Ankle','Without Ankle')




figure;
subplot(2,1,2)
plot(sa.var_graph,sa.eAnkleMech./(sa.eAnkleMech+sa.eLegMech)*100)
title('Ankle energy contribution to total energy of gait, percent')
ylabel('Ankle energy contribution')
xlabel('Apex Height')
hold on; plot([.93, .93],[0,80], 'LineStyle','--','Color','r', 'LineWidth',1.4)
hold on; plot([1.07, 1.07],[0,80], 'LineStyle','--','Color','r', 'LineWidth',1.4)
axis([.5,1.35,0,80])

subplot(2,1,1)
plot(sa.var_graph,sa.groundedRunMeasure); ylabel('Time in air / Time in stance');
hold on; plot(s.var_graph,s.groundedRunMeasure); 
xlabel('Apex Height')
title('Grounded run measure')
hold on; plot([.93, .93],[0,2.5], 'LineStyle','--','Color','r', 'LineWidth',1.4)
hold on; plot([1.07, 1.07],[0,2.5], 'LineStyle','--','Color','r', 'LineWidth',1.4)
axis([.5,1.35,0,2.5])
legend('With ankle', 'Without ankle')

figure
q= sa;
subplot(1,2,1)
a = 9; b=213;
for i = a:b
%     pause
    plot(q.res{i}.t./q.res{i}.t(end),q.res{i}.r,'Color',[1-i/b, i/b, 0]);
    [q.res{i}.param(12), i];
    if round(q.res{i}.param(12),3) == .93
        plot(q.res{i}.t./q.res{i}.t(end),q.res{i}.r,'LineStyle','--','Color','r', 'LineWidth',1.4);
    end
    hold on
end
axis([0 1 .5 1.01])
xlabel('Normalized stance time')
ylabel('Leg length through stance')
title('Grounded running')

subplot(1,2,2)
a = 214; b=380;
for i = a:b
%     pause
    plot(q.res{i}.t./q.res{i}.t(end),q.res{i}.r,'Color',[0, 1-(i-a)/(b-a), (i-a)/(b-a)]);
    [q.res{i}.param(12), i];
    if round(q.res{i}.param(12),3) == 1.07
        plot(q.res{i}.t./q.res{i}.t(end),q.res{i}.r,'LineStyle','--','Color','r', 'LineWidth',1.4);
    end
    hold on
end
axis([0 1 .5 1.01])
xlabel('Normalized stance time')
ylabel('Leg length through stance')
title('Running with flight')

i1 = 9;
i2 = 210;
    



%Cost of transport graph
figure; subplot(2,1,1)
plot(sa.var_graph, sa.cost_graph); hold on;
plot(s.var_graph, s.cost_graph);
legend('With ankle','Without ankle')
title('Cost of transport comparison')
ylabel('Cost of transport')
xlabel('Apex Height')

subplot(2,1,2)
[sVarU, su] = unique(s.var_graph);
sCost = s.cost_graph(su);
[saVarU, sau] = unique(sa.var_graph);
saCost = sa.cost_graph(sau);

nu = 100*(sCost - saCost(1:length(sVarU)))./sCost;
plot(sVarU, nu)
title('Energy efficiency increase by using ankle')
ylabel('Percent efficiceny increase'); xlabel('Apex Velocity')