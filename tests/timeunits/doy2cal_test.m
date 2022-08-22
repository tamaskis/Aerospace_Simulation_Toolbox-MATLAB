%% doy2cal_test.m
% Astrodynamics Toolbox
%
% Unit testing of the doy2cal function.
%
% Author: Tamas Kis
% Last Update: 2022-02-17



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
TEST_EQUAL(doy2cal(2022,22),[2022,1,22,0,0,0]);

% date in leap year after February
TEST_EQUAL(doy2cal(2020,78),[2020,3,18,0,0,0]);

% last day of year in leap year
TEST_EQUAL(doy2cal(2020,366),[2020,12,31,0,0,0]);

% first day of year
TEST_EQUAL(doy2cal(2022,1),[2022,1,1,0,0,0]);

% last day of year in non-leap year
TEST_EQUAL(doy2cal(2022,365),[2022,12,31,0,0,0]);