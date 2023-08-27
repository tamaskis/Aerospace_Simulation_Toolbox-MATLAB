%% TEST_gravity.m
% Aerospace Simulation Toolbox
%
% Unit testing of the TODO functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-07-12
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

test_suite = TestSuite('gravity unit tests');



%% gravity_coeff_index

test_suite.add_test(TestEqual(gravity_coeff_index(0,0),1,'(n,m) = (0,0)'));
test_suite.add_test(TestEqual(gravity_coeff_index(1,0),2,'(n,m) = (1,0)'));
test_suite.add_test(TestEqual(gravity_coeff_index(1,1),3,'(n,m) = (1,1)'));
test_suite.add_test(TestEqual(gravity_coeff_index(2,0),4,'(n,m) = (2,0)'));
test_suite.add_test(TestEqual(gravity_coeff_index(2,1),5,'(n,m) = (2,1)'));
test_suite.add_test(TestEqual(gravity_coeff_index(2,2),6,'(n,m) = (2,2)'));
test_suite.add_test(TestEqual(gravity_coeff_index(3,0),7,'(n,m) = (3,0)'));
test_suite.add_test(TestEqual(gravity_coeff_index(3,1),8,'(n,m) = (3,1)'));
test_suite.add_test(TestEqual(gravity_coeff_index(3,2),9,'(n,m) = (3,2)'));
test_suite.add_test(TestEqual(gravity_coeff_index(3,3),10,'(n,m) = (3,3)'));
test_suite.add_test(TestEqual(gravity_coeff_index(4,0),11,'(n,m) = (4,0)'));
test_suite.add_test(TestEqual(gravity_coeff_index(120,53),7314,'(n,m) = (120,53)'));


%% RUNS TEST SUITE

test_suite.run;