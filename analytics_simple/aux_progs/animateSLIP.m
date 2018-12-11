function animateSLIP(opt)
    f = stance2Full(opt);
    f.theta = [linspace(pi/2,atan2(f.y(f.stanceStartN), f.x(f.stanceStartN)),f.stanceStartN),...
           atan2(f.y(f.stanceStartN+1:f.stanceEndN),f.x(f.stanceStartN+1:f.stanceEndN)),...
           linspace(atan2(f.y(f.stanceEndN),f.x(f.stanceEndN)),pi/2,length(f.t)-f.stanceEndN)];
    %interpolate for smooth animation
    names = {'x','y','theta','xcop','r0','ddr0','Tankle','r'};
    newTime = linspace(0,f.t(end),50);
    s =f; clear f;
    for i = 1:numel(names)
        s.(names{i}) = interp1(s.t,s.(names{i}),newTime);
    end
    %
    clear opt

    k = s.param(strcmp(s.collParam.modelParamList, 'k'));
    c = s.param(strcmp(s.collParam.modelParamList, 'c'));
    transmission = s.param(strcmp(s.collParam.modelParamList, 'transmission'));
    transmission_ankle = s.param(strcmp(s.collParam.modelParamList, 'transmission_ankle'));
    lf = s.param(strcmp(s.collParam.modelParamList, 'lf'));
    xcop = s.xcop;
    leg_angle = s.theta - pi/2;
    
    %X Y Animation
%     slipbodyanimate=figure('Name','Slip body animation','pos',[1921,0,1921,1000]);
    slipbodyanimate=figure('Name','Slip body animation');
    figure(slipbodyanimate);
    ax1 = subplot(1,7,[1 2 3 4 5 6]);
    ax1.XLim = [-.8 .8];
    ax1.YLim = [-.1 1.5];
%     axis equal

    %apex height line
    
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
%     title('X Y SLIP')
    
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
    %Quiver arrow for ankle
    quivA = quiver(1,1,2,2);
    quivA.LineWidth = 2.5; quivA.AutoScale = 'off';
    quivA.MaxHeadSize = 25; quivA.Color = 'b';

    %Quiver arrow for leg
    quivL = quiver(1,1,2,2);
    quivL.LineWidth = 2.5; quivL.AutoScale = 'off';
    quivL.MaxHeadSize = 25; quivL.Color = 'k';
    legend([quivA, quivL],'Force from ankle torque','Acceleration of leg extension', 'location', 'northwest')
    
    
    %     %R0 animation
    ax2 = subplot(1,7,7);
    ax2.XLim = [-.1 .1];
    ax2.YLim = [min(s.r0), max(s.r0)] + .01 * [-min(s.r0), max(s.r0)];
    tx = [-.1 .1 .1];
    ty = 0 + (max(s.r0) - min(s.r0)) * [0 -.1 .1];
    r0_p = patch(tx,ty,'red');
    tf_r0 = hgtransform('Parent',ax2);
    set(r0_p, 'Parent', tf_r0)
%     title('\textbf{text}','interpreter','latex','fontsize',24)
    title('$r_0$','Interpreter','latex','fontsize',24)
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
            
            Tr0 = makehgtform('translate',[0,s.r0(i),0]);
            set(tf_r0,'Matrix',Tr0);
            
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
end
