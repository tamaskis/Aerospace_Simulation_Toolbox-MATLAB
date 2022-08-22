%% dadX_gravity_test.m
% Astrodynamics Toolbox
%
% Unit testing of the dadX_gravity function.
%
% Author: Tamas Kis
% Last Update: 2022-02-28



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 1e-2;



%% LOAD DATA/FUNCTIONS

% load gravity coefficients
GGM05S = load_GGM05S;
C_norm = GGM05S.C_norm;
S_norm = GGM05S.S_norm;

% de-normalized gravity coefficients
[C,S] = gravity_coeffs(C_norm,S_norm);



%% TEST CONDITION

% ------
% Epoch.
% ------

% UT1 [y,mo,d,h,m,s]
cal_UT1 = [2006,4,2,9,0,0];

% modified Julian date of UT1
MJD_UT1 = cal2mjd(cal_UT1);

% -------------
% ECI position.
% -------------

% orbital elements
a = 6853137;    % semi-major axis [m]
e = 0.001;      % eccentricity [-]
i = 0.9006;     % inclination [rad]
Om = 0;         % right ascension of the ascending node [rad]
w = 0;          % argument of periapsis [rad]
nu = pi/2;      % true anomaly [rad]

% ECI position [m]
r_eci = oe2eci(a,e,i,Om,w,nu);

% --------------
% ECEF position.
% --------------

% rotation matrix (ECI --> ECEF)
R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1);

% ECEF position [m]
r_ecef = R_eci2ecef*r_eci;

% rotation matrix (ECCEF --> ECI)
R_ecef2eci = R_eci2ecef.';

% -----------------
% Gravity settings.
% -----------------

% degree/order of gravity model to use
N = 120;



%% UNIT TEST FOR ECEF

% function handle for gravity
g_ecef = @(r) gravity(r,C,S,N);

% numerical result (expected result)
tic;
dadr_g_exp = ijacobian(g_ecef,r_ecef);
complex_step_time = toc;

% actual result
tic;
dadr_g_act = (R_ecef2eci.')*(dadX_gravity(r_ecef,C,S,N,R_ecef2eci))*...
    (R_ecef2eci);
analytical_time = toc;

% PRISMA result
tic;
d = 1;
dgdr_prisma = zeros(3,3);
for i = 1:3
    dr = [0;0;0];
    dr(i) = d;
    da = gravity(r_ecef+dr,C,S,N)-gravity(r_ecef,C,S,N);
    dgdr_prisma(:,i) = da/d;
end
prisma_time = toc;

% unit test
TEST_EQUAL(dadr_g_act,dadr_g_exp);



%% COMPARISON OF DIFFERENT METHODS

% print results
dgdr_analytical = dadr_g_act
dgdr_complex_step = dadr_g_exp
dgdr_prisma

% print times
analytical_time
complex_step_time
prisma_time

% maximum differences
complex_step_max_diff = max(abs(dgdr_complex_step-dgdr_analytical),[],'all')
prisma_max_diff = max(abs(dgdr_prisma-dgdr_analytical),[],'all')



%% UNIT TEST FOR ECI

% function handle for gravity
g_eci = @(r_eci) R_ecef2eci*g_ecef(R_ecef2eci.'*r_eci);

% numerical result (expected result)
dadr_g_exp = ijacobian(g_eci,r_eci);

% actual result
dadr_g_act = dadX_gravity(r_ecef,C,S,N,R_ecef2eci);

% unit test
TEST_EQUAL(dadr_g_act,dadr_g_exp,0.1);


%% DELETE LATER

g_ecef = @(r) gravity(r,C,S,N);
dadr_g_ecef = ijacobian(g_ecef,r_ecef);



