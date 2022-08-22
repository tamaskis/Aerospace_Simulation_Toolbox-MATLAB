%% exponential_test.m
% Astrodynamics Toolbox
%
% Unit testing of the exponential function.
%
% Author: Tamas Kis
% Last Update: 2022-02-19



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 0.0001;



%% TEST CONDITIONS

% ------
% Epoch.
% ------

% UT1 [y,mo,d,h,m,s]
cal_UT1 = [2006,4,2,0,0,0];

% modified Julian date of UT1
MJD_UT1 = cal2mjd(cal_UT1);

% ----------------------
% ECI position/velocity.
% ----------------------

% orbital elements
a = 6853137;    % semi-major axis [m]
e = 0.001;      % eccentricity [-]
i = 0.9006;     % inclination [rad]
Om = 0;         % right ascension of the ascending node [rad]
w = 0;          % argument of periapsis [rad]
M = pi/2;       % mean anomaly [rad]

% ECI position [m] and velocity [m/s]
[r_eci,v_eci] = oe2eci(a,e,i,Om,w,E2nu(M2E(M,e),e));

% -----------------------
% ECEF position/velocity.
% -----------------------

% rotation matrix (ECI --> ECEF)
R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1);

% Earth angular velocity
w_eci = w_earth_approx;

% ECEF position [m] and velocity [m/s]
[r_ecef,v_ecef] = eci2ecef(r_eci,v_eci,w_eci,R_eci2ecef);



%% TEST

% expected result [kg/m^3]
rho_exp = 2.9683e-12;

% actual result [kg/m^3]
rho_act = exponential(r_ecef);

% unit test
TEST_EQUAL(rho_act,rho_exp,err);