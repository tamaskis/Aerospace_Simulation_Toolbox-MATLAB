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



%% TEST CASE

lat = 28.3922;
lon = 80.6077;
alt = 10000;

r_ecef = geod2ecef(lat,lon,alt);
w_earth = [0;0;72.92115e-6];
r_ecef = [917796.3478623135;5548585.9265594641;3019567.1751323733];

g_enu = [-0.0000375601495168;0.0000625388720330;-9.7611418734383335];
g_geolib = enu2ecef_matrix(r_ecef)*g_enu+cross(w_earth,cross(w_earth,r_ecef))



%% TODO

% load gravity coefficients
GGM05S = load_GGM05S;
EGM2008 = load_EGM2008;

% de-normalized gravity coefficients
[C_ggm05s,S_ggm05s] = gravity_coeffs(GGM05S.C_norm,GGM05S.S_norm);
[C_egm2008,S_egm2008] = denormalize_coeffs(EGM2008.C_norm,EGM2008.S_norm);



%% TODO

g_geolib
g_ggm05s = gravity(r_ecef,C_ggm05s,S_ggm05s,10)
g_egm2008 = grav_accel_spherical_harmonic(r_ecef,EGM2008.mu,EGM2008.R,C_egm2008,S_egm2008,10,10)