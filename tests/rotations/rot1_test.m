%% rot1_test.m
% Astrodynamics Toolbox
%
% Unit testing of the rot1 function.
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
R1_expected = [1   0            0;
               0   cos(theta)   sin(theta);
               0  -sin(theta)   cos(theta)];

% actual result
R1_actual = rot1(theta);

% unit test
TEST_EQUAL(R1_actual,R1_expected);