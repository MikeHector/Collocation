    clear; clc; close all;
    load('noAnkle')
    full = stance2Full(opt);
    s = full; clear opt; clear full;
    s.theta = atan2(s.y, s.x);
    k = s.param(strcmp(s.collParam.modelParamList, 'k'));
    c = s.param(strcmp(s.collParam.modelParamList, 'c'));
    transmission = s.param(strcmp(s.collParam.modelParamList, 'transmission'));
    transmission_ankle = s.param(strcmp(s.collParam.modelParamList, 'transmission_ankle'));
    lf = s.param(strcmp(s.collParam.modelParamList, 'lf'));
    xcop = s.xcop;
    leg_angle = atan2(s.y,s.x) - pi/2;
    
    %X Y Animation
%     slipbodyanimate=figure('Name','Slip body animation','pos',[1921,0,1921,1000]);
    slipbodyanimate=figure('Name','Slip body animation');
    figure(slipbodyanimate);
    ax1 = subplot(1,1,1);
    ax1.XLim = [-.9 .9];
    ax1.YLim = [-.1 1.2];
    axis equal
    
        %Spring Line
%     x_l = [-.01, .01, .01, -.01];
%     y_l = [0, 0, -s.r(1), -s.r(1)];
    px = [0 0 .1 -.1 .1 0 0]; %px = [px, fliplr(px)];
    py = [0 .3 .4 .6 .8 .9 1.2]; py = [py, fliplr(py)]./1.2;
    px = [px + .02, fliplr(px - .02)];
    
    sp = patch(px, py, 'blue');
    tf_sp = hgtransform('Parent', ax1);
    set(sp, 'Parent', tf_sp)
    rline = refline([0 0]);
    rline.Color = 'r';
    rline.LineStyle = '--';
    title('X Y SLIP')
    
    %COM circle
    theta = linspace(0, 2 * pi, 100);
    x_c = 0 + .1 * cos(theta);
    y_c = 0 + .1 * sin(theta);
    com = patch(x_c, y_c, 'red');
    tf_com = hgtransform('Parent', ax1);
    set(com, 'Parent', tf_com)

    %Trajectory line
    hold on;
    plot(s.x, s.y, 'b--')
%     
    %Quiver arrow
    quiv = quiver(1,1,2,2);
    quiv.LineWidth = 2.5; quiv.AutoScale = 'off';
    quiv.MaxHeadSize = 25;

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
            
            
            L = 5;
            quiv.XData = s.x(i) - L* s.Tankle(i) * cos(pi/2+s.theta(i));
            quiv.YData = s.y(i) - L* s.Tankle(i) * sin(pi/2+s.theta(i));
            
            quiv.UData = L* s.Tankle(i) * cos(pi/2+s.theta(i));
            quiv.VData = L* s.Tankle(i) * sin(pi/2+s.theta(i));


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
            pause(.2)


        end
    end
