function Phase = collPhases(phaseOrder, collNs)
    %Make Collocation phases

    Nstart = 1;
    Nend = collNs(1);

    for i = 1:numel(phaseOrder)
        clear ph
        ph.Dyn = phaseOrder{i};
        ph.states = 6;
        ph.cntrl_dof = 2;
        ph.extras = i; %Time of each phase

        if i > 1
            Nstart = Nend;
            Nend = Nend + collNs(i) -1;
        end
        ph.nStart = Nstart;
        ph.nEnd = Nend;     

        Phase{i} = ph; 
    end
end

% Phase{1}
% Phase{2}
% Phase{3}