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

% random selected tests up to degree/order 1000
N = kaula_norm_vector(1000);

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



%% grav_accel

% --------------
% EGM2008 tests.
% --------------

% loads gravitational model
EGM2008 = load_EGM2008;

% extract parameters
mu = EGM2008.mu;
R = EGM2008.R;
C = EGM2008.C;
S = EGM2008.S;

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (10,10)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40619073945194;-8.5014299770321;-4.64141141193325];
g_exp_geo = [-1.40619073945194;-8.50142997703209;-4.64141141193325];
g_act = grav_accel(r_ecef,mu,R,C,S,10,10);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel EGM2008 test #1',14));
test_suite.add_test(TestEqual(g_act,g_exp_geo,'grav_accel EGM2008 test #1 vs. GeographicLib',13));

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (40,40)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40628962068093;-8.50140471638599;-4.64078257142567];
g_exp_geo = [-1.40628962068093;-8.50140471638596;-4.64078257142567];
g_act = grav_accel(r_ecef,mu,R,C,S,40,40);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel EGM2008 test #2',14));
test_suite.add_test(TestEqual(g_act,g_exp_geo,'grav_accel EGM2008 test #2 vs. GeographicLib',13));

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (40,10)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40622816377887;-8.50141193972164;-4.64104122564417];
g_exp_geo = [-1.40622816377887;-8.50141193972162;-4.64104122564417];
g_act = grav_accel(r_ecef,mu,R,C,S,40,10);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel EGM2008 test #3',14));
test_suite.add_test(TestEqual(g_act,g_exp_geo,'grav_accel EGM2008 test #3 vs. GeographicLib',13));

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (120,120)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40651132644688;-8.50064118963623;-4.63994260559607];
g_exp_geo = [-1.40651132644688;-8.50064118963615;-4.63994260559605];
g_act = grav_accel(r_ecef,mu,R,C,S,120,120);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel EGM2008 test #4',14));
test_suite.add_test(TestEqual(g_act,g_exp_geo,'grav_accel EGM2008 test #4 vs. GeographicLib',13));

% EGM2008, tide-free, (lat,lon,alt) = (89.9999°,0°,10000 m), (N,M) = (120,120)
r_ecef = [11.1868512488;0.0000000000;6366752.3142354172];
g_exp = [0.000110167378093474;-3.15305636293367e-5;-9.8015134741633];
g_exp_geo = [0.000110167378093823;-3.15305636293e-5;-9.8015134741633];
g_act = grav_accel(r_ecef,mu,R,C,S,120,120);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel EGM2008 test #5',14));
test_suite.add_test(TestEqual(g_act,g_exp_geo,'grav_accel EGM2008 test #5 vs. GeographicLib',13));

% EGM2008, tide-free, (lat,lon,alt) = (90°,0°,10000 m), (N,M) = (120,120)
r_ecef = [0.0000000000;0.0000000000;6366752.3142451793];
g_exp = [0.000127335598760036;-3.15305796924751e-5;-9.80151347850754];
g_exp_geo = [0.0001273355987601;-3.15305796925e-5;-9.80151347850754];
g_act = grav_accel(r_ecef,mu,R,C,S,120,120);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel EGM2008 test #6',14));
test_suite.add_test(TestEqual(g_act,g_exp_geo,'grav_accel EGM2008 test #6 vs. GeographicLib',14));

% EGM2008, tide-free, (lat,lon,alt) = (85°,-45°,5 m), (N,M) = (80,65)
r_ecef = [394387.0359271481;-394387.0359271481;6332405.8449596651];
g_exp = [-0.607868793518749;0.608020342523899;-9.79454638520474];
g_exp_geo = [-0.607868793518748;0.608020342523899;-9.79454638520476];
g_act = grav_accel(r_ecef,mu,R,C,S,80,65);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel EGM2008 test #7',14));
test_suite.add_test(TestEqual(g_act,g_exp_geo,'grav_accel EGM2008 test #7 vs. GeographicLib',13));

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (2,0)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40623496535577;-8.50146718973369;-4.6415442471915];
g_exp_geo = [-1.40623496535577;-8.50146718973369;-4.6415442471915];
g_act = grav_accel(r_ecef,mu,R,C,S,2,0);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel EGM2008 test #8',14));
test_suite.add_test(TestEqual(g_act,g_exp_geo,'grav_accel EGM2008 test #8 vs. GeographicLib',14));

% ------------
% GEM10 tests.
% ------------
% 
% loads gravitational model
GEM10 = load_GEM10;

% extract parameters
mu = GEM10.mu;
R = GEM10.R;
% mu = 398600.47e9;
% R = 6378139.0;
C = GEM10.C;
S = GEM10.S;

