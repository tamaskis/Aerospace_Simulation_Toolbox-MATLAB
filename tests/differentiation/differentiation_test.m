%% differentiation_test.m
% Astrodynamics Toolbox
%
% Unit testing for complex-step differentiation of astrodynamics functions.
%
% Author: Tamas Kis
% Last Update: 2022-02-05



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% TESTING DIFFERENTIATION OF M2E

% eccentricity
e = 0.2;

% mean and eccentric anomalies [rad]
M = pi/4;
E = M2E(M,e);

% function to differentiate
f = @(M) M2E(M,e);

% expected (true) derivative
dEdM_exp = 1/(1-e*cos(E));

% actual (approximated) derivative
dEdM_act = iderivative(f,M);

% unit test
TEST_EQUAL(dEdM_act,dEdM_exp);