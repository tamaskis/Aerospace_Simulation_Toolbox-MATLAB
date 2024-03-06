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



%% INITIALIZE TEST SUITE

test_suite = TestSuite('gravitation dev unit tests');



%% DEV

% read_gfc('../../rawdata/GEM10.gfc');


[V,W] = legendre_recursion([10000000;20000000;30000000],6378136.3,3,1);
% length(V)
% length(W)

%% legendre_recursion

% executes legendre_recursion function
[V,W] = legendre_recursion([10000000;20000000;30000000],6378136.3,4,4);

% length
test_suite.add_test(TestEqual(length(V),15,'legendre_recursion, square, length(V)'));
test_suite.add_test(TestEqual(length(W),15,'legendre_recursion, square, length(W)'));

% V coefficients
test_suite.add_test(TestEqual(V(grav_model_index(0,0)),0.170462862862472,'legendre_recursion, square, V(0,0)',15));
test_suite.add_test(TestEqual(V(grav_model_index(1,0)),0.0232979008591082,'legendre_recursion, square, V(1,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(1,1)),0.00776596695303608,'legendre_recursion, square, V(1,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(2,0)),0.00229971837307456,'legendre_recursion, square, V(2,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(2,1)),0.0031842254396417,'legendre_recursion, square, V(2,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(2,2)),-0.0031842254396417,'legendre_recursion, square, V(2,2)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,0)),7.25336566570076e-5,'legendre_recursion, square, V(3,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,1)),0.000749514452122414,'legendre_recursion, square, V(3,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,2)),-0.00217600969971024,'legendre_recursion, square, V(3,2)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,3)),-0.00265956741075695,'legendre_recursion, square, V(3,3)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,0)),-3.27695930184524e-5,'legendre_recursion, square, V(4,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,1)),0.00011565738712395,'legendre_recursion, square, V(4,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,2)),-0.000809601709867648,'legendre_recursion, square, V(4,2)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,3)),-0.00254446251672689,'legendre_recursion, square, V(4,3)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,4)),-0.000539734473245098,'legendre_recursion, square, V(4,4)'));

% W coefficients
test_suite.add_test(TestEqual(W(grav_model_index(0,0)),0,'legendre_recursion, square, W(0,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(1,0)),0,'legendre_recursion, square, W(1,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(1,1)),0.0155319339060722,'legendre_recursion, square, W(1,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(2,0)),0,'legendre_recursion, square, W(2,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(2,1)),0.00636845087928341,'legendre_recursion, square, W(2,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(2,2)),0.00424563391952227,'legendre_recursion, square, W(2,2)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,0)),0,'legendre_recursion, square, W(3,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,1)),0.00149902890424483,'legendre_recursion, square, W(3,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,2)),0.00290134626628032,'legendre_recursion, square, W(3,2)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,3)),-0.000483557711046719,'legendre_recursion, square, W(3,3)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,0)),0,'legendre_recursion, square, W(4,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,1)),0.000231314774247899,'legendre_recursion, square, W(4,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,2)),0.0010794689464902,'legendre_recursion, square, W(4,2)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,3)),-0.000462629548495799,'legendre_recursion, square, W(4,3)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,4)),-0.00185051819398319,'legendre_recursion, square, W(4,4)'));

% -----------------
% Non-square tests.
% -----------------

% executes legendre_recursion function
[V,W] = legendre_recursion([10000000;20000000;30000000],6378136.3,3,1);

% length
test_suite.add_test(TestEqual(length(V),10,'legendre_recursion, non-square, length(V)'));
test_suite.add_test(TestEqual(length(W),10,'legendre_recursion, non-square, length(W)'));

% V coefficients
test_suite.add_test(TestEqual(V(grav_model_index(0,0)),0.170462862862472,'legendre_recursion, non-square, V(0,0)',15));
test_suite.add_test(TestEqual(V(grav_model_index(1,0)),0.0232979008591082,'legendre_recursion, non-square, V(1,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(1,1)),0.00776596695303608,'legendre_recursion, non-square, V(1,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(2,0)),0.00229971837307456,'legendre_recursion, non-square, V(2,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(2,1)),0.0031842254396417,'legendre_recursion, non-square, V(2,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(2,2)),0,'legendre_recursion, non-square, V(2,2)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,0)),7.25336566570076e-5,'legendre_recursion, non-square, V(3,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,1)),0.000749514452122414,'legendre_recursion, non-square, V(3,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,2)),0,'legendre_recursion, non-square, V(3,2)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,3)),0,'legendre_recursion, non-square, V(3,3)'));

% W coefficients
test_suite.add_test(TestEqual(W(grav_model_index(0,0)),0,'legendre_recursion, non-square, W(0,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(1,0)),0,'legendre_recursion, non-square, W(1,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(1,1)),0.0155319339060722,'legendre_recursion, non-square, W(1,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(2,0)),0,'legendre_recursion, non-square, W(2,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(2,1)),0.00636845087928341,'legendre_recursion, non-square, W(2,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(2,2)),0,'legendre_recursion, non-square, W(2,2)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,0)),0,'legendre_recursion, non-square, W(3,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,1)),0.00149902890424483,'legendre_recursion, non-square, W(3,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,2)),0,'legendre_recursion, non-square, W(3,2)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,3)),0,'legendre_recursion, non-square, W(3,3)'));

%% RUNS TEST SUITE

test_suite.run;
