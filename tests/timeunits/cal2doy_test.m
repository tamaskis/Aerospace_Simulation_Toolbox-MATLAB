%% cal2doy_test.m
% Astrodynamics Toolbox
%
% Unit testing of the cal2doy function.
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

% Examples taken from
% https://www.esrl.noaa.gov/gmd/grad/neubrew/Calendar.jsp.



%% TEST

% date in January
TEST_EQUAL(cal2doy([2022,1,22]),22);

% date in leap year after February
TEST_EQUAL(cal2doy([2020,3,18]),78);

% last day of year in leap year
TEST_EQUAL(cal2doy([2020,12,31]),366);

% first day of year
TEST_EQUAL(cal2doy([2022,1,1]),1);

% last day of year in non-leap year
TEST_EQUAL(cal2doy([2022,12,31]),365);