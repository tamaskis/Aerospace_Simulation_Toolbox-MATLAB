%% jacchia_roberts_test.m
% Astrodynamics Toolbox
%
% Unit testing of the jacchia_roberts function.
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
cal_UT1 = [2017,1,1,0,0,0];

% modified Julian date of UT1
MJD_UT1 = cal2mjd(cal_UT1);

% -----------------------------------------------
% ECEF position and ECI --> ECEF rotation matrix.
% -----------------------------------------------

% geodetic latitude [deg], longitude [deg], and altitude [m]
lat = 45;
lon = 0;
h = 300000;

% position resolved in ECEF frame [m]
r_ecef = geod2ecef(lat,lon,h);

% rotation matrix (ECI --> ECEF)
R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1);

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
Kp_ap_F107 = struct2array(load('Kp_ap_F107.mat'));

% extract relevant data
sw = space_weather(MJD_UT1,Kp_ap_F107);


sw.Kp_67 = 7; % TODO


%% TEST

% expected result [kg/m^3]
rho_exp = 1.526144428631946e-11;

% actual result [kg/m^3]
[rho_jr,nN2_jr,nAr_jr,nHe_jr,nO2_jr,nO_jr,nH_jr,T_jr,T_inf] = jacchia_roberts_test(r_ecef,...
    r_sun_eci,R_eci2ecef,MJD_UT1,MJD_TT,sw.Kp_67,sw.F107,sw.F107_avg);

[rho_nrlm,nN2_nrlm,nAr_nrlm,nHe_nrlm,nO2_nrlm,nO_nrlm,nH,T_nrlm] = density_nrlmsise00(r_ecef,MJD_UT1,sw.F107_avg,...
    sw.F107_prev,sw.magneticIndex);


rho_jr
rho_nrlm

nO_jr
nO_nrlm