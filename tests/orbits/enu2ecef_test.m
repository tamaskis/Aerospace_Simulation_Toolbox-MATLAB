%% enu2ecef_test.m
% Astrodynamics Toolbox
%
% Unit testing of the enu2ecef function.
%
% Author: Tamas Kis
% Last Update: 2022-02-27



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



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

% ----------------
% Reference point.
% ----------------

% geodetic latitude [°], longitude [°], and altitude [m]
lat0 = 45;
lon0 = 45;
h0 = 10000;

% ECEF position of reference point [m]
r0_ecef = geod2ecef(lat0,lon0,h0);

% ECEF velocity of reference point resolved in ECEF frame [m/s]
v0_ecef  = [100;100;100];



%% TEST

% converts from ECEF to ENU and back
[rho_enu,rho_dot_enu] = ecef2enu(r_ecef,r0_ecef,v_ecef,v0_ecef);
[r_ecef_new,v_ecef_new] = enu2ecef(rho_enu,r0_ecef,rho_dot_enu,v0_ecef);

% unit tests --> values converted from ECEF to ENU and back should match
% original ECEF values
TEST_EQUAL(r_ecef_new,r_ecef);
TEST_EQUAL(v_ecef_new,v_ecef);