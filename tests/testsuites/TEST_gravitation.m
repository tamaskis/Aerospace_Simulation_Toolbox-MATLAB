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

% relative error tolerance
err = 1e-8;

% load gravity coefficients
GGM05S = load_GGM05S;
C_norm = GGM05S.C_norm;
S_norm = GGM05S.S_norm;

% de-normalized gravity coefficients
[C,S] = gravity_coeffs(C_norm,S_norm);


% ECEF position [m]
r_ecef = [0;0;1];
r_ecef = r_ecef/norm(r_ecef)*6371000; % TODO

% gravity from built-in MATLAB function (EGM96)
% [gx,gy,gz] = gravitysphericalharmonic(r_ecef.','EGM96',N);
% g_exp = [gx;gy;gz];

% gravity from Astrodynamics Toolbox function (GGM05S)
test_suite.add_test(TestEqual(gravity(altdir2rad(1,[1;1;1]),C,S,50),[-5.66209216008867;-5.66210745212866;-5.67998610408259],'gravity, TODO',14));
test_suite.add_test(TestEqual(gravity(altdir2rad(10,[0;1;0]),C,S,50),[-0.000488193651484778;-9.80513663465309;1.72469937384792e-05],'gravity, TODO',14));
test_suite.add_test(TestEqual(gravity(altdir2rad(1000,[-5;1;-3]),C,S,50),[6.19829668007732;-1.23966700067842;3.72815460451779],'gravity, TODO',14));


%% TODO NEW TESTS

% relative error tolerance
err = 1e-8;

% loads gravitational model
EGM2008 = load_EGM2008;

% de-normalized gravity coefficients
[C,S] = denormalize_coeffs(EGM2008.C_norm,EGM2008.S_norm);

% gravity from Astrodynamics Toolbox function (GGM05S)
grav_accel_spherical_harmonic(altdir2rad(1,[1;1;1]),EGM2008.mu,EGM2008.R,C,S,50,50)
test_suite.add_test(TestEqual(grav_accel_spherical_harmonic(altdir2rad(1,[1;1;1]),EGM2008.mu,EGM2008.R,C,S,50,50),[-5.66209216008867;-5.66210745212866;-5.67998610408259],'gravity, TODO',14));
test_suite.add_test(TestEqual(grav_accel_spherical_harmonic(altdir2rad(10,[0;1;0]),EGM2008.mu,EGM2008.R,C,S,50,50),[-0.000488193651484778;-9.80513663465309;1.72469937384792e-05],'gravity, TODO',14));
test_suite.add_test(TestEqual(grav_accel_spherical_harmonic(altdir2rad(1000,[-5;1;-3]),EGM2008.mu,EGM2008.R,C,S,50,50),[6.19829668007732;-1.23966700067842;3.72815460451779],'gravity, TODO',14));



%% RUNS TEST SUITE

test_suite.run;



%% TESTING HELPER FUNCTIONS

% testing function
function N_nm = kaula_norm_factor_testing(n,m)
    N_nm = sqrt((factorial(n-m)*(2*n+1)*(2-eq(0,m)))/factorial(n+m));
end

% altitude (km) + direction (vector) to radius (m)
function r = altdir2rad(h,direction)
    r = (6371+h)*1000*direction/norm(direction);
end