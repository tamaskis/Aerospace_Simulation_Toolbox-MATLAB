%% ecef2eci_test.m
% Astrodynamics Toolbox
%
% Unit testing of the ecef2eci function.
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

% rotation matrix (ECEF --> ECI)
R_ecef2eci = ecef2eci_matrix_approx(MJD_UT1);

% Earth angular velocity resolved in ECI frame [rad/s]
w_eci = w_earth_approx;

% position resolved in ECEF frame [m]
r_ecef = [-1033479.3830;
           7901295.2754;
           6380356.5958];

% ECEF velocity resolved in ECEF frame [m/s]
v_ecef = [-3225.636520;
          -2872.451450;
           5531.924446];



%% TEST

% expected results
r_eci_exp = [5102509.6;
             6123011.52;
             6378136.3];
v_eci_exp = [-4743.2196;
              790.5366;
              5533.75619];

% actual results
[r_eci_act,v_eci_act] = ecef2eci(r_ecef,v_ecef,w_eci,R_ecef2eci);

% unit tests
TEST_EQUAL(r_eci_act,r_eci_exp,err);
TEST_EQUAL(v_eci_act,v_eci_exp,err);