clear; 
varName = 'apex_height';

deltaMdesired = .0006;

lowRange = .9;
highRange = 1.1;

% getMaxDeltaM(lowRange,highRange,varName,1)
% getMesh(lowRange,highRange,varName,1)


%Check if mesh meets minimum criteria

while round(getMaxDeltaM(lowRange,highRange,varName,1),6) > deltaMdesired %The mesh is too sparse
        %Refine the mesh
    for ana = 0:1 %No ankle or ankle
        s = loadResults(varName,ana); %Load no ankle then ankle data
        m = getMesh(lowRange,highRange,varName,ana);

        for i = 1:length(m) %Split the difference
            optLow = 
        
        end
    end
end


function maxDeltaM = getMaxDeltaM(lowRange,highRange, varName, ana)
    %load results
    s = loadResults(varName,ana);
    
    %Truncate to range
    m_temp = s.var_graph(s.var_graph >= lowRange);
    m = m_temp(m_temp <= highRange);
    
    %Find the max
    maxDeltaM = max(diff(m(2:end-1)));
end

function m = getMesh(lowRange,highRange, varName, ana)
    %load results
    s = loadResults(varName,ana);
    
    %Truncate to range
    m_temp = s.var_graph(s.var_graph >= lowRange);
    m = m_temp(m_temp <= highRange);
end
