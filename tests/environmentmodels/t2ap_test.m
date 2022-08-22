%% t2ap_test.m
% Astrodynamics Toolbox
%
% Unit testing of the t2ap function.
%
% Author: Tamas Kis
% Last Update: 2022-02-19



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% TEST

% load 1st half of space weather data
sw1 = load_sw;

% UT1 for each data entry [MJD]
MJD_UT1_data = sw1(:,1);

% planetary amplitude data [γ]
ap_data = sw1(:,10:17);

% Gregorian date of UT1 [y,mo,d,h,m,s]
cal_UT1 = [2022,2,7,12,30,00];

% modified Julian date of UT1
MJD_UT1 = cal2mjd(cal_UT1);

% expected result
ap_exp = 4;

% actual result
ap_act = t2ap(MJD_UT1,MJD_UT1_data,ap_data);

% unit test
TEST_EQUAL(ap_act,ap_exp);