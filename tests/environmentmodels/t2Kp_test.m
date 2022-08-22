%% t2Kp_test.m
% Astrodynamics Toolbox
%
% Unit testing of the t2Kp function.
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
Kp_data = sw1(:,2:9);

% Gregorian date of UT1 [y,mo,d,h,m,s]
cal_UT1 = [2022,2,7,12,30,00];

% modified Julian date of UT1
MJD_UT1 = cal2mjd(cal_UT1);

% expected result
Kp_exp = 1.0;

% actual result
Kp_act = t2Kp(MJD_UT1,MJD_UT1_data,Kp_data);

% unit test
TEST_EQUAL(Kp_act,Kp_exp);