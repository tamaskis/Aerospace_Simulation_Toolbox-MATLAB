%% cal2mjd_test.m
% Astrodynamics Toolbox
%
% Unit testing of the cal2mjd function.
%
% Author: Tamas Kis
% Last Update: 2022-01-22



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% NOTE

% The test corresponds to the J2000 epoch.



%% TEST

% calendar date of J2000 epoch
cal = [2000,1,1,12,0,0];

% expected result
MJD_exp = 51544.5;

% actual result
MJD_act = cal2mjd(cal);

% unit test
TEST_EQUAL(MJD_act,MJD_exp);