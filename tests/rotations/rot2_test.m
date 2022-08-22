%% rot2_test.m
% Astrodynamics Toolbox
%
% Unit testing of the rot2 function.
%
% Author: Tamas Kis
% Last Update: 2022-01-05



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% TEST

% rotation angle [deg]
theta = 50;

% convert to radians
theta = theta*(pi/180);

% expected result
R2_expected = [cos(theta)   0  -sin(theta);
               0            1   0;
               sin(theta)   0   cos(theta)];

% actual result
R2_actual = rot2(theta);

% unit test
TEST_EQUAL(R2_actual,R2_expected);