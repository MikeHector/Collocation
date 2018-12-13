function [saveDir] = getSaveDir(TypeZeroForListOfInputs)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if TypeZeroForListOfInputs == 0
        disp('Place -> Input')
        disp('My DRL computer -> DRL-PC')
        disp('My Home computer -> Alluring-PC')
        disp('Michaels DRL computer -> Michael-PC')

    elseif strcmp(TypeZeroForListOfInputs, 'DRL-PC')
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeight50PointNarrowUp';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeight50PointNarrowDown';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeight50Point';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeight50PointCombineBig';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeightNewCoT_30';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeightNewCoT_30_Ends';
        saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeight30pointNewCoT';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\maxLegExtension';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeight_50Point_extend';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexVel_apexHeightFree';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeight50pointCombine';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexHeight50pointCombine2';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults';
%         saveDir = 'C:\Users\DRL-Valkyrie\Google Drive\CollocationResults\apexVel_apexHeightFree';

    elseif strcmp(TypeZeroForListOfInputs, 'Alluring-PC')
%         saveDir = 'D:\Documents\DRL\slip_opt\opt_results\';
        saveDir = 'C:\Users\Mike\Google Drive\CollocationResults';

    elseif strcmp(TypeZeroForListOfInputs, 'Michael-PC')
%         saveDir = 'C:\Users\carda\OneDrive\Pictures\Documents\mikeHectorThings\slip_opt\opt_results\';
        disp('change me')
    end



end

