function [] = makeHessianFinal(i_c_eq, i_c_ineq, filename)
%Generate the text for the Hessian file
if exist(filename, 'file') > 0
    delete(filename);
end
diary(filename)
%     disp(['%%%%%%%%%%%%%%%%%%%%%COPY INTO BLANK FUNCTION%%%%%%%%%%%%%%%%%' newline newline])
    disp([   'function H = hessfinal(X,lambda,p)' newline...
        newline,'% Call the hessian energy first' newline...
        'H = zhessenergy(X,p);' newline])

    %Generate the equality constraints
    disp('%Add the Lagrange multipliers * the constraint Hessians')
    disp(['%Equality constraints'])
    for i = 1:i_c_eq
        disp(['H = H + zhessceq',num2str(i),...
              '(X,p) * lambda.eqnonlin(',num2str(i),');']);
    end

    disp([newline,'%Inequality constraints'])
    %Generate the inequality constraints
    for i = 1:i_c_ineq
        disp(['H = H + zhesscineq',num2str(i),...
              '(X,p) * lambda.ineqnonlin(',num2str(i),');']);
    end
    disp([newline 'end'])
diary off
end