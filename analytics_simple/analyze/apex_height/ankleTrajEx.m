names = {'ankle_0800','ankle_0960','ankle_115'};
vals = {'0.8', '0.96', '1.15'};
n = numel(names);
figure
for i = 1:n
    subplot(3,1,i)
    load(names{i});
    plot(opt.t, opt.Tankle);
    xlabel('Time of stance')
    ylabel('Ankle Torque')
    title(['Ankle Torque Trajectory for apex height = ', vals{i}, ' m'])
end