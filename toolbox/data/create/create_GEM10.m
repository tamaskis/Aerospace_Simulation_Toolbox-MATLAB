%% create_GEM10.m
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
% This script produces "GEM10.mat" which stores the 1×1 struct "GEM10" with
% the following fields:
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



%% USING GRAVITY COEFFICIENT FILE

% reads GCF file
[mu,R,tide_system,N_max,C,S,C_norm,S_norm] = read_gfc(...
    '../../../rawdata/GEM10.gfc');

% stores data in structure
GEM10.mu = mu;
GEM10.R = R;
GEM10.tide_system = tide_system;
GEM10.N_max = N_max;
GEM10.C = C;
GEM10.S = S;
GEM10.C_norm = C_norm;
GEM10.S_norm = S_norm;



%% ADDS PERMANENT TIDE OFFSET

GEM10.dC_perm = 0;



%% SAVING .MAT FILE

% saves GEM10 as a .mat file
save('../datafiles/GEM10.mat','GEM10');