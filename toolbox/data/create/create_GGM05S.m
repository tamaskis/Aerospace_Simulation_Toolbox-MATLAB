%% create_GGM05S.m
% Astrodynamics Toolbox
%
% Creates GGM05S gravity model data.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
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



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;



%% NORMALIZED GRAVITATIONAL COEFFICIENTS

% read in data
data = readmatrix('../rawdata/GGM05S.txt');

% keep columns 2-5 only
data = data(:,2:5);

% adds first three rows
first3 = [0  0  1  0;
          1  0  0  0;
          1  1  0  0];
data = [first3;
        data];

% turns first two columns into integers
data(:,1:2) = round(data(:,1:2));

% separate C and S data
C_data = data(:,1:3);
S_data = [data(:,1:2),data(:,4)];

% preallocates matrices to store normalized C and S coefficients
C_norm = zeros(181,181);
S_norm = zeros(181,181);

% populates coefficient matrices
for i = 1:size(C_data,1)
    C_norm(C_data(i,1)+1,C_data(i,2)+1) = C_data(i,3);
    S_norm(S_data(i,1)+1,S_data(i,2)+1) = S_data(i,3);
end

% stores the normalized coefficients in a structure
GGM05S.C_norm = C_norm;
GGM05S.S_norm = S_norm;

% saves GGM05S as a .mat file
save('../datafiles/GGM05S.mat','GGM05S');