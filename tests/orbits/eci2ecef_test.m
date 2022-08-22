%% eci2ecef_test.m
% Astrodynamics Toolbox
%
% Unit testing of the eci2ecef function.
%
% Author: Tamas Kis
% Last Update: 2022-03-12



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 1e-2;



%% NOTE

% This test case is adapted from Vallado, "Fundamentals of Astrodynamics
% and Applications", 4th Ed. (p. 231). Note that Vallado has a
% slightly different result, due to using a slightly different rotation
% matrix and Earth angular velocity, hence the error tolerance defined 
% above.



%% TEST CONDITIONS

% UT1 [y,mo,d,h,m,s]
cal_UT1 = [2004,4,6,7,51,28];

% modified Julian date of UT1
MJD_UT1 = cal2mjd(cal_UT1);

% rotation matrix (ECI --> ECEF)
R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1);

% Earth angular velocity resolved in ECI frame [rad/s]
w_eci = w_earth_approx;

% position resolved in ECI frame [m]
r_eci = [5102509.6;
         6123011.52;
         6378136.3];

% inertial velocity resolved in ECI frame [m/s]
v_eci = [-4743.2196;
          790.5366;
          5533.75619];



%% TEST

% expected results
r_ecef_exp = [-1033479.3830;
               7901295.2754;
               6380356.5958];
v_ecef_exp = [-3225.636520;
              -2872.451450;
               5531.924446];

% actual results
[r_ecef_act,v_ecef_act] = eci2ecef(r_eci,v_eci,w_eci,R_eci2ecef);

% unit tests
TEST_EQUAL(r_ecef_act,r_ecef_exp,err);
TEST_EQUAL(v_ecef_act,v_ecef_exp,err);