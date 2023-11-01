%% TEST_kinematics.m
% Aerospace Simulation Toolbox
%
% Unit testing of kinematics functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-09-24
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
test_suite.add_test(TestEqual(add_ang_acc(omega_A2B_B,alpha_A2B_B,omega_B2C_C,alpha_B2C_C,R_B2C),[-1.5344;31.6318;-9.7037],'add_ang_acc test 2'));



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
test_suite.add_test(TestEqual(add_ang_vel(omega_A2B_B,omega_B2C_C,R_B2C),[3.4571;7.2830;8.9144],'add_ang_vel test 3'));



%% forward_transform_acc + reverse_transform_acc

% test #1
a_A2P_A_A = [1;2;3];
v_B2P_B_B = [0;0;0];
r_B2P_B = [0;0;0];
R_A2B = eye(3);
omega_A2B_B = [0;0;0];
alpha_A2B_B = [0;0;0];
a_A2B_A_A = [0;0;0];
a_B2P_B_B = [1;2;3];
test_suite.add_test(TestEqual(forward_transform_acc(a_A2P_A_A,v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A),a_B2P_B_B,'forward_transform_acc test 1'));
test_suite.add_test(TestEqual(reverse_transform_acc(a_B2P_B_B,v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A),a_A2P_A_A,'reverse_transform_acc test 1'));

% test #2
a_A2P_A_A = [1;2;3];
v_B2P_B_B = [0;0;0];
r_B2P_B = [0;0;0];
R_A2B = eye(3);
omega_A2B_B = [0;0;0];
alpha_A2B_B = [0;0;0];
a_A2B_A_A = [1;2;3];
a_B2P_B_B = [0;0;0];
test_suite.add_test(TestEqual(forward_transform_acc(a_A2P_A_A,v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A),a_B2P_B_B,'forward_transform_acc test 2'));
test_suite.add_test(TestEqual(reverse_transform_acc(a_B2P_B_B,v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A),a_A2P_A_A,'reverse_transform_acc test 2'));

% test #3
a_A2P_A_A = [1;2;3];
v_B2P_B_B = [0;0;0];
r_B2P_B = [0;0;0];
R_A2B = eye(3);
omega_A2B_B = [0;0;0];
alpha_A2B_B = [0;0;0];
a_A2B_A_A = [2;3;4];
a_B2P_B_B = [-1;-1;-1];
test_suite.add_test(TestEqual(forward_transform_acc(a_A2P_A_A,v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A),a_B2P_B_B,'forward_transform_acc test 3'));
test_suite.add_test(TestEqual(reverse_transform_acc(a_B2P_B_B,v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A),a_A2P_A_A,'reverse_transform_acc test 3'));

% test #4
a_A2P_A_A = [1;2;3];
v_B2P_B_B = [4;5;6];
r_B2P_B = [7;8;9];
R_A2B = eul2mat_321(pi/3,-5*pi/6,3*pi/4);
omega_A2B_B = [10;11;12];
alpha_A2B_B = [13;14;15];
a_A2B_A_A = [16;17;18];
a_B2P_B_B = [-112.754809471617;42.5477445560671;54.6876840908573];
test_suite.add_test(TestEqual(forward_transform_acc(a_A2P_A_A,v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A),a_B2P_B_B,'forward_transform_acc test 4',12));
test_suite.add_test(TestEqual(reverse_transform_acc(a_B2P_B_B,v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,alpha_A2B_B,a_A2B_A_A),a_A2P_A_A,'reverse_transform_acc test 4',12));



%% forward_transform_vel + reverse_transform_vel

% test #1
v_A2P_A_A = [1;2;3];
r_B2P_B = [0;0;0];
R_A2B = eye(3);
omega_A2B_B = [0;0;0];
v_A2B_A_A = [0;0;0];
v_B2P_B_B = [1;2;3];
test_suite.add_test(TestEqual(forward_transform_vel(v_A2P_A_A,r_B2P_B,R_A2B,omega_A2B_B,v_A2B_A_A),v_B2P_B_B,'forward_transform_vel test 1'));
test_suite.add_test(TestEqual(reverse_transform_vel(v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,v_A2B_A_A),v_A2P_A_A,'reverse_transform_vel test 1'));

% test #2
v_A2P_A_A = [1;2;3];
r_B2P_B = [0;0;0];
R_A2B = eye(3);
omega_A2B_B = [0;0;0];
v_A2B_A_A = [1;2;3];
v_B2P_B_B = [0;0;0];
test_suite.add_test(TestEqual(forward_transform_vel(v_A2P_A_A,r_B2P_B,R_A2B,omega_A2B_B,v_A2B_A_A),v_B2P_B_B,'forward_transform_vel test 2'));
test_suite.add_test(TestEqual(reverse_transform_vel(v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,v_A2B_A_A),v_A2P_A_A,'reverse_transform_vel test 2'));

% test #3
v_A2P_A_A = [1;2;3];
r_B2P_B = [0;0;0];
R_A2B = eye(3);
omega_A2B_B = [0;0;0];
v_A2B_A_A = [2;3;4];
v_B2P_B_B = [-1;-1;-1];
test_suite.add_test(TestEqual(forward_transform_vel(v_A2P_A_A,r_B2P_B,R_A2B,omega_A2B_B,v_A2B_A_A),v_B2P_B_B,'forward_transform_vel test 3'));
test_suite.add_test(TestEqual(reverse_transform_vel(v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,v_A2B_A_A),v_A2P_A_A,'reverse_transform_vel test 3'));

% test #4
v_A2P_A_A = [1;2;3];
r_B2P_B = [4;5;6];
R_A2B = eul2mat_321(pi/3,-5*pi/6,3*pi/4);
omega_A2B_B = [5;6;7];
v_A2B_A_A = [8;9;10];
v_B2P_B_B = [3.78108891324554;7.85561412616466;-10.4790807575999];
test_suite.add_test(TestEqual(forward_transform_vel(v_A2P_A_A,r_B2P_B,R_A2B,omega_A2B_B,v_A2B_A_A),v_B2P_B_B,'forward_transform_vel test 4',13));
test_suite.add_test(TestEqual(reverse_transform_vel(v_B2P_B_B,r_B2P_B,R_A2B,omega_A2B_B,v_A2B_A_A),v_A2P_A_A,'reverse_transform_vel test 4',13));



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



%% rv2omega

r = [1;2;3];
v = [-3;-2;-1];
omega_I2R_I = rv2omega(r,v);
test_suite.add_test(TestEqual(omega_I2R_I,[2/7;-4/7;2/7],'rv2omega'));



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