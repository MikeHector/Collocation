clear; close all;
load('seedC')
ankle = opt;

load('seedCnoAnkle')
noAnkle = opt;

clear opt;

FdAnkle = ankle.param(2) * (ankle.dr0 - ankle.r0);
EdAnkle = .5 * ankle.param(2) * (ankle.dr0 - ankle.r0).^2;

FdNoAnkle = noAnkle.param(2) * (noAnkle.dr0 - noAnkle.r0);
EdNoAnkle = .5 * noAnkle.param(2) * (noAnkle.dr0 - noAnkle.r0).^2;

figure; subplot(2,1,1); plot(ankle.t(1:50), FdAnkle(1:50)); title('Ankle')
subplot(2,1,2); plot(noAnkle.t(1:50), FdNoAnkle(1:50)); title('No Ankle')

figure; subplot(2,1,1); plot(ankle.t(1:50), EdAnkle(1:50)); title('Ankle')
subplot(2,1,2); plot(noAnkle.t(1:50), EdNoAnkle(1:50)); title('No Ankle')