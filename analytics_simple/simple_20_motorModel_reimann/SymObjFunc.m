function [obj_func,grad_obj] = SymObjFunc(in1,in2)
%SYMOBJFUNC
%    [OBJ_FUNC,GRAD_OBJ] = SYMOBJFUNC(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    01-Nov-2018 10:17:01

R_ankle = in2(:,5);
R_leg = in2(:,4);
c = in2(:,2);
g = in2(:,10);
k = in2(:,3);
m = in2(:,1);
transmission = in2(:,7);
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
x22 = in1(22,:);
x23 = in1(23,:);
x24 = in1(24,:);
x25 = in1(25,:);
t2 = x1-x3;
t3 = x1.^2;
t4 = x4.^2;
t5 = t3+t4;
t6 = 1.0./sqrt(t5);
t7 = x1.*x10;
t8 = x4.*x13;
t9 = t7+t8;
t15 = t6.*t9;
t10 = -t15+x16;
t11 = c.*t10;
t12 = sqrt(t5);
t13 = t12-x7;
t16 = k.*t13;
t14 = t11-t16;
t17 = t14.^2;
t18 = x2.^2;
t19 = x5.^2;
t20 = t18+t19;
t21 = 1.0./sqrt(t20);
t22 = x2.*x11;
t23 = x5.*x14;
t24 = t22+t23;
t31 = t21.*t24;
t25 = -t31+x17;
t26 = c.*t25;
t27 = sqrt(t20);
t28 = t27-x8;
t32 = k.*t28;
t29 = t26-t32;
t30 = 1.0./transmission.^2;
t33 = t29.^2;
t34 = x3.^2;
t35 = x6.^2;
t36 = t34+t35;
t37 = 1.0./sqrt(t36);
t38 = x3.*x12;
t39 = x6.*x15;
t40 = t38+t39;
t46 = t37.*t40;
t41 = -t46+x18;
t42 = c.*t41;
t43 = sqrt(t36);
t44 = t43-x9;
t47 = k.*t44;
t45 = t42-t47;
t48 = t45.^2;
t49 = x22.^2;
t51 = x1.*x13;
t52 = x4.*x10;
t50 = t51-t52;
t53 = transmission_ankle.^2;
t54 = x23.^2;
t56 = x2.*x14;
t57 = x5.*x11;
t55 = t56-t57;
t58 = x24.^2;
t60 = x3.*x15;
t61 = x6.*x12;
t59 = t60-t61;
t62 = 1.0./g;
t63 = 1.0./m;
t64 = 1.0./t5.^2;
t65 = t50.^2;
t66 = t49.*t53.*t64.*t65;
t67 = t66+1.0e-6;
t68 = 1.0./t5;
t69 = t6.*x10;
t70 = 1.0./t5.^(3.0./2.0);
t78 = t9.*t70.*x1;
t71 = t69-t78;
t72 = c.*t71;
t73 = k.*t6.*x1;
t74 = t72+t73;
t75 = x16.^2;
t76 = t17.*t75;
t77 = t76+1.0e-6;
t79 = x3./2.0;
t80 = t2.^2;
t81 = t80+1.0e-6;
t82 = sqrt(t81);
t83 = t82./2.0;
t86 = x1./2.0;
t84 = t79+t83-t86;
t85 = 1.0./t84;
t87 = (t14.*x16)./2.0;
t88 = sqrt(t77);
t89 = t88./2.0;
t90 = R_leg.*t17.*t30;
t91 = t87+t89+t90;
t92 = (t91.*x25)./3.0;
t93 = (t29.*x17)./2.0;
t94 = x17.^2;
t95 = t33.*t94;
t96 = t95+1.0e-6;
t97 = sqrt(t96);
t98 = t97./2.0;
t99 = R_leg.*t30.*t33;
t100 = t93+t98+t99;
t101 = (t100.*x25)./3.0;
t102 = (t45.*x18)./2.0;
t103 = x18.^2;
t104 = t48.*t103;
t105 = t104+1.0e-6;
t106 = sqrt(t105);
t107 = t106./2.0;
t108 = R_leg.*t30.*t48;
t109 = t102+t107+t108;
t110 = (t109.*x25)./3.0;
t111 = R_ankle.*t49;
t112 = sqrt(t67);
t113 = t112./2.0;
t114 = (t50.*t68.*transmission_ankle.*x22)./2.0;
t115 = t111+t113+t114;
t116 = (t115.*x25)./3.0;
t117 = R_ankle.*t54;
t118 = 1.0./t20.^2;
t119 = t55.^2;
t120 = t53.*t54.*t118.*t119;
t121 = t120+1.0e-6;
t122 = sqrt(t121);
t123 = t122./2.0;
t124 = 1.0./t20;
t125 = (t55.*t124.*transmission_ankle.*x23)./2.0;
t126 = t117+t123+t125;
t127 = (t126.*x25)./3.0;
t128 = R_ankle.*t58;
t129 = 1.0./t36.^2;
t130 = t59.^2;
t131 = t53.*t58.*t129.*t130;
t132 = t131+1.0e-6;
t133 = sqrt(t132);
t134 = t133./2.0;
t135 = 1.0./t36;
t136 = (t59.*t135.*transmission_ankle.*x24)./2.0;
t137 = t128+t134+t136;
t138 = (t137.*x25)./3.0;
t139 = t92+t101+t110+t116+t127+t138;
obj_func = t62.*t63.*t85.*t139;
if nargout > 1
    t140 = t21.*x11;
    t141 = 1.0./t20.^(3.0./2.0);
    t146 = t24.*t141.*x2;
    t142 = t140-t146;
    t143 = c.*t142;
    t144 = k.*t21.*x2;
    t145 = t143+t144;
    t147 = t37.*x12;
    t148 = 1.0./t36.^(3.0./2.0);
    t153 = t40.*t148.*x3;
    t149 = t147-t153;
    t150 = c.*t149;
    t151 = k.*t37.*x3;
    t152 = t150+t151;
    t154 = x1.*2.0;
    t155 = t154-x3.*2.0;
    t156 = 1.0./sqrt(t81);
    t157 = (t155.*t156)./4.0;
    t158 = t157-1.0./2.0;
    t159 = 1.0./t84.^2;
    t160 = 1.0./sqrt(t67);
    t161 = 1.0./t5.^3;
    t162 = t6.*x13;
    t168 = t9.*t70.*x4;
    t163 = t162-t168;
    t164 = c.*t163;
    t165 = k.*t6.*x4;
    t166 = t164+t165;
    t167 = 1.0./sqrt(t77);
    t169 = 1.0./sqrt(t121);
    t170 = 1.0./t20.^3;
    t171 = t21.*x14;
    t177 = t24.*t141.*x5;
    t172 = t171-t177;
    t173 = c.*t172;
    t174 = k.*t21.*x5;
    t175 = t173+t174;
    t176 = 1.0./sqrt(t96);
    t178 = 1.0./sqrt(t132);
    t179 = 1.0./t36.^3;
    t180 = t37.*x15;
    t186 = t40.*t148.*x6;
    t181 = t180-t186;
    t182 = c.*t181;
    t183 = k.*t37.*x6;
    t184 = t182+t183;
    t185 = 1.0./sqrt(t105);
    grad_obj = [t62.*t63.*t85.*((x25.*((t160.*(t49.*t50.*t53.*t64.*x13.*2.0-t49.*t53.*t65.*t161.*x1.*4.0))./4.0+(t68.*transmission_ankle.*x13.*x22)./2.0-t50.*t64.*transmission_ankle.*x1.*x22))./3.0-(x25.*((t74.*x16)./2.0+R_leg.*t14.*t30.*t74.*2.0+(t14.*t74.*t75.*t167)./2.0))./3.0)-t62.*t63.*t139.*t158.*t159;t62.*t63.*t85.*((x25.*((t169.*(t53.*t54.*t55.*t118.*x14.*2.0-t53.*t54.*t119.*t170.*x2.*4.0))./4.0+(t124.*transmission_ankle.*x14.*x23)./2.0-t55.*t118.*transmission_ankle.*x2.*x23))./3.0-(x25.*((t145.*x17)./2.0+R_leg.*t29.*t30.*t145.*2.0+(t29.*t94.*t145.*t176)./2.0))./3.0);t62.*t63.*t85.*((x25.*((t178.*(t53.*t58.*t59.*t129.*x15.*2.0-t53.*t58.*t130.*t179.*x3.*4.0))./4.0+(t135.*transmission_ankle.*x15.*x24)./2.0-t59.*t129.*transmission_ankle.*x3.*x24))./3.0-(x25.*((t152.*x18)./2.0+R_leg.*t30.*t45.*t152.*2.0+(t45.*t103.*t152.*t185)./2.0))./3.0)+t62.*t63.*t139.*t158.*t159;-t62.*t63.*t85.*((x25.*((t160.*(t49.*t50.*t53.*t64.*x10.*2.0+t49.*t53.*t65.*t161.*x4.*4.0))./4.0+(t68.*transmission_ankle.*x10.*x22)./2.0+t50.*t64.*transmission_ankle.*x4.*x22))./3.0+(x25.*((t166.*x16)./2.0+R_leg.*t14.*t30.*t166.*2.0+(t14.*t75.*t166.*t167)./2.0))./3.0);-t62.*t63.*t85.*((x25.*((t169.*(t53.*t54.*t55.*t118.*x11.*2.0+t53.*t54.*t119.*t170.*x5.*4.0))./4.0+(t124.*transmission_ankle.*x11.*x23)./2.0+t55.*t118.*transmission_ankle.*x5.*x23))./3.0+(x25.*((t175.*x17)./2.0+R_leg.*t29.*t30.*t175.*2.0+(t29.*t94.*t175.*t176)./2.0))./3.0);-t62.*t63.*t85.*((x25.*((t178.*(t53.*t58.*t59.*t129.*x12.*2.0+t53.*t58.*t130.*t179.*x6.*4.0))./4.0+(t135.*transmission_ankle.*x12.*x24)./2.0+t59.*t129.*transmission_ankle.*x6.*x24))./3.0+(x25.*((t184.*x18)./2.0+R_leg.*t30.*t45.*t184.*2.0+(t45.*t103.*t184.*t185)./2.0))./3.0);(t62.*t63.*t85.*x25.*((k.*x16)./2.0+R_leg.*k.*t14.*t30.*2.0+(k.*t14.*t75.*t167)./2.0))./3.0;(t62.*t63.*t85.*x25.*((k.*x17)./2.0+R_leg.*k.*t29.*t30.*2.0+(k.*t29.*t94.*t176)./2.0))./3.0;(t62.*t63.*t85.*x25.*((k.*x18)./2.0+R_leg.*k.*t30.*t45.*2.0+(k.*t45.*t103.*t185)./2.0))./3.0;-t62.*t63.*t85.*((x25.*((c.*t6.*x1.*x16)./2.0+(c.*t6.*t14.*t75.*t167.*x1)./2.0+R_leg.*c.*t6.*t14.*t30.*x1.*2.0))./3.0+(x25.*((t68.*transmission_ankle.*x4.*x22)./2.0+(t49.*t50.*t53.*t64.*t160.*x4)./2.0))./3.0);-t62.*t63.*t85.*((x25.*((c.*t21.*x2.*x17)./2.0+(c.*t21.*t29.*t94.*t176.*x2)./2.0+R_leg.*c.*t21.*t29.*t30.*x2.*2.0))./3.0+(x25.*((t124.*transmission_ankle.*x5.*x23)./2.0+(t53.*t54.*t55.*t118.*t169.*x5)./2.0))./3.0);-t62.*t63.*t85.*((x25.*((c.*t37.*x3.*x18)./2.0+(c.*t37.*t45.*t103.*t185.*x3)./2.0+R_leg.*c.*t30.*t37.*t45.*x3.*2.0))./3.0+(x25.*((t135.*transmission_ankle.*x6.*x24)./2.0+(t53.*t58.*t59.*t129.*t178.*x6)./2.0))./3.0);-t62.*t63.*t85.*((x25.*((c.*t6.*x4.*x16)./2.0+(c.*t6.*t14.*t75.*t167.*x4)./2.0+R_leg.*c.*t6.*t14.*t30.*x4.*2.0))./3.0-(x25.*((t68.*transmission_ankle.*x1.*x22)./2.0+(t49.*t50.*t53.*t64.*t160.*x1)./2.0))./3.0);-t62.*t63.*t85.*((x25.*((c.*t21.*x5.*x17)./2.0+(c.*t21.*t29.*t94.*t176.*x5)./2.0+R_leg.*c.*t21.*t29.*t30.*x5.*2.0))./3.0-(x25.*((t124.*transmission_ankle.*x2.*x23)./2.0+(t53.*t54.*t55.*t118.*t169.*x2)./2.0))./3.0);-t62.*t63.*t85.*((x25.*((c.*t37.*x6.*x18)./2.0+(c.*t37.*t45.*t103.*t185.*x6)./2.0+R_leg.*c.*t30.*t37.*t45.*x6.*2.0))./3.0-(x25.*((t135.*transmission_ankle.*x3.*x24)./2.0+(t53.*t58.*t59.*t129.*t178.*x3)./2.0))./3.0);(t62.*t63.*t85.*x25.*((t167.*(t17.*x16.*2.0+c.*t14.*t75.*2.0))./4.0+(c.*t10)./2.0+(c.*x16)./2.0-(k.*t13)./2.0+R_leg.*c.*t14.*t30.*2.0))./3.0;(t62.*t63.*t85.*x25.*((t176.*(t33.*x17.*2.0+c.*t29.*t94.*2.0))./4.0+(c.*t25)./2.0+(c.*x17)./2.0-(k.*t28)./2.0+R_leg.*c.*t29.*t30.*2.0))./3.0;(t62.*t63.*t85.*x25.*((t185.*(t48.*x18.*2.0+c.*t45.*t103.*2.0))./4.0+(c.*t41)./2.0+(c.*x18)./2.0-(k.*t44)./2.0+R_leg.*c.*t30.*t45.*2.0))./3.0;0.0;0.0;0.0;(t62.*t63.*t85.*x25.*(R_ankle.*x22.*2.0+(t50.*t68.*transmission_ankle)./2.0+(t53.*t64.*t65.*t160.*x22)./2.0))./3.0;(t62.*t63.*t85.*x25.*(R_ankle.*x23.*2.0+(t55.*t124.*transmission_ankle)./2.0+(t53.*t118.*t119.*t169.*x23)./2.0))./3.0;(t62.*t63.*t85.*x25.*(R_ankle.*x24.*2.0+(t59.*t135.*transmission_ankle)./2.0+(t53.*t129.*t130.*t178.*x24)./2.0))./3.0;t62.*t63.*t85.*(t88./6.0+t97./6.0+t106./6.0+t112./6.0+t122./6.0+t133./6.0+(R_ankle.*t49)./3.0+(R_ankle.*t54)./3.0+(R_ankle.*t58)./3.0+(t14.*x16)./6.0+(t29.*x17)./6.0+(t45.*x18)./6.0+(R_leg.*t17.*t30)./3.0+(R_leg.*t30.*t33)./3.0+(R_leg.*t30.*t48)./3.0+(t50.*t68.*transmission_ankle.*x22)./6.0+(t55.*t124.*transmission_ankle.*x23)./6.0+(t59.*t135.*transmission_ankle.*x24)./6.0)];
end
