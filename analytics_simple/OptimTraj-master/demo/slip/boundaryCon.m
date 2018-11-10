function [ c, ceq] = boundaryCon(~, x0, ~, xf, Parameters)
%nonlcon This function determines the violation of the constraints
%   Using trapezoidal collocation, the violation of the constraints is
%   determined by plugging in the decision variables into formulated
%   dynamics such that we expect 0. The difference from that and 0 is our
%   violation

    
    %Names
    stanceEnd = Parameters.N;
    x = [x0(1),xf(1)];
    y = [x0(2),xf(2)];
    r0 = [x0(3),xf(3)];
    dx = [x0(4),xf(4)];
    dy = [x0(5),xf(5)];
    dr0 = [x0(6),xf(6)];
    r = sqrt(x.^2 + y.^2);
    dr = (x.*dx + y.*dy)./r;

    %Starting stance constraints
    %Fs starts at 0
    Fleg = Parameters.k * (r0 - r) + Parameters.c * (dr0 - dr);
    
    %R0 = r @ TD
    ceq = r0(1) - r(1);

    %Apex energies
    initialApexE = 1/2 * Parameters.m * Parameters.apex_velocity.^2 +...
                Parameters.m * Parameters.g * Parameters.apex_height; %Velocity is the same for both with no deltav or deltah

    finalApexE = 1/2 * Parameters.m * (Parameters.apex_velocity + Parameters.deltav).^2 +...
                 Parameters.m * Parameters.g * Parameters.apex_height;

    iTemp = [1, 2];
    startEndE = 1/2 * Parameters.m * ((dx(iTemp)).^2 + dy(iTemp).^2) +...
                Parameters.m * Parameters.g * y(iTemp);
    ceq(end+1:end+2) = startEndE - [initialApexE, finalApexE];

    

    %x - velocity
    ceq(end+1) = dx(1) - Parameters.apex_velocity;
    ceq(end+1) = dx(end) - (Parameters.apex_velocity + Parameters.deltav);

    
    %Ending stance constraints
    %Force in spring is 0
    ceq(end+1) = Fleg(end);

    ceq = ceq';
% %     %Lock the TD angle
%     if C.lockTDA == 1
%         eqCon(end+1) = Parameters.LockTDA .*...
%         (atan2(y(1),x(1)) - (Parameters.baseline_TDA + Parameters.TD_disturb));
%     end
    
    %inequality boundary constraints
    dirYtd = dy(1);
    dirYlo = -dy(end);
    
    c = [dirYtd; dirYlo];

    
end
