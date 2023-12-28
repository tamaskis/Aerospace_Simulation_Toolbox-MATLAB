%% TEST_gravitation.m
% Aerospace Simulation Toolbox
%
% Unit testing of gravitation functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-12-27
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

test_suite = TestSuite('gravitation unit tests');



%% grav_model_index

test_suite.add_test(TestEqual(grav_model_index(0,0),1,'grav_model_index, (n,m) = (0,0)'));
test_suite.add_test(TestEqual(grav_model_index(1,0),2,'grav_model_index, (n,m) = (1,0)'));
test_suite.add_test(TestEqual(grav_model_index(1,1),3,'grav_model_index, (n,m) = (1,1)'));
test_suite.add_test(TestEqual(grav_model_index(2,0),4,'grav_model_index, (n,m) = (2,0)'));
test_suite.add_test(TestEqual(grav_model_index(2,1),5,'grav_model_index, (n,m) = (2,1)'));
test_suite.add_test(TestEqual(grav_model_index(2,2),6,'grav_model_index, (n,m) = (2,2)'));
test_suite.add_test(TestEqual(grav_model_index(3,0),7,'grav_model_index, (n,m) = (3,0)'));
test_suite.add_test(TestEqual(grav_model_index(3,1),8,'grav_model_index, (n,m) = (3,1)'));
test_suite.add_test(TestEqual(grav_model_index(3,2),9,'grav_model_index, (n,m) = (3,2)'));
test_suite.add_test(TestEqual(grav_model_index(3,3),10,'grav_model_index, (n,m) = (3,3)'));
test_suite.add_test(TestEqual(grav_model_index(4,0),11,'grav_model_index, (n,m) = (4,0)'));
test_suite.add_test(TestEqual(grav_model_index(120,53),7314,'grav_model_index, (n,m) = (120,53)'));



%% kaula_norm_vector

% max degree/order of 2
N = [1;
     sqrt(3);
     sqrt(3);
     sqrt(5);
     sqrt(5/3);
     0.5*sqrt(5/3)];
test_suite.add_test(TestEqual(kaula_norm_vector(2),N,'kaula_norm_vector up to degree/order 2'));

% max degree/order of 4
N = [1;
     sqrt(3);
     sqrt(3);
     sqrt(5);
     sqrt(5/3);
     0.5*sqrt(5/3);
     sqrt(7);
     sqrt(7/6);
     0.5*sqrt(7/15);
     (1/6)*sqrt(0.7);
     3;
     3*sqrt(0.1);
     0.5*sqrt(0.2);
     0.5*sqrt(1/70);
     0.125*sqrt(1/35)];
test_suite.add_test(TestEqual(kaula_norm_vector(4),N,'kaula_norm_vector up to degree/order 4'));

% random selected tests up to degree/order 120
N = kaula_norm_vector(2190);

% randomly selected tests
test_suite.add_test(TestEqual(N(grav_model_index(5,0)),kaula_norm_factor_testing(5,0),'kaula_norm_vector for (n,m) = (5,0)'));
test_suite.add_test(TestEqual(N(grav_model_index(5,1)),kaula_norm_factor_testing(5,1),'kaula_norm_vector for (n,m) = (5,1)'));
test_suite.add_test(TestEqual(N(grav_model_index(5,2)),kaula_norm_factor_testing(5,2),'kaula_norm_vector for (n,m) = (5,2)'));
test_suite.add_test(TestEqual(N(grav_model_index(5,3)),kaula_norm_factor_testing(5,3),'kaula_norm_vector for (n,m) = (5,3)'));
test_suite.add_test(TestEqual(N(grav_model_index(5,4)),kaula_norm_factor_testing(5,4),'kaula_norm_vector for (n,m) = (5,4)'));
test_suite.add_test(TestEqual(N(grav_model_index(5,5)),kaula_norm_factor_testing(5,5),'kaula_norm_vector for (n,m) = (5,5)'));
test_suite.add_test(TestEqual(N(grav_model_index(7,6)),kaula_norm_factor_testing(7,6),'kaula_norm_vector for (n,m) = (7,6)'));
test_suite.add_test(TestEqual(N(grav_model_index(7,7)),kaula_norm_factor_testing(7,7),'kaula_norm_vector for (n,m) = (7,7)'));
test_suite.add_test(TestEqual(N(grav_model_index(40,20)),kaula_norm_factor_testing(40,20),'kaula_norm_vector for (n,m) = (40,20)'));
test_suite.add_test(TestEqual(N(grav_model_index(80,80)),kaula_norm_factor_testing(80,80),'kaula_norm_vector for (n,m) = (80,80)',100));
test_suite.add_test(TestEqual(N(grav_model_index(120,100)),7.16557517315382e-201,'kaula_norm_vector for (n,m) = (120,100)',100));
test_suite.add_test(TestEqual(N(grav_model_index(1000,100)),7.11140241518136e-299,'kaula_norm_vector for (n,m) = (1000,100)',313));



%% RUNS TEST SUITE

test_suite.run;



%% TESTING HELPER FUNCTIONS

% testing function
function N_nm = kaula_norm_factor_testing(n,m)
    N_nm = sqrt((factorial(n-m)*(2*n+1)*(2-eq(0,m)))/factorial(n+m));
end