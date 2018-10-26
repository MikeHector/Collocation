% MHector
% 8.14.18
% COL analysis
clc; clear; close all
record_video = 0;
if record_video==1
    v=VideoWriter('Apex_velocity','MPEG-4');
    v.FrameRate=5;
    open(v);
end

% {'c', 'apex_velocity', 'disturance_f', 'TD_disturb', 'deltav', 'deltah'}
varName = 'apex_velocity';
varInd = 13;
varmaxplot = 2.4;
varminplot = .2;
energyMax = .35;
plotName = 'Apex Velocity';
cf = pwd; %Path stuff
dirComp = getSaveDir('DRL-PC'); %Change if you're running on a different computer

% dirComp = 'C:\Users\mike-\Google Drive\Collocation\damping_highLegE_lowAnkleE';

dirname = strcat(dirComp, '\opt_', varName, '_simpleA*');
% dirname = strcat(dirComp, 'BaselineDampingN*');
strucc = dir(dirname);
fig = figure;
hold on
subplot(2,2,1); an1 = plot(1,1); hold on; an12 = plot([0 1], 'bo');
axis([0,1, 0, 1.5]); title('Y Height Through Cycle'); xlabel('Normalized Time'); ylabel('Y Displacement');
subplot(2,2,2); an2 = plot(1,1); hold on; an22 = plot(2,2);
axis([0, 1, -5.1, 5.1]); title('Force Trajectory'); xlabel('Normalized Time'); ylabel('Force'); legend('Ankle Force', 'Leg Force', 'Location', 'southwest')
TLmax = refline(0, 5); TLmax.Color = [0.8500 0.3250 0.0980]; TLmax.LineStyle = '--'; TLmax.HandleVisibility = 'off';
TLmin = refline(0, -5); TLmin.Color = [0.8500 0.3250 0.0980]; TLmin.LineStyle = '--'; TLmin.HandleVisibility = 'off';
TAmax = refline(0, 2); TAmax.Color = 'b'; TAmax.LineStyle = '--'; TAmax.HandleVisibility = 'off';
TAmin = refline(0, -2); TAmin.Color = 'b'; TAmin.LineStyle = '--'; TAmin.HandleVisibility = 'off';

subplot(2,2,3); an3 = plot(1,1,'ro'); hold on; an32 = plot(2,2);
axis([varminplot,varmaxplot, 0, energyMax]); xlabel(plotName); ylabel('Cost');
title1 = title('wut');
subplot(2,2,4); an4 = plot(1,1);
axis([0,1, -.07, .07]); xlabel('Normalized Time of Stance'); ylabel('Center of Pressure Position')
COPmax = refline(0, .15/2); COPmax.Color = 'b'; COPmax.LineStyle = '--'; COPmax.HandleVisibility = 'off';
COPmin = refline(0, -.15/2); COPmin.Color = 'b'; COPmin.LineStyle = '--'; COPmin.HandleVisibility = 'off';
title('Center of Pressure Profile Through Stance')

