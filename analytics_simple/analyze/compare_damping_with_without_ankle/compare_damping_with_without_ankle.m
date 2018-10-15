run col_analysis_damping
close all;
ankle = results_sorted_var;
clearvars -except ankle
run col_analysis_damping_no_ankle
close all;
noAnkle = results_sorted_var;
clearvars -except ankle noAnkle

loInd = ankle{23}.collParam.Nstance;
for i = 1:numel(noAnkle)
    ankleTDA(i) = atan2(ankle{i}.y(1), ankle{i}.x(1));
    noAnkleTDA(i) = atan2(noAnkle{i}.y(1), noAnkle{i}.x(1));
    ankleLOA(i) = atan2(ankle{i}.y(loInd), ankle{i}.x(loInd));
    noAnkleLOA(i) = atan2(ankle{i}.y(loInd), ankle{i}.x(loInd));
    ankleStanceT(i) = ankle{i}.Tstance;
    noAnkleStanceT(i) = noAnkle{i}.Tstance;
    ankleC(i) = ankle{i}.param(2);
    noAnkleC(i) = noAnkle{i}.param(2);
    ankleMaxT(i) = max(ankle{i}.Tleg(10:40));
    noAnkleMaxT(i) = max(noAnkle{i}.Tleg(10:40));
    ankleCost(i) = ankle{i}.cost;
    noAnkleCost(i) = noAnkle{i}.cost;
    
    eAnkle = get_energy2(ankle{i},0);
    energyAnkle.leg_e(i) = eAnkle.leg_e;
    energyAnkle.leg_m(i) = eAnkle.leg_m;
    energyAnkle.ankle_e(i) = eAnkle.ankle_e;
    energyAnkle.ankle_me(i) = eAnkle.ankle_m;
    
    eNoAnkle = get_energy2(noAnkle{i},0);
    energyNoAnkle.leg_e(i) = eNoAnkle.leg_e;
    energyNoAnkle.leg_m(i) = eNoAnkle.leg_m;
    energyNoAnkle.ankle_e(i) = eNoAnkle.ankle_e;
    energyNoAnkle.ankle_m(i) = eNoAnkle.ankle_m;
    
end
deltaThetaAnkle = ankleTDA - ankleLOA;
deltaThetaNoAnkle = noAnkleTDA - noAnkleLOA;
assert(max(abs(ankleC - noAnkleC)) == 0, 'damping mismatch between ankle and no ankle')


figure
plot(ankleC, ankleTDA); hold on;
plot(ankleC, noAnkleTDA);
xlabel('Damping')
ylabel('Touch down angle')
title('Touch down angle with and without ankle')
legend('With ankle','Without ankle')

figure;
plot(ankleC, ankleStanceT); hold on;
plot(ankleC, noAnkleStanceT);
xlabel('Damping')
ylabel('Stance Time')
title('Stance Time with and without ankle')
legend('With ankle','Without ankle')

figure;
plot(ankleC, ankleMaxT); hold on;
plot(ankleC, noAnkleMaxT);
xlabel('Damping')
ylabel('Peak Torque')
title('Peak Torque with and without ankle')
legend('With ankle','Without ankle')

figure;
plot(ankleC, ankleCost); hold on;
plot(ankleC, noAnkleCost);
xlabel('Damping')
ylabel('Cost')
title('Cost with and without ankle')
legend('With ankle','Without ankle')

figure;
plot(ankleC, deltaThetaAnkle); hold on;
plot(ankleC, deltaThetaNoAnkle);
xlabel('Damping')
ylabel('Theta')
title('Difference between TD and LO angle with and without ankle')
legend('With ankle','Without ankle')

figure
plot(ankleC, energyAnkle.leg_e); hold on;
plot(ankleC, energyNoAnkle.leg_e);
xlabel('Damping')
ylabel('Leg energy')
title('Leg energy')
hold on;
plot(ankleC, energyAnkle.leg_m); 
plot(ankleC, energyNoAnkle.leg_m);
legend('With ankle electrical', 'Without ankle electrical',...
        'With ankle mechanical', 'Without ankle mechanical')

    
%%
%How does the ankle change the leg torque trajectories
c = 30;
maxXzero = MikeMax(3);
noAnkleHk = [noAnkle{c}.Tstance/noAnkle{c}.collParam.Nstance * ones([1,noAnkle{c}.collParam.Nstance]),...
          noAnkle{c}.Tflight/noAnkle{c}.collParam.Nflight * ones([1,noAnkle{c}.collParam.Nflight])];

ankleHk = [ankle{c}.Tstance/ankle{c}.collParam.Nstance * ones([1,ankle{c}.collParam.Nstance]),...
          ankle{c}.Tflight/ankle{c}.collParam.Nflight * ones([1,ankle{c}.collParam.Nflight])];
      
noAnklet = noAnkle{c}.t;
noAnkleT = noAnkle{c}.Tleg;
anklet = ankle{c}.t;
ankleT = ankle{c}.Tleg;
noAnkleDr0 = noAnkle{c}.dr0;
ankleDr0 = ankle{c}.dr0;
noAnkleR0 = noAnkle{c}.r0;
ankleR0 = ankle{c}.r0;
transmission = ankle{c}.param(6);

noAnkleMechE = maxXzero(noAnkleT .* transmission .* noAnkleDr0 .* noAnkleHk(1:end-1)');
ankleMechE = maxXzero(ankleT .* transmission .* ankleDr0 .* ankleHk(1:end-1)');

figure; plot(noAnklet, noAnkleMechE); hold on;
plot(anklet, ankleMechE);
xlabel('time')
ylabel('mechanical power');
legend('With ankle', 'Without ankle')

figure; plot(anklet, ankleT); hold on;
plot(noAnklet, noAnkleT);
xlabel('time')
ylabel('Leg torque')
title('Leg torque through bounce')
legend('With ankle','Without ankle')


figure; plot(anklet(1:ankle{c}.collParam.Nstance), ankleDr0(1:ankle{c}.collParam.Nstance)); hold on;
plot(noAnklet(1:ankle{c}.collParam.Nstance), noAnkleDr0(1:ankle{c}.collParam.Nstance));
xlabel('time')
ylabel('Leg torque')
title('dr_0 through bounce')
legend('With ankle','Without ankle')

figure; plot(anklet(1:ankle{c}.collParam.Nstance), ankleR0(1:ankle{c}.collParam.Nstance)); hold on;
plot(noAnklet(1:ankle{c}.collParam.Nstance), noAnkleR0(1:ankle{c}.collParam.Nstance));
xlabel('time')
ylabel('Leg torque')
title('r_0 through bounce')
legend('With ankle','Without ankle')

get_energy2(noAnkle{c}, 3);
get_energy2(ankle{c}, 3);

% get_energy2(noAnkle{c}, 2);
% get_energy2(ankle{c}, 2);

