%% TEST_orbital_mechanics.m
% Aerospace Simulation Toolbox
%
% Unit testing of the TODO functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-08-26
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% DEPENDENCIES:
%   • Simple Unit Testing Toolbox (https://tamaskis.github.io/Simple_Unit_Testing_Toolbox-MATLAB)
%   • Aerospace Simulation Toolbox (https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/)



%% SCRIPT SETUP

% clears Workspace and closes all figures
clear; close all;

% sets random seed
rng(1);



%% INITIALIZE TEST SUITE

test_suite = TestSuite('orbital mechanics tests');


%% a2T

a = 7e6;
mu = 3.986004418e14;
test_suite.add_test(TestEqual(a2T(a,mu),5.828516637686015e3,'a2T'));



%% rot_pqw2rsw

% ν = 0
rot_pqw2rsw_0 = rot_pqw2rsw(0);
rot_pqw2rsw_0_true = [1   0   0;
                      0   1   0;
                      0   0   1];

% ν = π/6
rot_pqw2rsw_pi_6 = rot_pqw2rsw(pi/6);
rot_pqw2rsw_pi_6_true = [ sqrt(3)/2   1/2         0;
                         -1/2         sqrt(3)/2   0;
                          0           0           1];

% ν = π/4
rot_pqw2rsw_pi_4 = rot_pqw2rsw(pi/4);
rot_pqw2rsw_pi_4_true = [ sqrt(2)/2   sqrt(2)/2   0;
                         -sqrt(2)/2   sqrt(2)/2   0;
                          0           0           1];

% ν = π/3
rot_pqw2rsw_pi_3 = rot_pqw2rsw(pi/3);
rot_pqw2rsw_pi_3_true = [ 1/2         sqrt(3)/2   0;
                         -sqrt(3)/2   1/2         0;
                          0           0           1];

% ν = π/2
rot_pqw2rsw_pi_2 = rot_pqw2rsw(pi/2);
rot_pqw2rsw_pi_2_true = [ 0   1   0;
                         -1   0   0;
                          0   0   1];

% ν = 2π/3
rot_pqw2rsw_2pi_3 = rot_pqw2rsw(2*pi/3);
rot_pqw2rsw_2pi_3_true = [-1/2         sqrt(3)/2   0;
                          -sqrt(3)/2  -1/2         0;
                           0           0           1];

% ν = 3π/4
rot_pqw2rsw_3pi_4 = rot_pqw2rsw(3*pi/4);
rot_pqw2rsw_3pi_4_true = [-sqrt(2)/2   sqrt(2)/2   0;
                          -sqrt(2)/2  -sqrt(2)/2   0;
                           0           0           1];

% ν = 5π/6
rot_pqw2rsw_5pi_6 = rot_pqw2rsw(5*pi/6);
rot_pqw2rsw_5pi_6_true = [-sqrt(3)/2   1/2         0;
                          -1/2        -sqrt(3)/2   0;
                           0           0           1];

% ν = π
rot_pqw2rsw_pi = rot_pqw2rsw(pi);
rot_pqw2rsw_pi_true = [-1   0   0;
                        0  -1   0;
                        0   0   1];

% ν = 7π/6
rot_pqw2rsw_7pi_6 = rot_pqw2rsw(7*pi/6);
rot_pqw2rsw_7pi_6_true = [-sqrt(3)/2  -1/2         0;
                           1/2        -sqrt(3)/2   0;
                           0           0           1];

% ν = 5π/4
rot_pqw2rsw_5pi_4 = rot_pqw2rsw(5*pi/4);
rot_pqw2rsw_5pi_4_true = [-sqrt(2)/2  -sqrt(2)/2   0;
                           sqrt(2)/2  -sqrt(2)/2   0;
                           0           0           1];

% ν = 4π/3
rot_pqw2rsw_4pi_3 = rot_pqw2rsw(4*pi/3);
rot_pqw2rsw_4pi_3_true = [-1/2        -sqrt(3)/2   0;
                           sqrt(3)/2  -1/2         0;
                           0           0           1];

% ν = 3π/2
rot_pqw2rsw_3pi_2 = rot_pqw2rsw(3*pi/2);
rot_pqw2rsw_3pi_2_true = [0  -1   0;
                          1   0   0;
                          0   0   1];

% ν = 5π/3
rot_pqw2rsw_5pi_3 = rot_pqw2rsw(5*pi/3);
rot_pqw2rsw_5pi_3_true = [1/2        -sqrt(3)/2   0;
                          sqrt(3)/2   1/2         0;
                          0           0           1];

% ν = 7π/4
rot_pqw2rsw_7pi_4 = rot_pqw2rsw(7*pi/4);
rot_pqw2rsw_7pi_4_true = [sqrt(2)/2  -sqrt(2)/2   0;
                          sqrt(2)/2   sqrt(2)/2   0;
                          0           0           1];

% ν = 11π/6
rot_pqw2rsw_11pi_6 = rot_pqw2rsw(11*pi/6);
rot_pqw2rsw_11pi_6_true = [sqrt(3)/2  -1/2         0;
                           1/2         sqrt(3)/2   0;
                           0           0           1];

% ν = 2π
rot_pqw2rsw_2pi = rot_pqw2rsw(2*pi);
rot_pqw2rsw_2pi_true = [1   0   0;
                        0   1   0;
                        0   0   1];

% adds tests
test_suite.add_test(TestEqual(rot_pqw2rsw_0,rot_pqw2rsw_0_true,'rot_pqw2rsw(0)'));
test_suite.add_test(TestEqual(rot_pqw2rsw_pi_6,rot_pqw2rsw_pi_6_true,'rot_pqw2rsw(π/6)'));
test_suite.add_test(TestEqual(rot_pqw2rsw_pi_4,rot_pqw2rsw_pi_4_true,'rot_pqw2rsw(π/4)'));
test_suite.add_test(TestEqual(rot_pqw2rsw_pi_3,rot_pqw2rsw_pi_3_true,'rot_pqw2rsw(π/3)',15));
test_suite.add_test(TestEqual(rot_pqw2rsw_pi_2,rot_pqw2rsw_pi_2_true,'rot_pqw2rsw(π/2)'));
test_suite.add_test(TestEqual(rot_pqw2rsw_2pi_3,rot_pqw2rsw_2pi_3_true,'rot_pqw2rsw(2π/3)',15));
test_suite.add_test(TestEqual(rot_pqw2rsw_3pi_4,rot_pqw2rsw_3pi_4_true,'rot_pqw2rsw(3π/4)'));
test_suite.add_test(TestEqual(rot_pqw2rsw_5pi_6,rot_pqw2rsw_5pi_6_true,'rot_pqw2rsw(5π/6)'));
test_suite.add_test(TestEqual(rot_pqw2rsw_pi,rot_pqw2rsw_pi_true,'rot_pqw2rsw(π)',15));
test_suite.add_test(TestEqual(rot_pqw2rsw_7pi_6,rot_pqw2rsw_7pi_6_true,'rot_pqw2rsw(7π/6)',15));
test_suite.add_test(TestEqual(rot_pqw2rsw_5pi_4,rot_pqw2rsw_5pi_4_true,'rot_pqw2rsw(5π/4)'));
test_suite.add_test(TestEqual(rot_pqw2rsw_4pi_3,rot_pqw2rsw_4pi_3_true,'rot_pqw2rsw(4π/3)',15));
test_suite.add_test(TestEqual(rot_pqw2rsw_3pi_2,rot_pqw2rsw_3pi_2_true,'rot_pqw2rsw(3π/2)',15));
test_suite.add_test(TestEqual(rot_pqw2rsw_5pi_3,rot_pqw2rsw_5pi_3_true,'rot_pqw2rsw(5π/3)',15));
test_suite.add_test(TestEqual(rot_pqw2rsw_7pi_4,rot_pqw2rsw_7pi_4_true,'rot_pqw2rsw(7π/4)',15));
test_suite.add_test(TestEqual(rot_pqw2rsw_11pi_6,rot_pqw2rsw_11pi_6_true,'rot_pqw2rsw(11π/6)',15));
test_suite.add_test(TestEqual(rot_pqw2rsw_2pi,rot_pqw2rsw_2pi_true,'rot_pqw2rsw(2π)',15));



%% rot_rsw2pqw

% ν = 0
rot_rsw2pqw_0 = rot_rsw2pqw(0);
rot_rsw2pqw_0_true = [1   0   0;
                      0   1   0;
                      0   0   1];

% ν = π/6
rot_rsw2pqw_pi_6 = rot_rsw2pqw(pi/6);
rot_rsw2pqw_pi_6_true = [sqrt(3)/2  -1/2         0;
                         1/2         sqrt(3)/2   0;
                         0           0           1];

% ν = π/4
rot_rsw2pqw_pi_4 = rot_rsw2pqw(pi/4);
rot_rsw2pqw_pi_4_true = [sqrt(2)/2  -sqrt(2)/2   0;
                         sqrt(2)/2   sqrt(2)/2   0;
                         0           0           1];

% ν = π/3
rot_rsw2pqw_pi_3 = rot_rsw2pqw(pi/3);
rot_rsw2pqw_pi_3_true = [1/2        -sqrt(3)/2   0;
                         sqrt(3)/2   1/2         0;
                         0           0           1];

% ν = π/2
rot_rsw2pqw_pi_2 = rot_rsw2pqw(pi/2);
rot_rsw2pqw_pi_2_true = [0  -1   0;
                         1   0   0;
                         0   0   1];

% ν = 2π/3
rot_rsw2pqw_2pi_3 = rot_rsw2pqw(2*pi/3);
rot_rsw2pqw_2pi_3_true = [-1/2        -sqrt(3)/2   0;
                           sqrt(3)/2  -1/2         0;
                           0           0           1];

% ν = 3π/4
rot_rsw2pqw_3pi_4 = rot_rsw2pqw(3*pi/4);
rot_rsw2pqw_3pi_4_true = [-sqrt(2)/2  -sqrt(2)/2   0;
                           sqrt(2)/2  -sqrt(2)/2   0;
                           0           0           1];

% ν = 5π/6
rot_rsw2pqw_5pi_6 = rot_rsw2pqw(5*pi/6);
rot_rsw2pqw_5pi_6_true = [-sqrt(3)/2  -1/2         0;
                           1/2        -sqrt(3)/2   0;
                           0           0           1];

% ν = π
rot_rsw2pqw_pi = rot_rsw2pqw(pi);
rot_rsw2pqw_pi_true = [-1   0   0;
                        0  -1   0;
                        0   0   1];

% ν = 7π/6
rot_rsw2pqw_7pi_6 = rot_rsw2pqw(7*pi/6);
rot_rsw2pqw_7pi_6_true = [-sqrt(3)/2   1/2         0;
                          -1/2        -sqrt(3)/2   0;
                           0           0           1];

% ν = 5π/4
rot_rsw2pqw_5pi_4 = rot_rsw2pqw(5*pi/4);
rot_rsw2pqw_5pi_4_true = [-sqrt(2)/2   sqrt(2)/2   0;
                          -sqrt(2)/2  -sqrt(2)/2   0;
                           0           0           1];

% ν = 4π/3
rot_rsw2pqw_4pi_3 = rot_rsw2pqw(4*pi/3);
rot_rsw2pqw_4pi_3_true = [-1/2         sqrt(3)/2   0;
                          -sqrt(3)/2  -1/2         0;
                           0           0           1];

% ν = 3π/2
rot_rsw2pqw_3pi_2 = rot_rsw2pqw(3*pi/2);
rot_rsw2pqw_3pi_2_true = [ 0   1   0;
                          -1   0   0;
                           0   0   1];

% ν = 5π/3
rot_rsw2pqw_5pi_3 = rot_rsw2pqw(5*pi/3);
rot_rsw2pqw_5pi_3_true = [ 1/2         sqrt(3)/2   0;
                          -sqrt(3)/2   1/2         0;
                           0           0           1];

% ν = 7π/4
rot_rsw2pqw_7pi_4 = rot_rsw2pqw(7*pi/4);
rot_rsw2pqw_7pi_4_true = [ sqrt(2)/2   sqrt(2)/2   0;
                          -sqrt(2)/2   sqrt(2)/2   0;
                           0           0           1];

% ν = 11π/6
rot_rsw2pqw_11pi_6 = rot_rsw2pqw(11*pi/6);
rot_rsw2pqw_11pi_6_true = [ sqrt(3)/2   1/2         0;
                           -1/2         sqrt(3)/2   0;
                            0           0           1];

% ν = 2π
rot_rsw2pqw_2pi = rot_rsw2pqw(2*pi);
rot_rsw2pqw_2pi_true = [1   0   0;
                        0   1   0;
                        0   0   1];

% adds tests
test_suite.add_test(TestEqual(rot_rsw2pqw_0,rot_rsw2pqw_0_true,'rot_rsw2pqw(0)'));
test_suite.add_test(TestEqual(rot_rsw2pqw_pi_6,rot_rsw2pqw_pi_6_true,'rot_rsw2pqw(π/6)'));
test_suite.add_test(TestEqual(rot_rsw2pqw_pi_4,rot_rsw2pqw_pi_4_true,'rot_rsw2pqw(π/4)'));
test_suite.add_test(TestEqual(rot_rsw2pqw_pi_3,rot_rsw2pqw_pi_3_true,'rot_rsw2pqw(π/3)',15));
test_suite.add_test(TestEqual(rot_rsw2pqw_pi_2,rot_rsw2pqw_pi_2_true,'rot_rsw2pqw(π/2)'));
test_suite.add_test(TestEqual(rot_rsw2pqw_2pi_3,rot_rsw2pqw_2pi_3_true,'rot_rsw2pqw(2π/3)',15));
test_suite.add_test(TestEqual(rot_rsw2pqw_3pi_4,rot_rsw2pqw_3pi_4_true,'rot_rsw2pqw(3π/4)'));
test_suite.add_test(TestEqual(rot_rsw2pqw_5pi_6,rot_rsw2pqw_5pi_6_true,'rot_rsw2pqw(5π/6)'));
test_suite.add_test(TestEqual(rot_rsw2pqw_pi,rot_rsw2pqw_pi_true,'rot_rsw2pqw(π)',15));
test_suite.add_test(TestEqual(rot_rsw2pqw_7pi_6,rot_rsw2pqw_7pi_6_true,'rot_rsw2pqw(7π/6)',15));
test_suite.add_test(TestEqual(rot_rsw2pqw_5pi_4,rot_rsw2pqw_5pi_4_true,'rot_rsw2pqw(5π/4)'));
test_suite.add_test(TestEqual(rot_rsw2pqw_4pi_3,rot_rsw2pqw_4pi_3_true,'rot_rsw2pqw(4π/3)',15));
test_suite.add_test(TestEqual(rot_rsw2pqw_3pi_2,rot_rsw2pqw_3pi_2_true,'rot_rsw2pqw(3π/2)',15));
test_suite.add_test(TestEqual(rot_rsw2pqw_5pi_3,rot_rsw2pqw_5pi_3_true,'rot_rsw2pqw(5π/3)',15));
test_suite.add_test(TestEqual(rot_rsw2pqw_7pi_4,rot_rsw2pqw_7pi_4_true,'rot_rsw2pqw(7π/4)',15));
test_suite.add_test(TestEqual(rot_rsw2pqw_11pi_6,rot_rsw2pqw_11pi_6_true,'rot_rsw2pqw(11π/6)',15));
test_suite.add_test(TestEqual(rot_rsw2pqw_2pi,rot_rsw2pqw_2pi_true,'rot_rsw2pqw(2π)',15));



%% rv2e_vec

r = [5053;-2276;-5182];
v = [113286;181566;48281];
mu = 3.986004418e14;
e_vec = rv2e_vec(r,v,mu);
e_vec_true = [-0.029973965190951;0.066603000645626;0.068285909115768];
test_suite.add_test(TestEqual(e_vec,e_vec_true,'rv2e_vec',15));



%% rv2e

r = [5053;-2276;-5182];
v = [113286;181566;48281];
mu = 3.986004418e14;
e = rv2e(r,v,mu);
e_true = 0.099986817471288;
test_suite.add_test(TestEqual(e,e_true,'rv2e',15));



%% rv2fpa

% positive
r = [4.1852e7;6.2778e7;10.463e7];
v = [2.5936e4;5.1872e4;0];
phi_fpa = rv2fpa(r,v);
phi_fpa_true = 0.6192;
test_suite.add_test(TestEqual(phi_fpa,phi_fpa_true,'rv2fpa positive',4));

% negative
r = [5053;-2276;-5182];
v = [113286;181566;48281];
phi_fpa = rv2fpa(r,v);
phi_fpa_true = -0.054698152803929;
test_suite.add_test(TestEqual(phi_fpa,phi_fpa_true,'rv2fpa negative',15));



%% rvh2e_vec

r = [5053;-2276;-5182];
v = [113286;181566;48281];
h = [830987456;-831011945;1175291934];
mu = 3.986004418e14;
e_vec = rvh2e_vec(r,v,h,mu);
e_vec_true = [-0.029973965190951;0.066603000645626;0.068285909115768];
test_suite.add_test(TestEqual(e_vec,e_vec_true,'rvh2e_vec',15));



%% rvh2e

r = [5053;-2276;-5182];
v = [113286;181566;48281];
h = [830987456;-831011945;1175291934];
mu = 3.986004418e14;
e = rvh2e(r,v,h,mu);
e_true = 0.099986817471287;
test_suite.add_test(TestEqual(e,e_true,'rvh2e',15));



%% T2a

T = 5400;
mu = 3.986004418e14;
test_suite.add_test(TestEqual(T2a(T,mu),6.652555701327529e6,'T2a'));



%% RUNS TEST SUITE

test_suite.run;