%% rot3_test.m
% Astrodynamics Toolbox
%
% Unit testing of the rot3 function.
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
R3_expected = [ cos(theta)   sin(theta)   0;
               -sin(theta)   cos(theta)   0;
                0            0            1];

% actual result
R3_actual = rot3(theta);

% unit test
TEST_EQUAL(R3_actual,R3_expected);