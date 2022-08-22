%% get_DAT_test.m
% Astrodynamics Toolbox
%
% Unit testing of the get_DAT function.
%
% Author: Tamas Kis
% Last Update: 2022-02-14



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% TEST OF DATES CONTAINED IN DATA RANGE

% 1972 January 1
TEST_EQUAL(get_DAT(cal2mjd([1972,1,1,0,0,0])),10);

% 1972 June 30
TEST_EQUAL(get_DAT(cal2mjd([1972,6,30,0,0,0])),10);

% 1972 July 1
TEST_EQUAL(get_DAT(cal2mjd([1972,7,1,0,0,0])),11);

% 2005 January 1
TEST_EQUAL(get_DAT(cal2mjd([2005,1,1,0,0,0])),32);

% 2005 January 2
TEST_EQUAL(get_DAT(cal2mjd([2005,1,2,0,0,0])),32);

% 2005 December 31
TEST_EQUAL(get_DAT(cal2mjd([2005,12,31,0,0,0])),32);

% 2006 January 1
TEST_EQUAL(get_DAT(cal2mjd([2006,1,1,0,0,0])),33);

% 2022 January 22
TEST_EQUAL(get_DAT(cal2mjd([2022,1,22,0,0,0])),37);



%% TEST OF DATE OUTSIDE OF DATA RANGE

% error expected for 1971 December 31
TEST_ERROR(@(MJD_UTC)get_DAT(MJD_UTC),cal2mjd([1971,12,31,0,0,0]));