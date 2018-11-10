load('noAnkle10.mat');
ten = opt;
load('noAnkle100.mat');
hun = opt;
load('noAnkle1000.mat'); 
tho = opt;
load('noAnkle10000.mat');
tTho = opt;
load('noAnkleInf.mat');
inf = opt;

s = {ten, hun, tho, tTho, inf};
sTitle = {'10','100', '1000', '10000','inf'};

figure;
for i = 1:numel(s)
    subplot(numel(s),1,i);
    plot(s{i}.t, s{i}.ddr0);
    xlabel('Stance Time'); ylabel('$\ddot{r_0}$','interpreter','latex');
    title(sTitle{i})
    axis([0 .8 -1 1])
    
%     if ~strcomp(sTitle{i},'inf')
%         w = str2num(sTitle{i})
%     else w = inf
    w = str2num(sTitle{i});
    squaredContribution = sum(s{i}.ddr0.^2*mean(diff(s{i}.t))/w)./(s{i}.x(end)-s{i}.x(1));
    p = 100*squaredContribution/s{i}.cost;
    legend(['Contribution to objective function = ',num2str(p), '%'])
end

%10000 seems best
