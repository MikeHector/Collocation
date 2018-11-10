function [ c, ceq] = pathCon(~, dv, u, Parameters)
%nonlcon This function determines the violation of the constraints
%   Using trapezoidal collocation, the violation of the constraints is
%   determined by plugging in the decision variables into formulated
%   dynamics such that we expect 0. The difference from that and 0 is our
%   violation

    %Names
    x = dv(1,:);
    y = dv(2,:);
    r0 = dv(3,:);
    dx = dv(4,:);
    dy = dv(5,:);
    dr0 = dv(6,:);
    ddr0 = u(1,:);
    Tankle = u(2,:);
    r = sqrt(x.^2 + y.^2);
    dr = (x.*dx + y.*dy)./r;

    %Starting stance constraints
    %Fs starts at 0
    Fleg = Parameters.k * (r0 - r) + Parameters.c * (dr0 - dr);

    %Leg force is bounded
    legForcePos = Fleg - Parameters.fLegMax;
    legForceNeg = Parameters.fLegMin - Fleg;

    %Constraint on length of spring
    rPos = r - Parameters.rMax;
    rNeg = Parameters.rMin - r;


   %Ankle torque bounds
    ankle_bound = Parameters.lf/2 .* Fleg .*...
                  y ./ r;
    Acon1 = Tankle * Parameters.transmission_ankle - ankle_bound;
    Acon2 = -(Tankle * Parameters.transmission_ankle + ankle_bound);

    c = [Acon1'; Acon2'; legForcePos'; legForceNeg'; rPos'; rNeg'];
    
    %Reshape
    c = reshape(c, [size(c,1)*size(c,2),1]);
    ceq = [];
end
