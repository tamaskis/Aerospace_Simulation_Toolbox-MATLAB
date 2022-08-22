%% drhodr_nrlmsise00_test.m
% Astrodynamics Toolbox
%
% Unit testing of the drhodr_nrlmsise00 function.
%
% Author: Tamas Kis
% Last Update: 2022-03-22



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 0.012;



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

% -------------
% Sun position.
% -------------

% assume TT approximately UT1
MJD_TT = MJD_UT1;

% Sun position resolved in ECI frame [m]
r_sun_eci = sun_position(MJD_UT1,MJD_TT);

% --------------
% Space weather.
% --------------

% load space weather data
[sw1,sw2] = load_sw;

% extract relevant data
sw = space_weather(MJD_UT1,sw1,sw2,'NRLMSISE-00');

% -----------------
% NRLMSISE-00 data.
% -----------------

nrlm_data = load_nrlm_data;



%% UNIT TESTS

% function handle for density
rho = @(r_eci) nrlmsise00(R_eci2ecef*r_eci,MJD_UT1,sw.F107_avg,sw.F107,...
    sw.ap_array,nrlm_data);

% expected result (central difference approximation)
drhodr_exp = cjacobian(rho,r_eci);

% actual result (using complex-step approximation)
drhodr_act = drhodr_nrlmsise00(r_ecef,MJD_UT1,sw.F107_avg,sw.F107,...
    sw.ap_array,nrlm_data,R_eci2ecef);

% unit test
TEST_EQUAL(drhodr_act,drhodr_exp,err);