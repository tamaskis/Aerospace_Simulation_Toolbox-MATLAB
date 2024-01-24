%% CREATE_TEST_gravitation.m
% Aerospace Simulation Toolbox
%
% Script to generate test cases for gravitation functions.
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


%% TEST GENERATION

% CASE #1
% (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (10,10)
%   --> echo 28.3922 80.6077 10000 | CartConvert -p 16
%   --> echo 28.3922 80.6077 10000 | Gravity -n egm2008 -N 10 -M 10 -p 16
lat = 28.3922;
lon = 80.6077;
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_enu_rot = [-0.0000375601495168;0.0000625388720330;-9.7611418734383335];
grav_accel_test_conversion(g_enu_rot,r_ecef,lat,lon)

% CASE #2
% (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (40,40)
%   --> echo 28.3922 80.6077 10000 | CartConvert -p 16
%   --> echo 28.3922 80.6077 10000 | Gravity -n egm2008 -N 40 -M 40 -p 16
lat = 28.3922;
lon = 80.6077;
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_enu_rot = [0.0000641178579097;0.0006115608168535;-9.7608351284814407];
grav_accel_test_conversion(g_enu_rot,r_ecef,lat,lon)

% CASE #3
% (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (40,10)
%   --> echo 28.3922 80.6077 10000 | CartConvert -p 16
%   --> echo 28.3922 80.6077 10000 | Gravity -n egm2008 -N 40 -M 10 -p 16
lat = 28.3922;
lon = 80.6077;
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_enu_rot = [0.0000023060402832;0.0003826389347461;-9.7609555660305229];
grav_accel_test_conversion(g_enu_rot,r_ecef,lat,lon)

% CASE #4
% (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (120,120)
%   --> echo 28.3922 80.6077 10000 | CartConvert -p 16
%   --> echo 28.3922 80.6077 10000 | Gravity -n egm2008 -N 120 -M 120 -p 16
lat = 28.3922;
lon = 80.6077;
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_enu_rot = [0.0004074539661985;0.0010095009060951;-9.7598048697074553];
grav_accel_test_conversion(g_enu_rot,r_ecef,lat,lon)

% CASE #5
% (lat,lon,alt) = (89.9999°,0°,10000 m), (N,M) = (120,120)
%   --> echo 89.9999 0 10000 | CartConvert -p 16
%   --> echo 89.9999 0 10000 | Gravity -n egm2008 -N 120 -M 120 -p 16
lat = 89.9999;
lon = 0;
r_ecef = [11.1868512488;0.0000000000;6366752.3142354172];
g_enu_rot = [-0.0000315305636293;-0.0001273337322898;-9.8015134739559873];
grav_accel_test_conversion(g_enu_rot,r_ecef,lat,lon)

% CASE #6
% (lat,lon,alt) = (90°,0°,10000 m), (N,M) = (120,120)
%   --> echo 90 0 10000 | CartConvert -p 16
%   --> echo 90 0 10000 | Gravity -n egm2008 -N 120 -M 120 -p 16
lat = 90;
lon = 0;
r_ecef = [0.0000000000;0.0000000000;6366752.3142451793];
g_enu_rot = [-0.0000315305796925;-0.0001273355987601;-9.8015134785075357];
grav_accel_test_conversion(g_enu_rot,r_ecef,lat,lon)

% CASE #7
% EGM2008, tide-free, (lat,lon,alt) = (85°,-45°,5 m), (N,M) = (80,65)
%   --> echo 85 -45 5 | CartConvert -p 16
%   --> echo 85 -45 5 | Gravity -n egm2008 -N 80 -M 65 -p 16
lat = 85;
lon = -45;
r_ecef = [394387.0359271481;-394387.0359271481;6332405.8449596651];
g_enu_rot = [0.0001071613292241;-0.0001137045084609;-9.8319500133515447];
grav_accel_test_conversion(g_enu_rot,r_ecef,lat,lon)

% CASE #8
% EGM2008, tide-free, (lat,lon,alt) = (28.3922°,80.6077°,10000 m), (N,M) = (2,0)
%   --> echo 28.3922 80.6077 10000 | CartConvert -p 16
%   --> echo 28.3922 80.6077 10000 | Gravity -n egm2008 -N 2 -M 0 -p 16
lat = 28.3922;
lon = 80.6077;
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];
g_enu_rot = [0.0000000000000000;-0.0000334285889485;-9.7612436840623591];
grav_accel_test_conversion(g_enu_rot,r_ecef,lat,lon)



%% HELPER FUNCTIONS

% grav_accel_test_conversion
function g_ecef = grav_accel_test_conversion(g_enu_rot,r_ecef,lat,lon)
    
    % Earth angular velocity [rad/s]
    w_earth = [0;0;72.92115e-6];
    
    % unit conversion from degrees to radians
    lat = lat*(pi/180);
    lon = lon*(pi/180);
    
    % rotation matrix from ENU frame to ECEF frame
    R_enu2ecef = rot_enu2pcpf(lat,lon);
    
    % gravitational + centrifugal acceleration expressed in ECEF frame
    % [m/s²]
    g_ecef_rot = R_enu2ecef*g_enu_rot;
    
    % removes centrifugal acceleration [m/s²]
    g_ecef = g_ecef_rot+cross(w_earth,cross(w_earth,r_ecef));
    
end