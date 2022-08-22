%% obtaining_J2.m
% Astrodynamics Toolbox
%
% Obtaining the J2 coefficient for Earth.
%
% Author: Tamas Kis
% Last Update: 2022-02-05



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" functions
addpath(genpath("../toolbox"));



%% SIMULATION

% load gravity coefficients
GGM05S_data = struct2array(load('GGM05S.mat'));
C_norm = GGM05S_data.C_norm;
S_norm = GGM05S_data.S_norm;

% de-normalized gravity coefficients
[C,S] = gravity_coeffs(C_norm,S_norm);

% J2 = negative of second zonal harmonic
format long;
J2 = -C(2,0)
format short;