% GEM10 4x4 test
r_ecef = [5489150.0;802222.0;3140916.0];
g_exp = [-8.442606335554723;-1.233932430518343;-4.846524863326083];
g_act = grav_accel(r_ecef,mu,R,C,S,4,4);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel GEM10 test #1',14));


% echo 29.6833313596959 8.31473347702043 2000.66675581597 | Gravity -n egm2008 -N 2 -M 0 -p 16

%% TODO

% % relative error tolerance TODO
% err = 1e-3;
% 
% % TODO
% % These test cases are adapted from Vallado, "Fundamentals of Astrodynamics 
% % and Applications", 4th Ed. (pp. 547, 1040). Note that they use a 
% % different gravity model, hence the error tolerance defined above.
% 
% % load gravity coefficients
% GGM05S = load_GGM05S;
% C_norm = GGM05S.C_norm;
% S_norm = GGM05S.S_norm;
% 
% % de-normalized gravity coefficients
% [C,S] = denormalize_coeffs(C_norm,S_norm);
% 
% % negative of second zonal harmonic should equal J2
% test_suite.add_test(TestEqual(-C(grav_model_index(2,0)),0.00108262617385222),'TODO C(2,0)');

% % n = 4, m = 1
% test_suite.add_test(TestEqual(C(4,1),-5.08643560439584e-7,err),'TODO C(4,1)');
% test_suite.add_test(TestEqual(S(4,1),-4.49265432143808e-7,err),'TODO S(4,1)');
% 
% % n = 41, m = 4
% test_suite.add_test(TestEqual(C(41,4),-7.19967819600023e-15,err),'TODO C(41,4)');
% test_suite.add_test(TestEqual(S(41,4),1.63027868851955e-14,err),'TODO S(41,4)');



%% legendre_recursion

% executes legendre_recursion function
[V,W] = legendre_recursion([10000000;20000000;30000000],6378136.3,4);

% V coefficients
test_suite.add_test(TestEqual(V(grav_model_index(0,0)),0.170462862862472,'legendre_recursion, V(0,0)',15));
test_suite.add_test(TestEqual(V(grav_model_index(1,0)),0.0232979008591082,'legendre_recursion, V(1,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(1,1)),0.00776596695303608,'legendre_recursion, V(1,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(2,0)),0.00229971837307456,'legendre_recursion, V(2,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(2,1)),0.0031842254396417,'legendre_recursion, V(2,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(2,2)),-0.0031842254396417,'legendre_recursion, V(2,2)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,0)),7.25336566570076e-5,'legendre_recursion, V(3,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,1)),0.000749514452122414,'legendre_recursion, V(3,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,2)),-0.00217600969971024,'legendre_recursion, V(3,2)'));
test_suite.add_test(TestEqual(V(grav_model_index(3,3)),-0.00265956741075695,'legendre_recursion, V(3,3)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,0)),-3.27695930184524e-5,'legendre_recursion, V(4,0)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,1)),0.00011565738712395,'legendre_recursion, V(4,1)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,2)),-0.000809601709867648,'legendre_recursion, V(4,2)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,3)),-0.00254446251672689,'legendre_recursion, V(4,3)'));
test_suite.add_test(TestEqual(V(grav_model_index(4,4)),-0.000539734473245098,'legendre_recursion, V(4,4)'));

% W coefficients
test_suite.add_test(TestEqual(W(grav_model_index(0,0)),0,'legendre_recursion, W(0,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(1,0)),0,'legendre_recursion, W(1,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(1,1)),0.0155319339060722,'legendre_recursion, W(1,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(2,0)),0,'legendre_recursion, W(2,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(2,1)),0.00636845087928341,'legendre_recursion, W(2,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(2,2)),0.00424563391952227,'legendre_recursion, W(2,2)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,0)),0,'legendre_recursion, W(3,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,1)),0.00149902890424483,'legendre_recursion, W(3,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,2)),0.00290134626628032,'legendre_recursion, W(3,2)'));
test_suite.add_test(TestEqual(W(grav_model_index(3,3)),-0.000483557711046719,'legendre_recursion, W(3,3)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,0)),0,'legendre_recursion, W(4,0)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,1)),0.000231314774247899,'legendre_recursion, W(4,1)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,2)),0.0010794689464902,'legendre_recursion, W(4,2)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,3)),-0.000462629548495799,'legendre_recursion, W(4,3)'));
test_suite.add_test(TestEqual(W(grav_model_index(4,4)),-0.00185051819398319,'legendre_recursion, W(4,4)'));



%% RUNS TEST SUITE

test_suite.run;



%% TESTING HELPER FUNCTIONS

% Kaula normalization factor
function N_nm = kaula_norm_factor_testing(n,m)
    N_nm = sqrt((factorial(n-m)*(2*n+1)*(2-eq(0,m)))/factorial(n+m));
end