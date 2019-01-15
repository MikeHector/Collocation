close all; clear;
gifIT = 1;
varName = 'apex_height';
apexH4animation = 1.1;

sa = loadResults('apex_height',1);

s = loadResults('apex_height',0);

ankleUtiltity = 100 * (s.cost_graph - sa.cost_graph) ./ s.cost_graph;

    %X Y Animation
%     slipbodyanimate=figure('Name','Slip body animation','pos',[1921,0,1921,1000]);
    slipbodyanimate=figure('Name','Slip body animation');
    figure(slipbodyanimate);
%     subplot(1,7,[2,3,4,5,6]);
    ax1 = subplot(1,7,[2,3,4,5,6]);
    ax1.XLim = [-1.2 1.2];
    ax1.YLim = [-.5 1.9];
    hold on;
    maxApexH = max(s.var_graph);
%     yaxis = plot([0 0],[0 maxApexH], 'k','LineWidth', 2); hold on; 
    xaxis = plot(ax1,[-maxApexH maxApexH],[0 0], 'k', 'LineWidth', 2);
    t = 0:.001:pi;
    rMax = sa.res{1}.param(23);
    rMaxCircle = plot(ax1,rMax*cos(t),rMax*sin(t),'k--', 'LineWidth', 2);
    
    x = [0.62 0.725];
    y = [0.2 0.4];
    anno = annotation('textarrow',x,y,'String',strjust(['Maximum Possible' newline 'Leg Extension'],'Center'));
    anno.HorizontalAlignment = 'center';
%     axis equal
    
    
    %CoT decrease graph
    subplot(1,7,7);
    au = plot(ankleUtiltity(1:end-50), s.var_graph(1:end-50));
    au.Parent.YLim = ax1.YLim;
    xlabel('% Decrease CoT')
    ylabel('Apex Height')
	title('Ankle Utility');
    au.Parent.YAxisLocation = 'right';
    
    axes(ax1)

    
    
%     zone1 = 2;
%     zone2 = 0;
%     zone3 = 0;
%     zone4 = 0;
optInd = find(round(sa.var_graph,5) == apexH4animation);    
opt = sa.res{optInd};
    
    

f = stance2Full(opt);
    %Fancy theta
%     f.theta = [linspace(pi/2,atan2(f.y(f.stanceStartN), f.x(f.stanceStartN)),f.stanceStartN),...
%            atan2(f.y(f.stanceStartN+1:f.stanceEndN),f.x(f.stanceStartN+1:f.stanceEndN)),...
%            linspace(atan2(f.y(f.stanceEndN),f.x(f.stanceEndN)),pi/2,length(f.t)-f.stanceEndN)];
    %Simple theta
    thetaStance =  atan2(f.y(f.stanceStartN+1:f.stanceEndN),f.x(f.stanceStartN+1:f.stanceEndN));
    f.theta = [thetaStance(1)* ones(1,f.stanceStartN),...
    thetaStance,...
    thetaStance(end) * ones(1,length(f.t)-f.stanceEndN)];
    %interpolate for smooth animation
    names = {'x','y','theta','xcop','r0','ddr0','Tankle','r'};
    deltaTime = .01;
    newTime = linspace(0,f.t(end),round(f.t(end)/deltaTime));
    tdloX = [f.x(f.stanceStartN) f.x(f.stanceEndN)];
    tdloY = [f.y(f.stanceStartN) f.y(f.stanceEndN)];
    s =f; clear f;
    
    for i = 1:numel(names)
        s.(names{i}) = interp1(s.t,s.(names{i}),newTime);
    end

    clear opt

    k = s.param(strcmp(s.collParam.modelParamList, 'k'));
    c = s.param(strcmp(s.collParam.modelParamList, 'c'));
    transmission = s.param(strcmp(s.collParam.modelParamList, 'transmission'));
    transmission_ankle = s.param(strcmp(s.collParam.modelParamList, 'transmission_ankle'));
    lf = s.param(strcmp(s.collParam.modelParamList, 'lf'));
    apexH = s.param(strcmp(s.collParam.modelParamList, 'apex_height'));
    xcop = s.xcop;
    leg_angle = s.theta - pi/2;
    

    %Apex height orb
    axes(au.Parent);
%     theta = linspace(0, 2 * pi, 10);
%     x_c = ankleUtiltity(optInd) + .02 * cos(theta);
%     y_c = apexH + .02 * sin(theta);
hold on;
    apexHOrb = plot(ankleUtiltity(optInd),apexH,'ro','LineWidth', 5, 'MarkerSize',.75);
    axes(ax1);

    %apex height line
    
        %Spring Line
