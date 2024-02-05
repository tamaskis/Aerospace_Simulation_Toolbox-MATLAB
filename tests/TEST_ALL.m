%% TEST_ALL.m
% Aerospace Simulation Toolbox
%
% Runs all unit testing scripts.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-05-07
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% DEPENDENCIES:
%   • Simple Unit Testing Toolbox (https://tamaskis.github.io/Simple_Unit_Testing_Toolbox-MATLAB)
%   • Aerospace Simulation Toolbox (https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/)



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to testing scripts
addpath('test_suites')

% adds path to toolbox
addpath(genpath('../toolbox'));



%% RUNS ALL TESTS

%TEST_angles;
%TEST_gravitation;
TEST_kinematics;
%TEST_orbital_mechanics;
%TEST_rotations;
%TEST_time_scales;
%TEST_time_units;