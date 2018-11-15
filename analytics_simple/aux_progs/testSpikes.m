load('noAnkleInf.mat');
%Check whether or not acceleration and velocity makes sense.
figure; plot(opt.t, opt.dr0); hold on; plot(opt.t, opt.ddr0); legend('Velocity','Acceleration')

% From coll constraints
% dr0k+1 - dr0k = .5 ( ddr0k + ddr0k+1) hk
i = 1:opt.collParam.N -1;
LHS = opt.dr0(i+1) - opt.dr0(i);
RHS = .5 * (opt.ddr0(i+1) + opt.ddr0(i)) * opt.Tstance/opt.collParam.N;
disp(['Error in constraints is ' num2str(max(abs(LHS-RHS)))])

% %Test
% opt.ddr0 = opt.t.^2;
% opt.dr0 = 1/3*opt.t.^3 +.5;
% %\Test
subplot(2,2,[1 3]); plot(opt.t, opt.ddr0); title('Acceleration (Control Input), $\ddot{r}_{0}$','Interpreter','latex','fontsize',14);
ylabel('$\ddot{r}_{0}$, $\frac{m}{s^{2}}$','Interpreter','latex','fontsize',14);
% subplot(2,2,1); plot(opt.t, opt.dr0); title('Velocity (from optimizer), $\dot{r}_{0}$','Interpreter','latex','fontsize',14);
% ylabel('$\dot{r}_{0}$, $\frac{m}{s}$','Interpreter','latex','fontsize',14)
%Can I numerically integrate?
%TrapZ integration
dr0EST = opt.dr0(1);
dt = mean(diff(opt.t));
for q = 1:opt.collParam.N-1
    dr0EST(q+1) = dr0EST(q)+.5*(opt.ddr0(q)+opt.ddr0(q+1)) * dt;
end
subplot(2,2,2); plot(opt.t, dr0EST); hold on; plot(opt.t, opt.dr0); legend('integration estimate','optimization result','Location','northwest')
title('Velocity, $\dot{r}_{0}$ when using trapezoidal integration on acceleration','Interpreter','latex','fontsize',14); ylabel('$\dot{r}_{0}$, $\frac{m}{s}$','Interpreter','latex','fontsize',14); xlabel('time')
disp(['Error in forward integration is ' num2str(max(abs(dr0EST - opt.dr0)))])


% % Test
% opt.ddr0 = opt.t.^2;
% opt.dr0 = 1/3*opt.t.^3 +.5;
% % \Test

%Left Riemann sum
dr0EST = opt.dr0(1);
dt = mean(diff(opt.t));
for q = 1:opt.collParam.N-1
    dr0EST(q+1) = dr0EST(q)+ opt.ddr0(q) * dt;
end
subplot(2,2,4); plot(opt.t, dr0EST); hold on; plot(opt.t, opt.dr0); legend('integration estimate','optimization result','Location','northwest')
title('Velocity, $\dot{r}_{0}$ when using implicit Euler integration on acceleration','Interpreter','latex','fontsize',14); ylabel('$\dot{r}_{0}$, $\frac{m}{s}$','Interpreter','latex','fontsize',14); xlabel('time')
disp(['Error in forward integration is ' num2str(max(abs(dr0EST - opt.dr0)))])