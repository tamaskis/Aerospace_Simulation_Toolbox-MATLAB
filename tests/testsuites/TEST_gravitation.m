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



%% grav_accel_spherical_harmonic

% loads gravitational model
EGM2008 = load_EGM2008;

% extract parameters
mu = EGM2008.mu;
R = EGM2008.R;
C_norm = EGM2008.C_norm;
S_norm = EGM2008.S_norm;

% denormalizes coefficients
[C,S] = denormalize_coeffs(EGM2008.C_norm,EGM2008.S_norm);

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (10,10)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40619073945194;-8.5014299770321;-4.64141141193325];
g_exp_geo = [-1.40619073945194;-8.50142997703209;-4.64141141193325];
g_act = grav_accel_spherical_harmonic(r_ecef,mu,R,C,S,10,10);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel_spherical_harmonic test #1',14));
test_suite.add_test(TestEqual(g_act,g_exp_geo,'grav_accel_spherical_harmonic test #1 vs. GeographicLib',13));

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (40,40)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40628962068093;-8.50140471638596;-4.64078257142567];
g_act = grav_accel_spherical_harmonic(r_ecef,mu,R,C,S,40,40);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel_spherical_harmonic test #2',13));

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (40,10)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40622816377887;-8.50141193972162;-4.64104122564417];
g_act = grav_accel_spherical_harmonic(r_ecef,mu,R,C,S,40,10);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel_spherical_harmonic test #3',13));

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (120,120)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40651132644688;-8.50064118963615;-4.63994260559605];
g_act = grav_accel_spherical_harmonic(r_ecef,mu,R,C,S,120,120);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel_spherical_harmonic test #4',13));

% EGM2008, tide-free, (lat,lon,alt) = (89.9999°,0°,10000 m), (N,M) = (120,120)
r_ecef = [11.1868512488;0.0000000000;6366752.3142354172];
g_exp = [0.000110167378093823;-3.15305636293e-05;-9.8015134741633];
g_act = grav_accel_spherical_harmonic(r_ecef,mu,R,C,S,120,120);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel_spherical_harmonic test #5',13));

% EGM2008, tide-free, (lat,lon,alt) = (90°,0°,10000 m), (N,M) = (120,120)
r_ecef = [0.0000000000;0.0000000000;6366752.3142451793];
g_exp = [0.0001273355987601;-3.15305796925e-05;-9.80151347850754];
g_act = grav_accel_spherical_harmonic(r_ecef,mu,R,C,S,120,120);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel_spherical_harmonic test #6',14));

% EGM2008, tide-free, (lat,lon,alt) = (85°,-45°,5 m), (N,M) = (80,65)
r_ecef = [394387.0359271481;-394387.0359271481;6332405.8449596651];
g_exp = [-0.607868793518748;0.608020342523899;-9.79454638520476];
g_act = grav_accel_spherical_harmonic(r_ecef,mu,R,C,S,80,65);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel_spherical_harmonic test #7',13));

% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (2,0)
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_exp = [-1.40623496535577;-8.50146718973369;-4.6415442471915];
g_act = grav_accel_spherical_harmonic(r_ecef,mu,R,C,S,2,0);
test_suite.add_test(TestEqual(g_act,g_exp,'grav_accel_spherical_harmonic test #8',14));



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




%% TODO

