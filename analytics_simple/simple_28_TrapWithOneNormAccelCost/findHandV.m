%make a space of apex heights and apex velocities
%use run_col to find the cot at those values
%find the minimum cot

apex_heights = linspace(.9,1,10);
apex_velocities = linspace(.2,.6,10);

m = meshgrid(apex_heights,apex_velocities);

for i = 1:length(apex_heights)
    for j = 1:length(apex_velocities)
        o = RUN_COL(