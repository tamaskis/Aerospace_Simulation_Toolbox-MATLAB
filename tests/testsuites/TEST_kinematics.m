%% TEST_kinematics.m
% Aerospace Simulation Toolbox
%
% Unit testing of kinematics functions.
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



%% add_ang_acc

% test #1
omega_A2B_B = [0;0;0];
alpha_A2B_B = [0;0;0];
omega_B2C_C = [0;0;0];
alpha_B2C_C = [1;2;3];
R_B2C = eye(3);
test_suite.add_test(TestEqual(add_ang_acc(omega_A2B_B,alpha_A2B_B,omega_B2C_C,alpha_B2C_C,R_B2C),[1;2;3],'add_ang_acc test 1'));

% test #2
omega_A2B_B = [1;2;3];
alpha_A2B_B = [4;5;6];
omega_B2C_C = [7;8;9];
alpha_B2C_C = [1;2;3];
R_B2C = [ 0.3536   0.6124  -0.7071
         -0.4928   0.7645   0.4156
          0.7951   0.2015   0.5721];
test_suite.add_test(TestEqual(add_ang_acc(omega_A2B_B,alpha_A2B_B,omega_B2C_C,alpha_B2C_C,R_B2C),[-1.5344;31.6318;-9.7037],'add_ang_acc test 2',14));



%% add_ang_vel

% test #1
omega_A2B_B = [0;0;0];
omega_B2C_C = [0;0;0];
R_B2C = eye(3);
test_suite.add_test(TestEqual(add_ang_vel(omega_A2B_B,omega_B2C_C,R_B2C),[0;0;0],'add_ang_vel test 1'));

% test #2
omega_A2B_B = [1;2;3];
omega_B2C_C = [4;5;6];
R_B2C = eye(3);
test_suite.add_test(TestEqual(add_ang_vel(omega_A2B_B,omega_B2C_C,R_B2C),[5;7;9],'add_ang_vel test 2'));

% test #3
omega_A2B_B = [1;2;3];
omega_B2C_C = [4;5;6];
R_B2C = [ 0.3536   0.6124  -0.7071
         -0.4928   0.7645   0.4156
          0.7951   0.2015   0.5721];
test_suite.add_test(TestEqual(add_ang_vel(omega_A2B_B,omega_B2C_C,R_B2C),[3.4571;7.2830;8.9144],'add_ang_vel test 3',15));



%% matderiv

% test #1
R_A2B = eye(3);
omega_A2B_B = [0;0;0];
test_suite.add_test(TestEqual(matderiv(R_A2B,omega_A2B_B),[0,0,0;0,0,0;0,0,0],'matderiv test 1'));

% test #2
R_A2B = eye(3);
omega_A2B_B = [1;2;3];
test_suite.add_test(TestEqual(matderiv(R_A2B,omega_A2B_B),[0,3,-2;-3,0,1;2,-1,0],'matderiv test 2'));

% test #3
R_A2B = [ 0.3536   0.6124  -0.7071
         -0.4928   0.7645   0.4156
          0.7951   0.2015   0.5721];
omega_A2B_B = [1;2;3];
test_suite.add_test(TestEqual(matderiv(R_A2B,omega_A2B_B),[-3.0686,1.8905,0.1026;-0.2657,-1.6357,2.6934;1.2000,0.4603,-1.8298],'matderiv test 3',15));



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