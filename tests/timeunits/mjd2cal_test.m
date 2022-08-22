%% mjd2cal_test.m
% Astrodynamics Toolbox
%
% Unit testing of the mjd2cal function.
%
% Author: Tamas Kis
% Last Update: 2022-01-22



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 1e-7;



%% NOTE

% The test corresponds to the J2000 epoch.



%% TEST

% MJD of J2000 epoch
MJD = 51544.5;

% expected result
cal_exp = [2000,1,1,12,0,0];

% actual result
cal_act = mjd2cal(MJD);

% unit test
TEST_EQUAL(cal_act,cal_exp);