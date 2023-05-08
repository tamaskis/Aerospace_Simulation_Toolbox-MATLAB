%% TEST_kinematics.m
% Aerospace Simulation Toolbox
%
% Unit testing of the rv2w, skew2vec, and vec2skew functions.
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

% clears Workspace and closes all figures
clear; close all;



%% INITIALIZE TEST SUITE

test_suite = TestSuite('kinematics tests');



%% skew2vec

a = [1;2;3];
ax = [0,-3,2;3,0,-1;-2,1,0];
test_suite.add_test(TestEqual(skew2vec(ax),a,'skew2vec'));



%% vec2skew

a = [1;2;3];
ax = [0,-3,2;3,0,-1;-2,1,0];
test_suite.add_test(TestEqual(vec2skew(a),ax,'vec2skew'));



%% RUNS TEST SUITE

test_suite.run;