%% get_DUT1_test.m
% Astrodynamics Toolbox
%
% Unit testing of the get_DUT1 function.
%
% Author: Tamas Kis
% Last Update: 2022-02-14



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% NOTE

% These tests were randomly selected from 
% https://datacenter.iers.org/data/html/finals2000A.data.html.



%% TEST OF DATES CONTAINED IN DATA RANGE

% 1992 January 1
TEST_EQUAL(get_DUT1(cal2mjd([1992,1,1,0,0,0])),-0.1251659);

% 2004 July 25
TEST_EQUAL(get_DUT1(cal2mjd([2004,7,25,0,0,0])),-0.4573568);

% 2017 December 23
TEST_EQUAL(get_DUT1(cal2mjd([2017,12,23,0,0,0])),0.2252297);



%% TEST OF DATES OUTSIDE OF DATA RANGE

% error expected for 1991 December 31
TEST_ERROR(@(MJD_UTC)get_DUT1(MJD_UTC),cal2mjd([1991,12,31,0,0,0]));

% error expected for 2030 January 1
TEST_ERROR(@(MJD_UTC)get_DUT1(MJD_UTC),cal2mjd([2030,1,1,0,0,0]));