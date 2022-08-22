%% dydX_pseudorange_rate_test.m
% Astrodynamics Toolbox
%
% Unit testing of the dydX_pseudorange_rate function.
%
% Author: Tamas Kis
% Last Update: 2022-03-11



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% TEST CONDITION

% ------
% Epoch.
% ------

% UT1 [y,mo,d,h,m,s]
cal_UT1 = [2006,4,2,9,0,0];

% modified Julian date of UT1
MJD_UT1 = cal2mjd(cal_UT1);

% ------------------
% Earth orientation.
% ------------------

% rotation matrix (ECI --> ECEF)
R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1);

% Earth angular velocity resolved in ECI frame [rad/s]
w_eci = w_earth_approx;

% -------------------
% Receiver ECI state.
% -------------------

% orbital elements
a = 6853137;    % semi-major axis [m]
e = 0.001;      % eccentricity [-]
i = 0.9006;     % inclination [rad]
Om = 0;         % right ascension of the ascending node [rad]
w = 0;          % argument of periapsis [rad]
nu = pi/2;      % true anomaly [rad]

% ECI position [m] and velocity [m/s]
[r_rcv_eci,v_rcv_eci] = oe2eci(a,e,i,Om,w,nu);

% position [m] and inertial velocity [m/s] resolved in ECEF frame
[r_rcv_ecef,v_rcv_ecef] = eci2ecef(r_rcv_eci,v_rcv_eci,w_eci,R_eci2ecef);

% clock bias drift rate [m/s]
b_dot_rcv = 0.001;

% ------------------------
% GPS satellite ECI state.
% ------------------------

% orbital elements
a = 26559342;   % semi-major axis [m]
e = 0.006;      % eccentricity [-]
i = 0.9599;     % inclination [rad]
Om = 2.6426;    % right ascension of the ascending node [rad]
w = 3.9849;     % argument of periapsis [rad]
nu = 2.2902;    % true anomaly [rad]

% position [m] and inertial velocity [m/s] resolved in ECI frame
[r_sat_eci,v_sat_eci] = oe2eci(a,e,i,Om,w,nu);

% position [m] and inertial velocity [m/s] resolved in ECEF frame
[r_sat_ecef,v_sat_ecef] = eci2ecef(r_sat_eci,v_sat_eci,w_eci,R_eci2ecef);

% clock bias drift rate [m/s]
b_dot_sat = 0.001;



%% UNIT TEST

% function handle for pseudorange rate measurement as function of ECI pos.
rhodot = @(r_rcv_eci) test_function(r_rcv_eci,v_rcv_eci,r_sat_ecef,...
    v_sat_ecef,b_dot_rcv,b_dot_sat,MJD_UT1);

% numerical result (expected result)
drhodotdr_exp = ijacobian(rhodot,r_rcv_eci);

% actual result
drhodotdr_act = dydX_pseudorange_rate(r_rcv_eci,r_sat_eci,v_rcv_eci,...
    v_sat_eci);

% unit test
TEST_EQUAL(drhodotdr_act,drhodotdr_exp);



%% FUNCTIONS FOR TESTING PURPOSES

function rhodot = test_function(r_rcv_eci,v_rcv_eci,r_sat_ecef,...
    v_sat_ecef,b_dot_rcv,b_dot_sat,MJD_UT1)

    % rotation matrix (ECI --> ECEF)
    R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1);
    
    % Earth angular velocity resolved in ECI frame [rad/s]
    w_eci = w_earth_approx;
    
    % receiver position [m] and ECEF velocity [m/s] resolved in ECEF frame
    [r_rcv_ecef,v_rcv_ecef] = eci2ecef(r_rcv_eci,v_rcv_eci,w_eci,...
        R_eci2ecef);

    % pseudorange rate measurement [rad/s]
    rhodot = pseudorange_rate(r_rcv_ecef,r_sat_ecef,v_rcv_ecef,...
        v_sat_ecef,b_dot_rcv,b_dot_sat);

end