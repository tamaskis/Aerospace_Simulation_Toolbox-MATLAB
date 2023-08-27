%% create_EGM2008.m
% Astrodynamics Toolbox
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-06-26
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
%   • C_norm - (181×181 double) normalized gravitational coefficients
%   • S_norm - (181×181 double) normalized gravitational coefficients
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

% reads in raw data as a matrix
T = readmatrix('../rawdata/EGM2008_to2190_TideFree');

% keeps only those columns that store the relevant data, and orders them as
% [n,m,C,S]
T = T(:,1:4);

% matrix storing first three rows
A = [0  0  1  0;
     1  0  0  0;
     1  1  0  0];

% adds first three rows to coefficient table
T = [A;T];

% converts coefficient table to coefficient matrices, keeping up to
% degree/order 180
[C_norm,S_norm] = coefftab2mat(T,180);

% stores the normalized coefficients in a structure
EGM2008.C_norm = C_norm;
EGM2008.S_norm = S_norm;

% saves GGM05S as a .mat file
save('../datafiles/EGM2008.mat','EGM2008');