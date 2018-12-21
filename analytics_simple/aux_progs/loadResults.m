function  s = loadResults(varName,ankleOn)
% varLim = [.8 1.2];

switch varName
    case 'apex_height'
        varInd = 12;
    case 'apex_velocity'
        varInd = 13;
    case 'rMax'
        varInd = 23;
end
cf = pwd; %Path stuff
dirComp = getSaveDir('DRL-PC'); %Change if you're running on a different computer

if ankleOn == 1
    dirname = strcat(dirComp, '\opt_', varName, '_simpleA*');
elseif ankleOn == 0
    dirname = strcat(dirComp, '\opt_', varName, '_simpleNoA*');
end
strucc = dir(dirname);

for i = 1:length(strucc)
    filename = strucc(i).name;
    filename = strcat(dirComp, '\', filename);
    load(filename)
    opt.filename = filename;
    results{i} = opt;
    varr(i) = opt.param(varInd);
    
    if round(varr(i),5) == .98
        1+1;
        varr(i);
    end
end
[var_sorted,i] = sort(varr);

q=1;

for k = 1:length(i)
    results_sorted_var{k} = results{i(k)};
    flags(k) = results{i(k)}.collParam.flag;
    if results{i(k)}.collParam.flag > 0
        res{q} = results_sorted_var{k};
        full = stance2Full(results{i(k)});
        s.var_graph(q) = results{i(k)}.param(varInd);
        s.cost_graph(q) = results{i(k)}.cost;
%         s.percentLeg(q) = sum([energy{q}.leg_e,energy{q}.leg_m])/ sum([energy{q}.leg_e,energy{q}.leg_m,energy{q}.ankle_e,energy{q}.ankle_m]);
        s.rInitial(q) = results{i(k)}.r(1);
        s.rFinal(q) = results{i(k)}.r(end);
        s.yInitial(q) = results{i(k)}.y(1);
        s.yFinal(q) = results{i(k)}.y(end);
        s.xInitial(q) = results{i(k)}.x(1);
        s.xFinal(q) = results{i(k)}.x(end);
        s.dyInitial(q) = results{i(k)}.dy(1);
        s.dyFinal(q) = results{i(k)}.dy(end);
        s.fDamperFinal(q) = results{i(k)}.param(2)*(results{i(k)}.dr0(end) -results{i(k)}.dr(end));
        s.fSpringFinal(q) = results{i(k)}.param(3)*(results{i(k)}.r0(end) -results{i(k)}.r(end));
        s.tdA(q) = atan2(results{i(k)}.y(1),results{i(k)}.x(1));
        flightTime = full.apexToGroundTime + full.groundToApexTime;
        s.groundedRunMeasure(q) = flightTime/results{i(k)}.Tstance; %Flight Time / Stance Time
        s.peakGRF(q) = max(results{i(k)}.Fleg);
        energy = get_energy3(results{i(k)});
        s.eLegMech(q) = energy.leg_m;
        s.eAnkleMech(q) = energy.ankle_m;
        s.damper(q) = energy.damper;
%         s.cumIn{q} = energy.cumIn;
%         s.cumOut{q} = energy.cumOut;
        s.deltaRtdLO(q) = results{i(k)}.r(end) - results{i(k)}.r(1);
        s.deltaR0tdLO(q) = results{i(k)}.r0(end) - results{i(k)}.r0(1);
        s.maxPush(q) = max(results{i(k)}.r0) - min(results{i(k)}.r0);
        s.tdCentripedalVel(q) = (results{i(k)}.dx(1).*results{i(k)}.y(1) - results{i(k)}.dy(1) .* results{i(k)}.x(1))./ results{i(k)}.r(1);
        s.tdCentripedalF(q) = results{i(k)}.param(1).*s.tdCentripedalVel(q).^2./results{i(k)}.r(1);        
        xFlight = results{i(k)}.param(13) * (results{i(k)}.dy(end) - results{i(k)}.dy(1))/ results{i(k)}.param(10);
        s.distance(q) = xFlight + results{i(k)}.x(end) - results{i(k)}.x(1);
%         s.apexHeight(q) = results{i(k)}.apexHeight;

        costEst = (energy.leg_m + energy.ankle_m + energy.ringDamp) ./ s.distance(q);
        [s.var_graph(q) s.cost_graph(q) - costEst 100*energy.ringDamp/s.cost_graph(q)];
        s.filename{q} = results{i(k)}.filename;
        q = q+1;
    end
end
s.res = res;
s.varInd = varInd;
end