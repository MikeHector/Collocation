classdef opt
    %OPT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        x
        y
        r0
        dx
        dy
        dr0
        ddr0
        Tankle
        Tstance
        t
        param
        collParam
        r
        cost
        X
        seeParam
        dr
        Fleg
        xcop
        Fankle
    end
    
    methods
        function opt = init(opt, seedName)
            %OPT Construct an instance of this class
            %   Take a seed name, load that seed
            opt_temp = load(seedName);
            opt = opt_temp.opt; clear opt_temp;
        end
        
%         function outputArg = method1(obj,inputArg)
%             %METHOD1 Summary of this method goes here
%             %   Detailed explanation goes here
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end

