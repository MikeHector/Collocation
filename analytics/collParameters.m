function [v, vList] = collParameters(show)
%This function returns all the parameters needed for the collocation

    %List the pertinient symbols
    s = {'m' 'c' 'k' 'R_leg' 'R_ankle' 'i_motor' 'transmission' 'lf' 'transmission_ankle'...
    'g' 'disturbance_f' 'apex_height' 'apex_velocity' 'deltav' 'dthetaMax' 'xDist' 'baseline_TDA'...
    'TD_disturb' 'LockTDA'};

    for i = 1:numel(s)
    v(i) = sym(s{i},'real');
    end

    vList = [32 40 4000 1.3 9.3 3.65e-04 80 .15 50 9.81 0 1.1 1 0 3 .1 1.7917 0 0];

    if show == 1
    [v' vList' [1:length(s)]'];
    end
end
     
     
     
 