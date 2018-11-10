load('leftReimannRes.mat');
reim.x = opt(1,:);
reim.dx = opt(2,:);
reim.F = opt(3,:);
reim.t = time;

load('trapzRes.mat');
trap.x = opt(1,:);
trap.dx = opt(2,:);
trap.F = opt(3,:);
trap.t = time;

clearvars -except reim trap 

figure; plot(trap.t, trap.F); hold on; plot(reim.t, reim.F);
legend('trap','reim');