% % relative error tolerance
% err = 1e-8;
% 
% % load gravity coefficients
% GGM05S = load_GGM05S;
% C_norm = GGM05S.C_norm;
% S_norm = GGM05S.S_norm;
% 
% % de-normalized gravity coefficients
% [C,S] = gravity_coeffs(C_norm,S_norm);
% 
% 
% % ECEF position [m]
% r_ecef = [0;0;1];
% r_ecef = r_ecef/norm(r_ecef)*6371000; % TODO
% 
% % gravity from built-in MATLAB function (EGM96)
% % [gx,gy,gz] = gravitysphericalharmonic(r_ecef.','EGM96',N);
% % g_exp = [gx;gy;gz];
% 
% % gravity from Astrodynamics Toolbox function (GGM05S)
% test_suite.add_test(TestEqual(gravity(altdir2rad(1,[1;1;1]),C,S,50),[-5.66209216008867;-5.66210745212866;-5.67998610408259],'gravity, TODO',14));
% test_suite.add_test(TestEqual(gravity(altdir2rad(10,[0;1;0]),C,S,50),[-0.000488193651484778;-9.80513663465309;1.72469937384792e-05],'gravity, TODO',14));
% test_suite.add_test(TestEqual(gravity(altdir2rad(1000,[-5;1;-3]),C,S,50),[6.19829668007732;-1.23966700067842;3.72815460451779],'gravity, TODO',14));


% %% TODO NEW TESTS
% 
% % relative error tolerance
% err = 1e-8;
% 
% % loads gravitational model
% EGM2008 = load_EGM2008;
% 
% % de-normalized gravity coefficients
% [C,S] = denormalize_coeffs(EGM2008.C_norm,EGM2008.S_norm);
% 
% % gravity from Astrodynamics Toolbox function (GGM05S)
% grav_accel_spherical_harmonic(altdir2rad(1,[1;1;1]),EGM2008.mu,EGM2008.R,C,S,50,50)
% test_suite.add_test(TestEqual(grav_accel_spherical_harmonic(altdir2rad(1,[1;1;1]),EGM2008.mu,EGM2008.R,C,S,50,50),[-5.66209216008867;-5.66210745212866;-5.67998610408259],'gravity, TODO',14));
% test_suite.add_test(TestEqual(grav_accel_spherical_harmonic(altdir2rad(10,[0;1;0]),EGM2008.mu,EGM2008.R,C,S,50,50),[-0.000488193651484778;-9.80513663465309;1.72469937384792e-05],'gravity, TODO',14));
% test_suite.add_test(TestEqual(grav_accel_spherical_harmonic(altdir2rad(1000,[-5;1;-3]),EGM2008.mu,EGM2008.R,C,S,50,50),[6.19829668007732;-1.23966700067842;3.72815460451779],'gravity, TODO',14));



%% legendre_recursion

% ECEF position [m]
rX = 10000000;
rY = 20000000;
rZ = 30000000;
r_ecef = [rX;rY;rZ];

% magnitude of position vector
r = norm(r_ecef);

% Earth radius [m]
R = 6378136.3;

V10 = 0.0232979008591082;
V20 = 0.00229971837307456;
V30 = 7.25336566570076e-05;
V40 = -3.27695930184524e-05;
V50 = -9.74789551057192e-06;
W10 = 0;
W20 = 0;
W30 = 0;
W40 = 0;
W50 = 0;
V11 = 0.00776596695303608;
W11 = 0.0155319339060722;
V22 = -0.0031842254396417;
W22 = 0.00424563391952227;
V33 = -0.00265956741075695;
W33 = -0.000483557711046719;
V44 = -0.000539734473245098;
W44 = -0.00185051819398319;
V55 = 0.00129620664627064;
W55 = -0.00120136225751913;
V21 = 0.0031842254396417;
V31 = 0.000749514452122414;
V41 = 0.00011565738712395;
V51 = 8.34279345499397e-06;

[V,W] = legendre_recursion(r_ecef,R,5);

test_suite.add_test(TestEqual(V(grav_model_index(1,0)),V10,'V10, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(2,0)),V20,'V20, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(3,0)),V30,'V30, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(4,0)),V40,'V40, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(5,0)),V50,'V50, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(1,0)),W10,'W10, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(2,0)),W20,'W20, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(3,0)),W30,'W30, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(4,0)),W40,'W40, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(5,0)),W50,'W50, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(1,1)),V11,'V11, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(1,1)),W11,'W11, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(2,2)),V22,'V22, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(2,2)),W22,'W22, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(3,3)),V33,'V33, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(3,3)),W33,'W33, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(4,4)),V44,'V44, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(4,4)),W44,'W44, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(5,5)),V55,'V55, TODO',14));
test_suite.add_test(TestEqual(W(grav_model_index(5,5)),W55,'W55, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(2,1)),V21,'V21, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(3,1)),V31,'V31, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(4,1)),V41,'V41, TODO',14));
test_suite.add_test(TestEqual(V(grav_model_index(5,1)),V51,'V51, TODO',14));



%% RUNS TEST SUITE

test_suite.run;



%% TESTING HELPER FUNCTIONS

% Kaula normalization factor
function N_nm = kaula_norm_factor_testing(n,m)
    N_nm = sqrt((factorial(n-m)*(2*n+1)*(2-eq(0,m)))/factorial(n+m));
end

% altitude (km) + direction (vector) to radius (m)
function r = altdir2rad(h,direction)
    r = (6371+h)*1000*direction/norm(direction);
end

% geographiclib2ecef
function g_ecef = geographiclib2ecef(r_ecef,g_enu_rot)
    w_earth = [0;0;72.92115e-6];
    g_ecef = enu2ecef_matrix(r_ecef)*g_enu_rot+cross(w_earth,...
        cross(w_earth,r_ecef));
end