%% rot313_test.m
% Astrodynamics Toolbox
%
% Unit testing of the rot313 function.
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

% rotation angles [deg]
psi = 30;
theta = 40;
phi = 50;

% convert to radians
psi = psi*(pi/180);
theta = theta*(pi/180);
phi = phi*(pi/180);

% expected result
R313_expected = rot3(phi)*rot1(theta)*rot3(psi);

% actual result
R313_actual = rot313(psi,theta,phi);

% unit test
TEST_EQUAL(R313_actual,R313_expected);