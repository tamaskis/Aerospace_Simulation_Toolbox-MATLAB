%% J2_ecef_test.m
% Astrodynamics Toolbox
%
% Unit testing of the J2_ecef function.
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
err = 1e-6;



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



%% TEST

% expected result
g_exp = two_body(r_ecef)+J2_ecef(r_ecef);

% actual result using "gravity" function
g_act = gravity(r_ecef,C,S,2);

% unit test
TEST_EQUAL(g_exp,g_act,err);