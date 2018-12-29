function [c_ineq,c_eq,grad_c_ineq,grad_c_eq] = SymConFunc(in1,in2)
%SYMCONFUNC
%    [C_INEQ,C_EQ,GRAD_C_INEQ,GRAD_C_EQ] = SYMCONFUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    01-Nov-2018 10:31:17

LockTDA = in2(:,19);
TD_disturb = in2(:,18);
apex_height = in2(:,12);
apex_velocity = in2(:,13);
baseline_TDA = in2(:,17);
c = in2(:,2);
deltav = in2(:,14);
fLegMin = in2(:,20);
fLegMax = in2(:,21);
g = in2(:,10);
k = in2(:,3);
lf = in2(:,8);
m = in2(:,1);
rMax = in2(:,23);
rMin = in2(:,22);
transmission_ankle = in2(:,9);
x1 = in1(1,:);
x2 = in1(2,:);
x3 = in1(3,:);
x4 = in1(4,:);
x5 = in1(5,:);
x6 = in1(6,:);
x7 = in1(7,:);
x8 = in1(8,:);
x9 = in1(9,:);
x10 = in1(10,:);
x11 = in1(11,:);
x12 = in1(12,:);
x13 = in1(13,:);
x14 = in1(14,:);
x15 = in1(15,:);
x16 = in1(16,:);
x17 = in1(17,:);
x18 = in1(18,:);
x19 = in1(19,:);
x20 = in1(20,:);
x22 = in1(22,:);
x23 = in1(23,:);
x24 = in1(24,:);
x25 = in1(25,:);
c_ineq = [transmission_ankle.*x22-(lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./2.0;transmission_ankle.*x23-(lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./2.0;transmission_ankle.*x24-(lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2))))./2.0;-transmission_ankle.*x22-(lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./2.0;-transmission_ankle.*x23-(lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./2.0;-transmission_ankle.*x24-(lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2))))./2.0;-fLegMax+c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2));-fLegMax+c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2));-fLegMax+c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2));fLegMin-c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))-k.*(x7-sqrt(x1.^2+x4.^2));fLegMin-c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))-k.*(x8-sqrt(x2.^2+x5.^2));fLegMin-c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))-k.*(x9-sqrt(x3.^2+x6.^2));-rMax+sqrt(x1.^2+x4.^2);-rMax+sqrt(x2.^2+x5.^2);-rMax+sqrt(x3.^2+x6.^2);rMin-sqrt(x1.^2+x4.^2);rMin-sqrt(x2.^2+x5.^2);rMin-sqrt(x3.^2+x6.^2);x13;-x15];
if nargout > 1
    c_eq = [x1-x2+(x10.*x25)./3.0;x4-x5+(x13.*x25)./3.0;x7-x8+(x16.*x25)./3.0;x10-x11+(x25.*((x1.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./m-(transmission_ankle.*x4.*x22)./(m.*(x1.^2+x4.^2))))./3.0;x13-x14+(x25.*(-g+(x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./m+(transmission_ankle.*x1.*x22)./(m.*(x1.^2+x4.^2))))./3.0;x16-x17+(x19.*x25)./3.0;x2-x3+(x11.*x25)./3.0;x5-x6+(x14.*x25)./3.0;x8-x9+(x17.*x25)./3.0;x11-x12+(x25.*((x2.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./m-(transmission_ankle.*x5.*x23)./(m.*(x2.^2+x5.^2))))./3.0;x14-x15+(x25.*(-g+(x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./m+(transmission_ankle.*x2.*x23)./(m.*(x2.^2+x5.^2))))./3.0;x17-x18+(x20.*x25)./3.0;x7-sqrt(x1.^2+x4.^2);apex_velocity.^2.*m.*(-1.0./2.0)+(m.*(x10.^2+x13.^2))./2.0-apex_height.*g.*m+g.*m.*x4;m.*(apex_velocity+deltav).^2.*(-1.0./2.0)+(m.*(x12.^2+x15.^2))./2.0-apex_height.*g.*m+g.*m.*x6;-apex_velocity+x10;-apex_velocity-deltav+x12;c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2));-LockTDA.*(TD_disturb+baseline_TDA-atan2(x4,x1))];
end
if nargout > 2
    grad_c_ineq = reshape([(lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x10.*1.0./sqrt(x1.^2+x4.^2)-x1.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x1.*1.0./sqrt(x1.^2+x4.^2)))./2.0+(lf.*x1.*x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./2.0,0.0,0.0,lf.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))).*(-1.0./2.0)+(lf.*x4.^2.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./2.0+(lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x13.*1.0./sqrt(x1.^2+x4.^2)-x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x4.*1.0./sqrt(x1.^2+x4.^2)))./2.0,0.0,0.0,k.*lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(-1.0./2.0),0.0,0.0,(c.*lf.*x1.*x4)./(x1.^2.*2.0+x4.^2.*2.0),0.0,0.0,(c.*lf.*x4.^2)./(x1.^2.*2.0+x4.^2.*2.0),0.0,0.0,c.*lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(-1.0./2.0),0.0,0.0,0.0,0.0,0.0,transmission_ankle,0.0,0.0,0.0,0.0,(lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x11.*1.0./sqrt(x2.^2+x5.^2)-x2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x2.*1.0./sqrt(x2.^2+x5.^2)))./2.0+(lf.*x2.*x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./2.0,0.0,0.0,lf.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))).*(-1.0./2.0)+(lf.*x5.^2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./2.0+(lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x14.*1.0./sqrt(x2.^2+x5.^2)-x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x5.*1.0./sqrt(x2.^2+x5.^2)))./2.0,0.0,0.0,k.*lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(-1.0./2.0),0.0,0.0,(c.*lf.*x2.*x5)./(x2.^2.*2.0+x5.^2.*2.0),0.0,0.0,(c.*lf.*x5.^2)./(x2.^2.*2.0+x5.^2.*2.0),0.0,0.0,c.*lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(-1.0./2.0),0.0,0.0,0.0,0.0,0.0,transmission_ankle,0.0,0.0,0.0,0.0,(lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(c.*(x12.*1.0./sqrt(x3.^2+x6.^2)-x3.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))+k.*x3.*1.0./sqrt(x3.^2+x6.^2)))./2.0+(lf.*x3.*x6.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2))))./2.0,0.0,0.0,lf.*1.0./sqrt(x3.^2+x6.^2).*(c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2))).*(-1.0./2.0)+(lf.*x6.^2.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2))))./2.0+(lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(c.*(x15.*1.0./sqrt(x3.^2+x6.^2)-x6.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))+k.*x6.*1.0./sqrt(x3.^2+x6.^2)))./2.0,0.0,0.0,k.*lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(-1.0./2.0),0.0,0.0,(c.*lf.*x3.*x6)./(x3.^2.*2.0+x6.^2.*2.0),0.0,0.0,(c.*lf.*x6.^2)./(x3.^2.*2.0+x6.^2.*2.0),0.0,0.0,c.*lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(-1.0./2.0),0.0,0.0,0.0,0.0,0.0,transmission_ankle,0.0,(lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x10.*1.0./sqrt(x1.^2+x4.^2)-x1.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x1.*1.0./sqrt(x1.^2+x4.^2)))./2.0+(lf.*x1.*x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./2.0,0.0,0.0,lf.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))).*(-1.0./2.0)+(lf.*x4.^2.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./2.0+(lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x13.*1.0./sqrt(x1.^2+x4.^2)-x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x4.*1.0./sqrt(x1.^2+x4.^2)))./2.0,0.0,0.0,k.*lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(-1.0./2.0),0.0,0.0,(c.*lf.*x1.*x4)./(x1.^2.*2.0+x4.^2.*2.0),0.0,0.0,(c.*lf.*x4.^2)./(x1.^2.*2.0+x4.^2.*2.0),0.0,0.0,c.*lf.*x4.*1.0./sqrt(x1.^2+x4.^2).*(-1.0./2.0),0.0,0.0,0.0,0.0,0.0,-transmission_ankle,0.0,0.0,0.0,0.0,(lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x11.*1.0./sqrt(x2.^2+x5.^2)-x2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x2.*1.0./sqrt(x2.^2+x5.^2)))./2.0+(lf.*x2.*x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./2.0,0.0,0.0,lf.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))).*(-1.0./2.0)+(lf.*x5.^2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./2.0+(lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x14.*1.0./sqrt(x2.^2+x5.^2)-x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x5.*1.0./sqrt(x2.^2+x5.^2)))./2.0,0.0,0.0,k.*lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(-1.0./2.0),0.0,0.0,(c.*lf.*x2.*x5)./(x2.^2.*2.0+x5.^2.*2.0),0.0,0.0,(c.*lf.*x5.^2)./(x2.^2.*2.0+x5.^2.*2.0),0.0,0.0,c.*lf.*x5.*1.0./sqrt(x2.^2+x5.^2).*(-1.0./2.0),0.0,0.0,0.0,0.0,0.0,-transmission_ankle,0.0,0.0,0.0,0.0,(lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(c.*(x12.*1.0./sqrt(x3.^2+x6.^2)-x3.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))+k.*x3.*1.0./sqrt(x3.^2+x6.^2)))./2.0+(lf.*x3.*x6.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2))))./2.0,0.0,0.0,lf.*1.0./sqrt(x3.^2+x6.^2).*(c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2))).*(-1.0./2.0)+(lf.*x6.^2.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(c.*(x18-1.0./sqrt(x3.^2+x6.^2).*(x3.*x12+x6.*x15))+k.*(x9-sqrt(x3.^2+x6.^2))))./2.0+(lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(c.*(x15.*1.0./sqrt(x3.^2+x6.^2)-x6.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))+k.*x6.*1.0./sqrt(x3.^2+x6.^2)))./2.0,0.0,0.0,k.*lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(-1.0./2.0),0.0,0.0,(c.*lf.*x3.*x6)./(x3.^2.*2.0+x6.^2.*2.0),0.0,0.0,(c.*lf.*x6.^2)./(x3.^2.*2.0+x6.^2.*2.0),0.0,0.0,c.*lf.*x6.*1.0./sqrt(x3.^2+x6.^2).*(-1.0./2.0),0.0,0.0,0.0,0.0,0.0,-transmission_ankle,0.0,-c.*(x10.*1.0./sqrt(x1.^2+x4.^2)-x1.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))-k.*x1.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,-c.*(x13.*1.0./sqrt(x1.^2+x4.^2)-x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))-k.*x4.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,k,0.0,0.0,-c.*x1.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,-c.*x4.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,c,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-c.*(x11.*1.0./sqrt(x2.^2+x5.^2)-x2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))-k.*x2.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,-c.*(x14.*1.0./sqrt(x2.^2+x5.^2)-x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))-k.*x5.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,k,0.0,0.0,-c.*x2.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,-c.*x5.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,c,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-c.*(x12.*1.0./sqrt(x3.^2+x6.^2)-x3.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))-k.*x3.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,-c.*(x15.*1.0./sqrt(x3.^2+x6.^2)-x6.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))-k.*x6.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,k,0.0,0.0,-c.*x3.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,-c.*x6.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,c,0.0,0.0,0.0,0.0,0.0,0.0,0.0,c.*(x10.*1.0./sqrt(x1.^2+x4.^2)-x1.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x1.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,c.*(x13.*1.0./sqrt(x1.^2+x4.^2)-x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x4.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,-k,0.0,0.0,c.*x1.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,c.*x4.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,-c,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,c.*(x11.*1.0./sqrt(x2.^2+x5.^2)-x2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x2.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,c.*(x14.*1.0./sqrt(x2.^2+x5.^2)-x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x5.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,-k,0.0,0.0,c.*x2.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,c.*x5.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,-c,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,c.*(x12.*1.0./sqrt(x3.^2+x6.^2)-x3.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))+k.*x3.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,c.*(x15.*1.0./sqrt(x3.^2+x6.^2)-x6.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))+k.*x6.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,-k,0.0,0.0,c.*x3.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,c.*x6.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,-c,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x1.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,x4.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x2.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,x5.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x3.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,x6.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-x1.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,-x4.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-x2.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,-x5.*1.0./sqrt(x2.^2+x5.^2),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-x3.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,-x6.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],[25,20]);
