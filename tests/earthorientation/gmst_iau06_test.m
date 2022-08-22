%% gmst_iau06_test.m
% Astrodynamics Toolbox
%
% Unit testing of the gmst_iau06 function.
%
% Author: Tamas Kis
% Last Update: 2022-03-12



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% NOTE

% This test case is adapted from Vallado, "Fundamentals of Astrodynamics
% and Applications", 4th Ed. (p. 288).



%% TEST CONDITIONS

% UT1 [y,mo,d,h,m,s]
cal_UT1 = [1992,8,20,12,14,0];

% modified Julian date of UT1
MJD_UT1 = cal2mjd(cal_UT1);



%% TEST

% expected result
GMST_exp = 2.663002385087932;

% actual results
GMST_act = gmst_iau06(MJD_UT1);

% unit tests
TEST_EQUAL(GMST_act,GMST_exp)