function feval = Dyn(dv, p)
    x = dv(1,:);
    dx = dv(2,:);
    F = dv(3,:);
    assert(2*p.dof + p.cntrlIn == length(dv))
    
    ddx = F./p.m;
    feval = [dx; ddx];
end