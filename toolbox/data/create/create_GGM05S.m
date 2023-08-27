%% create_GGM05S.m
% Astrodynamics Toolbox
%
% Creates GGM05S gravity model data.
%
% Author: Tamas Kis
% Last Update: 2023-06-26
%
% ----------------------
% Generated data format.
% ----------------------
%
% This script produces "GGM05s.mat" which stores the 1×1 struct "GGM05S"
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
%    0    0   |   C(0,0)     S(0,0)
%    1    0   |   C(1,0)     S(1,0)
%    1    1   |   C(1,1)     S(1,1)
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
% Note that this data may be embedded in a larger table, and that any of
% the first three rows may be missing since they are typically
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

% read in data
path = '../rawdata/GGM05S.txt';
N = 180;
r_start = 1;
r_miss = 3;
n_col = 2;
m_col = 3;
C_col = 4;
S_col = 5;
[C_norm,S_norm] = process_gravity_data(path,N,r_start,r_miss,n_col,...
    m_col,C_col,S_col);

% stores the normalized coefficients in a structure
GGM05S.C_norm = C_norm;
GGM05S.S_norm = S_norm;

% saves GGM05S as a .mat file
save('../datafiles/GGM05S.mat','GGM05S');