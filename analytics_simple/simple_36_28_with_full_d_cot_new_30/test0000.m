clear
c = colls;
c = c.initialize;

newVars = [.9777, .845]; %[var1 var2]
c.points.desired{end+1} = newVars; %Add a desired point
c = c.updateSavedColls;