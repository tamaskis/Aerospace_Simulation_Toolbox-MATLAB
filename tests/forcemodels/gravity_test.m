%% gravity_test.m
% Astrodynamics Toolbox
%
% Unit testing of the gravity function.
%
% Author: Tamas Kis
% Last Update: 2022-03-15



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 1e-8;



%% LOAD DATA/FUNCTIONS

% load gravity coefficients
GGM05S = load_GGM05S;
C_norm = GGM05S.C_norm;
S_norm = GGM05S.S_norm;

% de-normalized gravity coefficients
[C,S] = gravity_coeffs(C_norm,S_norm);



%% TEST CONDITIONS

% ECEF position [m]
r_ecef = [10000000;
          20000000;
          30000000];



%% TESTS

% degree/order of gravity model to use
N = 50;

% gravity from built-in MATLAB function (EGM96)
[gx,gy,gz] = gravitysphericalharmonic(r_ecef.','EGM96',N);
g_exp = [gx;gy;gz];

% gravity from Astrodynamics Toolbox function (GGM05S)
g_act = gravity(r_ecef,C,S,N);

% unit test
TEST_EQUAL(g_exp,g_act,err);