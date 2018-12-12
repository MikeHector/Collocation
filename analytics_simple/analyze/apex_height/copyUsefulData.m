% clear
% load('s');
% 
% % q = {saDown, saUp};
% q = {sDown, sUp};
% 
% destination = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeight50pointCombine2';
% 
% for i = 1:numel(saDown.res)
%     
%     if q{1}.cost_graph(i) <= q{2}.cost_graph(i)
%         lower = 1;
%     elseif q{1}.cost_graph(i) > q{2}.cost_graph(i)
%         lower = 2;
%     end
%     
%     %move
%     copyfile(q{lower}.res{i}.filename, destination)
%     
% end
% 
% %Load data from big 
% clear
% sa = loadResults('apex_height',1);
% 
% s = loadResults('apex_height',0);
% destination = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeightNotMiddle';
% varInd = 12;
% q = {s, sa};
% for i = 1:2
%     for j = 1:numel(q{i}.res)
%         low = (q{i}.res{j}.param(varInd) < .94 );
%         high = (q{i}.res{j}.param(varInd) > .96 );
%         if low || high
%             copyfile(q{i}.res{j}.filename, destination);
% %             q{i}.res{j}.param(varInd)
%         end
%     end
% end
%     
%     
%     
    
    