%     x_l = [-.01, .01, .01, -.01];
%     y_l = [0, 0, -s.r(1), -s.r(1)];
    px = [0 0 .05 -.05 .05 0 0]; %px = [px, fliplr(px)];
    py = [0 .3 .4 .6 .8 .9 1.2]; py = [py, fliplr(py)]./1.2;
    px = [px + .01, fliplr(px - .02)];
    
%     px = [.3
    
    sp = patch(px, py, 'blue');
    tf_sp = hgtransform('Parent', ax1);
    set(sp, 'Parent', tf_sp)
%     rline = refline([0 0]);
%     rline.Color = 'r';
%     rline.LineStyle = '--';
%     title('X Y SLIP')
    
    %COM circle
    theta = linspace(0, 2 * pi, 100);
    x_c = 0 + .1 * cos(theta);
    y_c = 0 + .1 * sin(theta);
    com = patch(x_c, y_c, 'red');
    tf_com = hgtransform('Parent', ax1);
    set(com, 'Parent', tf_com)
    
    %Foot
    px = s.param(8)/2*[-1 1 1 -1];
    py = s.param(8)/6*[-.5 -.5 1 1];
    foot = patch(px, py, 'black');
    tf_foot = hgtransform('Parent', ax1);
    set(foot, 'Parent', tf_foot);
    
    
    %TD and LO orbs
    for i = 1:2
        theta = linspace(0, 2 * pi, 10);
        x_c = tdloX(i) + .02 * cos(theta);
        y_c = tdloY(i) + .02 * sin(theta);
        TDLO{i} = patch(x_c, y_c, 'green');
    end


    %Trajectory line
    hold on;
    plot(s.x, s.y, 'b--')
%     
    %Quiver arrow for ankle
    quivA = quiver(1,1,2,2);
    quivA.LineWidth = 2.5; quivA.AutoScale = 'off';
    quivA.MaxHeadSize = 25; quivA.Color = 'b';

    %Quiver arrow for leg
    quivL = quiver(1,1,2,2);
    quivL.LineWidth = 2.5; quivL.AutoScale = 'off';
    quivL.MaxHeadSize = 25; quivL.Color = 'k';
    L = legend([quivA, quivL, TDLO{i}],'Force from ankle torque','Acceleration of leg extension','Touchdown/ liftoff point', 'location', 'northwest');
    
    %Text for time
    timeText = text(0,-.1,['t = ', num2str(round(s.t(1),3)), ' s'],'HorizontalAlignment','center');
%     
%     %     %R0 animation
%     ax2 = subplot(1,7,7);
%     ax2.XLim = [-.1 .1];
%     ax2.YLim = [min(s.r0), max(s.r0)] + .01 * [-min(s.r0), max(s.r0)];
%     tx = [-.1 .1 .1];
%     ty = 0 + (max(s.r0) - min(s.r0)) * [0 -.1 .1];
%     r0_p = patch(tx,ty,'red');
%     tf_r0 = hgtransform('Parent',ax2);
%     set(r0_p, 'Parent', tf_r0)
% %     title('\textbf{text}','interpreter','latex','fontsize',24)
%     title('$r_0$','Interpreter','latex','fontsize',24)
%     %Ankle Force Plot
%     figure(slipbodyanimate)
%     ax11 = subplot(4,4,13);
%     ankleFplot = plot(0,0);
%     ankleF = s.Fankle;
%     ax11.XLim = [min(s.t), max(s.t)];
%     ax11.YLim = [min(ankleF)-.1, max(ankleF)+.1];
%     title('Ankle Force on COM')
% 
%     %COP Animation
%     figure(slipbodyanimate)
%     ax2 = subplot(4,4,2);
%     ax2.XLim = [-.2 .2];
%     ax2.YLim = [-.1 .2];
%     x_foot = [-lf/2, lf/2, lf/2, -lf/2];
%     y_foot = [0, 0, .05, .05];
%     patch(x_foot, y_foot, 'blue') %foot
%     arrowx = .25*[0, .1, 0, -.1];
%     arrowy = .25*[0, -.2, -.1, -.2];
%     arrow = patch(arrowx, arrowy, 'red');
%     arrow_move = @(x_pos) arrowx + x_pos;
%     title('COP')
% 
%     %COP plot
%     figure(slipbodyanimate)
%     ax3 = subplot(4,4,6);
%     cop_plot = plot(0,0);
%     ax3.XLim = [min(s.t), max(s.t)];
%     ax3.YLim = [-lf/2 - .01, lf/2 + .01];
%     cop_ref_upper = refline(ax3, [0, lf/2]); cop_ref_upper.Color = 'r'; cop_ref_upper.LineStyle = '--';
%     cop_ref_lower = refline(ax3, [0, -lf/2]); cop_ref_lower.Color = 'r'; cop_ref_lower.LineStyle = '--';
%     title('COP')
% 
%     %Ankle torque plot
%     figure(slipbodyanimate)
%     ax4 = subplot(4,4,[3,4,7,8]);
%     ankle_torque_plot = plot(0,0);
%     ax4.XLim = [min(s.t), max(s.t)];
%     ax4.YLim = [min(s.Tankle)-.1, max(s.Tankle)+.1];
%     title('Ankle torque trajectory')
% 
%     %Leg animation
%     figure(slipbodyanimate)
%     ax5 = subplot(4,4,[10,14]);
%     leg_anim = plot(0,0);
%     ax5.XLim = [-.3, .3];
%     ax5.YLim = [0, max(s.r0) + .1];
%     
%     %COM circle
%     theta = linspace(0, 2 * pi, 100);
%     x_c = 0 + .1 * cos(theta);
%     y_c = 0 + .1 * sin(theta);
%     circle = patch(x_c, y_c, 'r');
%     new_circle_y = @(y) .1 * sin(theta) + y;
%     
%     %Spring
%     x_l = [-.01, .01, .01, -.01];
%     y_l = [0, 0, 1.4, 1.4];
%     patch(x_l, y_l,'b')
%     title('Spring length animation')
% 
%     %Leg torque plot
%     figure(slipbodyanimate)
%     ax6 = subplot(4,4, [11,12,15,16]);
%     leg_torque_plot = plot(0,0);
%     ax6.XLim = [min(s.t), max(s.t)];
%     ax6.YLim = [min(s.Fleg), max(s.Fleg)];
%     title('Leg Force trajectory')

    for q = 1 %Number of times to play
        for i = 1:length(s.x)
            %Body animation stuff
            
            %Repatch the spring line
%             h(2).Vertices(3:4,2) = -(s.r(i) + 0);
            %HG transform stuff
            Tsp = makehgtform('translate',[s.x(i),s.y(i),0],'zrotate',leg_angle(i)+pi,'scale',[1,s.r(i),1]);
            Tcom = makehgtform('translate',[s.x(i),s.y(i),0]);
            set(tf_sp, 'Matrix', Tsp)
            set(tf_com, 'Matrix', Tcom)
            
%             Tr0 = makehgtform('translate',[0,s.r0(i),0]);
%             set(tf_r0,'Matrix',Tr0);
            
            Tfoot = makehgtform('translate',[s.x(i) - s.r(i)*cos(s.theta(i)), s.y(i) - s.r(i)*sin(s.theta(i)),0]);
            set(tf_foot, 'Matrix', Tfoot);
            
            La = 5;
            quivA.XData = s.x(i) - La* s.Tankle(i) * cos(pi/2+s.theta(i));
            quivA.YData = s.y(i) - La* s.Tankle(i) * sin(pi/2+s.theta(i));
            
            quivA.UData = La* s.Tankle(i) * cos(pi/2+s.theta(i));
            quivA.VData = La* s.Tankle(i) * sin(pi/2+s.theta(i));
            
            
            Ll = .5;
            quivL.XData = s.x(i) - Ll* s.x(i) * s.ddr0(i);
            quivL.YData = s.y(i) - Ll* s.y(i) * s.ddr0(i);
            
            quivL.UData = Ll* s.x(i) * s.ddr0(i);
            quivL.VData = Ll* s.y(i) * s.ddr0(i);

            timeText.String = ['t = ', num2str(round(newTime(i),3)), ' s'];
%             %COP animation
%             %Repatch the arrow                       
%             arrow.Vertices(:,1) = arrow_move(xcop(i));
% 
%             %COP Plot
%             cop_plot.XData = s.t(1:i); 
%             cop_plot.YData = xcop(1:i);
%             
%             %Ankle force plot
%             ankleFplot.XData = s.t(1:i);
%             ankleFplot.YData = ankleF(1:i);
% 
%             %Ankle torque plot
%             ankle_torque_plot.XData = s.t(1:i);
%             ankle_torque_plot.YData = s.Tankle(1:i);
% 
%             %Leg length animation
%             circle.Vertices(:,2) = new_circle_y(s.r0(i));
% 
%             %Leg torque plot
%             leg_torque_plot.XData = s.t(1:i);
%             leg_torque_plot.YData = s.Fleg(1:i);

            drawnow

            if gifIT == 1
                if i == 1
                    filename = 'newGif.gif';
                    gif(filename,'frame',gcf);
                elseif i > 1
                    gif
                end                
            end
            %             pause(.2)
        end
    end