end
if nargout > 3
    grad_c_eq = reshape([1.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x25./3.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x10./3.0,0.0,0.0,0.0,1.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x25./3.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x13./3.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x25./3.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x16./3.0,(x25.*((1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./m-(x1.^2.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./m-(x1.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x10.*1.0./sqrt(x1.^2+x4.^2)-x1.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x1.*1.0./sqrt(x1.^2+x4.^2)))./m+(transmission_ankle.*x1.*x4.*x22.*1.0./(x1.^2+x4.^2).^2.*2.0)./m))./3.0,0.0,0.0,x25.*((transmission_ankle.*x22)./(m.*(x1.^2+x4.^2))+(x1.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x13.*1.0./sqrt(x1.^2+x4.^2)-x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x4.*1.0./sqrt(x1.^2+x4.^2)))./m-(transmission_ankle.*x4.^2.*x22.*1.0./(x1.^2+x4.^2).^2.*2.0)./m+(x1.*x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./m).*(-1.0./3.0),0.0,0.0,(k.*x1.*x25.*1.0./sqrt(x1.^2+x4.^2))./(m.*3.0),0.0,0.0,(c.*x1.^2.*x25.*(-1.0./3.0))./(m.*(x1.^2+x4.^2))+1.0,-1.0,0.0,(c.*x1.*x4.*x25.*(-1.0./3.0))./(m.*(x1.^2+x4.^2)),0.0,0.0,(c.*x1.*x25.*1.0./sqrt(x1.^2+x4.^2))./(m.*3.0),0.0,0.0,0.0,0.0,0.0,(transmission_ankle.*x4.*x25.*(-1.0./3.0))./(m.*(x1.^2+x4.^2)),0.0,0.0,(x1.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./(m.*3.0)-(transmission_ankle.*x4.*x22)./(m.*(x1.^2+x4.^2).*3.0),x25.*(-(transmission_ankle.*x22)./(m.*(x1.^2+x4.^2))+(x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x10.*1.0./sqrt(x1.^2+x4.^2)-x1.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x1.*1.0./sqrt(x1.^2+x4.^2)))./m+(transmission_ankle.*x1.^2.*x22.*1.0./(x1.^2+x4.^2).^2.*2.0)./m+(x1.*x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./m).*(-1.0./3.0),0.0,0.0,x25.*(-(1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./m+(x4.^2.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./m+(x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x13.*1.0./sqrt(x1.^2+x4.^2)-x4.*1.0./(x1.^2+x4.^2).^(3.0./2.0).*(x1.*x10+x4.*x13))+k.*x4.*1.0./sqrt(x1.^2+x4.^2)))./m+(transmission_ankle.*x1.*x4.*x22.*1.0./(x1.^2+x4.^2).^2.*2.0)./m).*(-1.0./3.0),0.0,0.0,(k.*x4.*x25.*1.0./sqrt(x1.^2+x4.^2))./(m.*3.0),0.0,0.0,(c.*x1.*x4.*x25.*(-1.0./3.0))./(m.*(x1.^2+x4.^2)),0.0,0.0,(c.*x4.^2.*x25.*(-1.0./3.0))./(m.*(x1.^2+x4.^2))+1.0,-1.0,0.0,(c.*x4.*x25.*1.0./sqrt(x1.^2+x4.^2))./(m.*3.0),0.0,0.0,0.0,0.0,0.0,(transmission_ankle.*x1.*x25)./(m.*(x1.^2+x4.^2).*3.0),0.0,0.0,g.*(-1.0./3.0)+(x4.*1.0./sqrt(x1.^2+x4.^2).*(c.*(x16-1.0./sqrt(x1.^2+x4.^2).*(x1.*x10+x4.*x13))+k.*(x7-sqrt(x1.^2+x4.^2))))./(m.*3.0)+(transmission_ankle.*x1.*x22)./(m.*(x1.^2+x4.^2).*3.0),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,-1.0,0.0,x25./3.0,0.0,0.0,0.0,0.0,0.0,x19./3.0,0.0,1.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x25./3.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x11./3.0,0.0,0.0,0.0,0.0,1.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x25./3.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x14./3.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,-1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x25./3.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,x17./3.0,0.0,(x25.*((1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./m-(x2.^2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./m-(x2.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x11.*1.0./sqrt(x2.^2+x5.^2)-x2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x2.*1.0./sqrt(x2.^2+x5.^2)))./m+(transmission_ankle.*x2.*x5.*x23.*1.0./(x2.^2+x5.^2).^2.*2.0)./m))./3.0,0.0,0.0,x25.*((transmission_ankle.*x23)./(m.*(x2.^2+x5.^2))+(x2.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x14.*1.0./sqrt(x2.^2+x5.^2)-x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x5.*1.0./sqrt(x2.^2+x5.^2)))./m-(transmission_ankle.*x5.^2.*x23.*1.0./(x2.^2+x5.^2).^2.*2.0)./m+(x2.*x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./m).*(-1.0./3.0),0.0,0.0,(k.*x2.*x25.*1.0./sqrt(x2.^2+x5.^2))./(m.*3.0),0.0,0.0,(c.*x2.^2.*x25.*(-1.0./3.0))./(m.*(x2.^2+x5.^2))+1.0,-1.0,0.0,(c.*x2.*x5.*x25.*(-1.0./3.0))./(m.*(x2.^2+x5.^2)),0.0,0.0,(c.*x2.*x25.*1.0./sqrt(x2.^2+x5.^2))./(m.*3.0),0.0,0.0,0.0,0.0,0.0,(transmission_ankle.*x5.*x25.*(-1.0./3.0))./(m.*(x2.^2+x5.^2)),0.0,(x2.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./(m.*3.0)-(transmission_ankle.*x5.*x23)./(m.*(x2.^2+x5.^2).*3.0),0.0,x25.*(-(transmission_ankle.*x23)./(m.*(x2.^2+x5.^2))+(x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x11.*1.0./sqrt(x2.^2+x5.^2)-x2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x2.*1.0./sqrt(x2.^2+x5.^2)))./m+(transmission_ankle.*x2.^2.*x23.*1.0./(x2.^2+x5.^2).^2.*2.0)./m+(x2.*x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./m).*(-1.0./3.0),0.0,0.0,x25.*(-(1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./m+(x5.^2.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./m+(x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x14.*1.0./sqrt(x2.^2+x5.^2)-x5.*1.0./(x2.^2+x5.^2).^(3.0./2.0).*(x2.*x11+x5.*x14))+k.*x5.*1.0./sqrt(x2.^2+x5.^2)))./m+(transmission_ankle.*x2.*x5.*x23.*1.0./(x2.^2+x5.^2).^2.*2.0)./m).*(-1.0./3.0),0.0,0.0,(k.*x5.*x25.*1.0./sqrt(x2.^2+x5.^2))./(m.*3.0),0.0,0.0,(c.*x2.*x5.*x25.*(-1.0./3.0))./(m.*(x2.^2+x5.^2)),0.0,0.0,(c.*x5.^2.*x25.*(-1.0./3.0))./(m.*(x2.^2+x5.^2))+1.0,-1.0,0.0,(c.*x5.*x25.*1.0./sqrt(x2.^2+x5.^2))./(m.*3.0),0.0,0.0,0.0,0.0,0.0,(transmission_ankle.*x2.*x25)./(m.*(x2.^2+x5.^2).*3.0),0.0,g.*(-1.0./3.0)+(x5.*1.0./sqrt(x2.^2+x5.^2).*(c.*(x17-1.0./sqrt(x2.^2+x5.^2).*(x2.*x11+x5.*x14))+k.*(x8-sqrt(x2.^2+x5.^2))))./(m.*3.0)+(transmission_ankle.*x2.*x23)./(m.*(x2.^2+x5.^2).*3.0),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,-1.0,0.0,x25./3.0,0.0,0.0,0.0,0.0,x20./3.0,-x1.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,-x4.*1.0./sqrt(x1.^2+x4.^2),0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,g.*m,0.0,0.0,0.0,0.0,0.0,m.*x10,0.0,0.0,m.*x13,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,g.*m,0.0,0.0,0.0,0.0,0.0,m.*x12,0.0,0.0,m.*x15,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-c.*(x12.*1.0./sqrt(x3.^2+x6.^2)-x3.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))-k.*x3.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,-c.*(x15.*1.0./sqrt(x3.^2+x6.^2)-x6.*1.0./(x3.^2+x6.^2).^(3.0./2.0).*(x3.*x12+x6.*x15))-k.*x6.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,k,0.0,0.0,-c.*x3.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,-c.*x6.*1.0./sqrt(x3.^2+x6.^2),0.0,0.0,c,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-(LockTDA.*x4)./(x1.^2+x4.^2),0.0,0.0,(LockTDA.*x1)./(x1.^2+x4.^2),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],[25,19]);
end
