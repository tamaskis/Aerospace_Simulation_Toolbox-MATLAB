%% create_EGM2008.m
% Astrodynamics Toolbox
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-12-28
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
% This script produces "EGM2008.mat" which stores the 1×1 struct "EGM2008"
% with the following fields:
%   • C_norm - (65341×1 double) normalized gravitational coefficients up to
%              maximum degree and order 360
%   • S_norm - (65341×1 double) normalized gravitational coefficients up to
%              maximum degree and order 360
%
% ----------------
% Raw data format.
% ----------------
%
%   --------------------------------
%    n    m   |  C_norm      S_norm
%   --------------------------------
%    2    0   |   C(2,0)     S(2,0)
%    2    1   |   C(2,1)     S(2,1)
%    2    2   |   C(2,2)     S(2,2)
%    3    0   |   C(3,0)     S(3,0)
%    3    1   |   C(3,1)     S(3,1)
%    3    2   |   C(3,2)     S(3,2)
%    3    3   |   C(3,3)     S(3,3)
%    :    :   |    :           :
%    N   N-1  |  C(N,N-1)   S(N,N-1)
%    N    N   |   C(N,N)     S(N,N)
%   ---------------------------------
%
% Note that the raw data is missing the first three rows:
%
%   --------------------------------
%    n    m   |  C_norm      S_norm
%   --------------------------------
%    0    0   |     1           0
%    1    0   |     0           0
%    1    1   |     0           0
%   --------------------------------



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;



%% NORMALIZED GRAVITATIONAL COEFFICIENTS

% load in the gravitational data file as a matrix (for EGM2008, the data
% file only contains tabular data)
T = readmatrix('../../../rawdata/EGM2008_to2190_TideFree');

% extracts the normalized coefficient vectors
C_norm = T(:,3);
S_norm = T(:,4);

% adds missing rows
C_norm = [1;0;0;C_norm];
S_norm = [0;0;0;S_norm];

% limit to degree/order 360
C_norm = C_norm(1:65341);
S_norm = S_norm(1:65341);

% stores the normalized coefficients in a structure
EGM2008.C_norm = C_norm;
EGM2008.S_norm = S_norm;

% stores other data in structure TODO
EGM2008.mu = 3986004.415e8;
EGM2008.R = 6378136.3;

% saves GGM05S as a .mat file
save('../datafiles/EGM2008.mat','EGM2008');