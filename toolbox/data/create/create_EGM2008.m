%% create_EGM2008.m
% Astrodynamics Toolbox
%
% Copyright © 2022 Tamas Kis
% Last Update: 2024-01-02
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Aerospace_Simulation.pdf
%
% ----------------------
% Generated data format.
% ----------------------
%
% This script produces "EGM2008.mat" which stores the 1×1 struct
% "EGM2008" with the following fields:
%   mu          - (1×1 double) standard gravitational parameter [m³/s²]
%   R           - (1×1 double) reference radius [m]
%   tide_system - (char array) tide system ('tide-free' or 'zero-tide')
%   N_max       - (1×1 double) maximum possible degree
%   C           - (L×1 double) unnormalized coefficient vector
%   S           - (L×1 double) unnormalized coefficient vector
%   C_norm      - (L×1 double) normalized coefficient vector
%   S_norm      - (L×1 double) normalized coefficient vector
%   dC_perm     - (1×1 double) permanent tide offset
%
% Note that
%
%   L = (Nₘₐₓ+1)(Nₘₐₓ+2)/2 where Nₘₐₓ is the maximum possible degree.



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;



%% MAXIMUM DEGREE FOR TRUNCATING ORIGINAL DATA FILES
% We do this because the original data file stores coefficients up to
% maximum degree/order 2190, which takes up a lot of memory.

N = 360;



%% USING GRAVITY COEFFICIENT FILE

% reads GCF file
[mu,R,tide_system,N_max,C,S,C_norm,S_norm] = read_gfc(...
    '../../../rawdata/EGM2008.gfc',N);

% stores data in structure
EGM2008.mu = mu;
EGM2008.R = R;
EGM2008.tide_system = tide_system;
EGM2008.N_max = N_max;
EGM2008.C = C;
EGM2008.S = S;
EGM2008.C_norm = C_norm;
EGM2008.S_norm = S_norm;



%% USING ORIGINAL FILES

% % load in the gravitational data file as a matrix (for EGM2008, the data
% % file only contains tabular data)
% T = readmatrix('../../../rawdata/EGM2008_to2190_TideFree');
% 
% % extracts the normalized coefficient vectors
% C_norm = T(:,3);
% S_norm = T(:,4);
% 
% % adds missing rows
% C_norm = [1;0;0;C_norm];
% S_norm = [0;0;0;S_norm];
% 
% % gravitational model length
% L = grav_model_length(N);
% 
% % limit to degree/order 360
% C_norm = C_norm(1:L);
% S_norm = S_norm(1:L);
% 
% % denormalize the coefficients
% [C,S] = denormalize_coeffs(C_norm,S_norm);
% 
% % stores data in a structure
% EGM2008.mu = 3986004.415e8;
% EGM2008.R = 6378136.3;
% EGM2008.tide_system = 'tide-free';
% EGM2008.N_max = N;
% EGM2008.C = C;
% EGM2008.S = S;
% EGM2008.C_norm = C_norm;
% EGM2008.S_norm = S_norm;



%% ADDS PERMANENT TIDE OFFSET

EGM2008.dC_perm = -4.1736e-9;



%% SAVING .MAT FILE

% saves EGM2008 as a .mat file
save('../datafiles/EGM2008.mat','EGM2008');