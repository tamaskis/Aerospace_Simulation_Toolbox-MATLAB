%% moon_position_test.m
% Astrodynamics Toolbox
%
% Unit testing of the moon_position function.
%
% Author: Tamas Kis
% Last Update: 2022-02-19



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 0.0001;



%% NOTE

% This example is taken from Vallado, "Fundamentals of Astrodynamics and 
% Applications", 4th Ed., Example 5-3 (pp. 288-289). However, while the 
% results in the book are close to the ones obtained by this function, they
% do not match exactly. Upon closer inspection, the results in the book are
% slightly incorrect (the results of the calculations in the book are
% slightly off).



%% TEST

% UTC
cal_UTC = [1994,4,28,0,0,0];
MJD_UTC = cal2mjd(cal_UTC);

% UT1
DUT1 = get_DUT1(MJD_UTC);
MJD_UT1 = utc2ut1(MJD_UTC,DUT1);

% TT
DAT = get_DAT(MJD_UTC);
MJD_TAI = utc2tai(MJD_UTC,DAT);
MJD_TT = tai2tt(MJD_TAI);

% obliquity of the ecliptic [rad]
epsilon = obliquity(MJD_TT);

% expected result [km]
r_moon_expected = [-134240.626;
                   -311571.590;
                   -126693.785];

% actual result [m]
r_moon_actual = moon_position(MJD_UT1,epsilon);

% convert actual result to km
r_moon_actual = r_moon_actual/1000;

% unit test
TEST_EQUAL(r_moon_actual,r_moon_expected,err);