for i = 1:length(strucc)
    filename = strucc(i).name;
    filename = strcat(dirComp, '\', filename);
    load(filename)
    results{i} = opt;
    varr(i) = opt.param(varInd);
    if round(varr(i),3) == 2.3
%         pause
        1+1;
    end
end
[var_sorted,i] = sort(varr);

q=1;
for k = 1:length(i)
    results_sorted_var{k} = results{i(k)};
    flags(k) = results{i(k)}.collParam.flag;
    if results{i(k)}.collParam.flag > 0
        var_graph(q) = results{i(k)}.param(varInd);
        cost_graph(q) = results{i(k)}.cost;
        energy{q} = get_energy2(results{i(k)},0);
        percentLeg(q) = sum([energy{q}.leg_e,energy{q}.leg_m])/ sum([energy{q}.leg_e,energy{q}.leg_m,energy{q}.ankle_e,energy{q}.ankle_m]);
        q = q+1;
    end
end
an32.XData = var_graph;
an32.YData = cost_graph;
% for i = 1:numel(results)
i = 1;
while results_sorted_var{i}.param(varInd) < varmaxplot
    
   if results_sorted_var{i}.collParam.flag > 0
        full = stance2Full(results_sorted_var{i});
        time = results_sorted_var{i}.t / results_sorted_var{i}.t(end);
        leg_response = results_sorted_var{i}.Fleg;
        ankle_response = results_sorted_var{i}.Tankle;
%         xyTraj = getXYplot(results_sorted_var{i},0);
%         x = real(xyTraj.x);
%         y = real(xyTraj.y);
        r = results_sorted_var{i}.r;
        k = results_sorted_var{i}.param(3);
        m = results_sorted_var{i}.param(1);
        c = results_sorted_var{i}.param(2);
        transmission_ankle = results_sorted_var{i}.param(7);
        dr = (results_sorted_var{i}.x .* results_sorted_var{i}.dx +...
            results_sorted_var{i}.y .* results_sorted_var{i}.dy)./ r;
        Fleg = results_sorted_var{i}.Fleg;
        xcop = results_sorted_var{i}.xcop;
        zeta = c/ (2 * sqrt(k * m));
        Fankle =results_sorted_var{i}.Fankle;
%         ankleFStance = ankleF(1:results_sorted_var{i}.collParam.Nstance);
%         thetaCycle = [atan2(results_sorted_var{i}.y(1:results_sorted_var{i}.collParam.Nstance), results_sorted_var{i}.x(1:results_sorted_var{i}.collParam.Nstance)); results_sorted_var{i}.theta(2:end)];
%         thetaNorm = linspace(0,1,length(thetaCycle(1:results_sorted_var{i}.collParam.Nstance)));
        [beginEnd, inOut] = energyInOut(results_sorted_var{i},0);
        disp(num2str(beginEnd));
        disp(num2str(inOut));
        results_sorted_var{i}.collParam.fmincon_stuff.firstorderopt
        
        
        if max(leg_response) > 12
%             pause
        end

        an1.XData = full.t./full.t(end);
        an1.YData = full.y;
        
%         an12.XData = results_sorted_var{i}.t(results_sorted_var{i}.t==results_sorted_var{i}.Tstance)/ results_sorted_var{i}.t(end);
%         an12.YData = results_sorted_var{i}.y(results_sorted_var{i}.t==results_sorted_var{i}.Tstance);
         
%         an12.XData = time;
%         an12.YData = [results_sorted_var{i}.y(1), results_sorted_var{i}.y(end)];

        an2.XData = time;
        an2.YData = Fankle;  
        
        an22.XData = time;
        an22.YData = Fleg; 
        
        an3.XData = results_sorted_var{i}.param(varInd);
        an3.YData = results_sorted_var{i}.cost;
        
%         an4.XData = thetaNorm;
        an4.XData = time;
        an4.YData = xcop;

%         an4.XData = thetaNorm;
%         an4.YData = ankleFStance;
        
%         xdist = results_sorted_var{i}.x(end)-results_sorted_var{i}.x(1)

        drawnow
        title1.String = ['Energy Required when Apex Velocity = ', num2str(results_sorted_var{i}.param(varInd))];
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

legE = []; legM = []; ankleE = []; ankleM = [];
for i = 1:numel(energy)    
    legE = [legE, energy{i}.leg_e];
    legM = [legM, energy{i}.leg_m];
    ankleE = [ankleE, energy{i}.ankle_e];
    ankleM = [ankleM, energy{i}.ankle_m];
end

figure;
plot(var_graph, legE); hold on;
plot(var_graph, legM);
plot(var_graph, ankleE);
plot(var_graph, ankleM);
rl = refline(0, energy{1}.LegEtoStand); rl.LineStyle = '--';
legend('Leg electrical', 'Leg mechanical', 'Ankle electrical', 'Ankle mechanical', 'Energy to stand')

% % GRF/leg length graph
% 
% figure;
% subplot(2,1,1); grf = plot(0,0); xlabel('Normalized Time'); ylabel('GRF Normalized by Weight'); title2 = title('Ground Reaction Force');
% axis([0 1 0 3.2])
% subplot(2,1,2); leglen = plot(0,0); xlabel('Normalized Time'); ylabel('Leg Length'); title('Leg Length Through Stance')
% axis([0 1 0 1.2])
% 
% i = 1;
% while results_sorted_var{i}.param.(varName) < varmaxplot
%     
%    if results_sorted_var{i}.param.flag > 0
%         time = results_sorted_var{i}.t/results_sorted_var{i}.t(end);
%         r = results_sorted_var{i}.r;
%         k = results_sorted_var{i}.param.k;
%         GRF = k* (results_sorted_var{i}.r0 - results_sorted_var{i}.r)/ (results_sorted_var{i}.param.m * results_sorted_var{i}.param.g);
%         
%         grf.XData = time;
%         grf.YData = GRF;
%         title2.String = ['Ground Reaction Forces when ', plotName, ' is ', num2str(results_sorted_var{i}.param.(varName))];
%         
%         leglen.XData = time;
%         leglen.YData = r;
%         drawnow;
%         pause(.05);
%    end
%     i = i + 1;
% end




% q = no;
% time = q.t;
% leg_response = q.Tleg;
% ankle_response = q.Tankle;
% ankleF = q.param.transmission_ankle * ankle_response .*...
%         (q.x .* q.dy -...
%          q.y .* q.dx) ./ q.r.^2;
% figure; subplot(2,2,1); plot(time(1:q.param.Nstance)/time(q.param.Nstance), leg_response(1:q.param.Nstance)); hold on; plot(time(1:q.param.Nstance)/time(q.param.Nstance), ankle_response(1:q.param.Nstance))
% axis([0 1 -1 10]);
% legend('Leg Torque', 'Ankle Torque')
% xlabel('Normalized Stance Time')
% ylabel('Torque')
% title('Torque Trajectory \zeta = 0')
% subplot(2,2,2); plot(time(1:q.param.Nstance)/time(q.param.Nstance),ankleF(1:q.param.Nstance))
% axis([0 1 0 20]);
% title('Force on COM over stance')
% xlabel('Noramlized Stance Time')
% ylabel('Force')
% hold on;
% q = damp;
% time = q.t;
% leg_response = q.Tleg;
% ankle_response = q.Tankle;
% ankleF = q.param.transmission_ankle * ankle_response .*...
%         (q.x .* q.dy -...
%          q.y .* q.dx) ./ q.r.^2;
% subplot(2,2,3); plot(time(1:q.param.Nstance)/time(q.param.Nstance), leg_response(1:q.param.Nstance)); hold on; plot(time(1:q.param.Nstance)/time(q.param.Nstance), ankle_response(1:q.param.Nstance))
% axis([0 1 -1 10]);
% legend('Leg Torque', 'Ankle Torque')
% xlabel('Normalized Stance Time')
% ylabel('Torque')
% title('Torque Trajectory \zeta = 0.05')
% subplot(2,2,4); plot(time(1:q.param.Nstance)/time(q.param.Nstance),ankleF(1:q.param.Nstance))
% axis([0 1 0 20]);
% title('Force on COM over stance')
% xlabel('Noramlized Stance Time')
% ylabel('Force')
