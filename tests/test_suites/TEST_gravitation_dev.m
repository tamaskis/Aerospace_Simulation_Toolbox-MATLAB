%% TEST_gravitation.m
% Aerospace Simulation Toolbox
%
% Unit testing of gravitation functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2024-01-01
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% DEPENDENCIES:
%   • Simple Unit Testing Toolbox (https://tamaskis.github.io/Simple_Unit_Testing_Toolbox-MATLAB)
%   • Aerospace Simulation Toolbox (https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/)



%% SCRIPT SETUP

% clears Workspace and closes all figures
clear; close all;



%% DEV

% read_gfc('../../rawdata/GEM10.gfc');


[V,W] = legendre_recursion([10000000;20000000;30000000],6378136.3,4,4);
length(V)
length(W)