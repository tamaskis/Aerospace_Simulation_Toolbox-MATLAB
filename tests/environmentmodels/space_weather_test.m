%% space_weather_test.m
% Astrodynamics Toolbox
%
% Unit testing of the space_weather function.
%
% Author: Tamas Kis
% Last Update: 2022-02-19



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% NOTE

% The test case for the valid date was assembled manually from the
% following sources:
%   • https://celestrak.com/SpaceData/SpaceWx-format.php
%   • https://sol.spacenvironment.net/jb2008/indices/SOLFSMY.TXT
%   • https://sol.spacenvironment.net/jb2008/indices/DTCFILE.TXT


%% TEST FOR VALID DATE

% modified Julian date of 2006 April 5 12:30:00 UT1
MJD_UT1 = cal2mjd([2006,4,5,12,30,0]);

% load all space weather data
[sw1,sw2] = load_sw;

% generate space weather data for atmospheric models
sw = space_weather(MJD_UT1,sw1,sw2,'Jacchia-Bowman 2008');

% extract "actual" results
ap_array_act = sw.ap_array;
dTc_act = sw.dTc;
F107_act = sw.F107;
F107_avg_act = sw.F107_avg;
Kp_act = sw.Kp;
M107_act = sw.M107;
M107_avg_act = sw.M107_avg;
S107_act = sw.S107;
S107_avg_act = sw.S107_avg;
Y107_act = sw.Y107;
Y107_avg_act = sw.Y107_avg;

% define "expected" results
ap_array_exp = [29,56,27,27,39,mean([22,18,12,9,6,7,6,2]),mean([2,3,2,3,...
    2,2,0,0])];
dTc_exp = 145;
F107_exp = 99.5;
F107_avg_exp = 81.9;
Kp_exp = 40/10;
M107_exp = 88.4;
M107_avg_exp = 83.3;
S107_exp = 86.1;
S107_avg_exp = 84.4;
Y107_exp = 88.3;
Y107_avg_exp = 81.6;

% unit tests
TEST_EQUAL(ap_array_act,ap_array_exp);
TEST_EQUAL(dTc_act,dTc_exp);
TEST_EQUAL(F107_act,F107_exp);
TEST_EQUAL(F107_avg_act,F107_avg_exp);
TEST_EQUAL(Kp_act,Kp_exp);
TEST_EQUAL(M107_act,M107_exp);
TEST_EQUAL(M107_avg_act,M107_avg_exp);
TEST_EQUAL(S107_act,S107_exp);
TEST_EQUAL(S107_avg_act,S107_avg_exp);
TEST_EQUAL(Y107_act,Y107_exp);
TEST_EQUAL(Y107_avg_act,Y107_avg_exp);



%% TESTS FOR ISSUES WITH DATES

% function handle for testing
f = @(MJD_UT1,sw1,sw2,model) space_weather(MJD_UT1,sw1,sw2,model);

% -------------------------------------
% Dates not included in "sw2" data set.
% -------------------------------------

% error expected for 2022 February 10 00:00:00 UT1, Jacchia-Bowman 2008
%   --> date valid for "sw1" data
%   --> date out of bounds for "sw2" data
%   --> both sets of data needed for Jacchia-Bowman 2008
%   -- NOTE: THE DATE FOR THIS TEST CASE WILL NEEDED UPDATING
MJD_UT1 = cal2mjd([2022,2,10,0,0,0]);
TEST_ERROR(f,MJD_UT1,sw1,sw2,'Jacchia-Bowman 2008');

% error NOT expected for 2022 February 10 00:00:00 UT1, NRLMSISE-00
%   --> date valid for "sw1" data
%   --> date out of bounds for "sw2" data
%   --> only "sw1" data needed for NRLMSISE-00
%   -- NOTE: THE DATE FOR THIS TEST CASE WILL NEEDED UPDATING
MJD_UT1 = cal2mjd([2022,2,1,0,0,0]);
TEST_NO_ERROR(f,MJD_UT1,sw1,sw2,'NRLMSISE-00');

% error expected for 1960 January 1 00:00:00 UT1, Jacchia-Bowman 2008
%   --> date valid for "sw1" data
%   --> date out of bounds for "sw2" data
%   --> both sets of data needed for Jacchia-Bowman 2008
MJD_UT1 = cal2mjd([1960,1,1,0,0,0]);
TEST_ERROR(f,MJD_UT1,sw1,sw2,'Jacchia-Bowman 2008');

% error expected for 1960 January 1 00:00:00 UT1, NRLMSISE-00 2008
%   --> date valid for "sw1" data
%   --> date out of bounds for "sw2" data
%   --> only "sw1" data needed for NRLMSISE-00
MJD_UT1 = cal2mjd([1960,1,1,0,0,0]);
f(MJD_UT1,sw1,sw2,'NRLMSISE-00');
TEST_NO_ERROR(f,MJD_UT1,sw1,sw2,'NRLMSISE-00');

% -------------------------------------
% Dates not included in both data sets.
% -------------------------------------

% error expected for 1950 January 1 00:00:00 UT1, NRLMSISE-00
%   --> date out of bounds for "sw1" data
%   --> date out of bounds for "sw2" data
%   --> both sets of data needed for Jacchia-Bowman 2008
MJD_UT1 = cal2mjd([1950,1,1,0,0,0]);
TEST_ERROR(f,MJD_UT1,sw1,sw2,'NRLMSISE-00');

% error expected for 2050 January 1 00:00:00 UT1, NRLMSISE-00
%   --> date out of bounds for "sw1" data
%   --> date out of bounds for "sw2" data
%   --> both sets of data needed for Jacchia-Bowman 2008
MJD_UT1 = cal2mjd([2050,1,1,0,0,0]);
TEST_ERROR(f,MJD_UT1,sw1,sw2,'NRLMSISE-00');

% error NOT expected for 1950 January 1 00:00:00 UT1, Harris-Priester
%   --> date out of bounds for "sw1" data
%   --> date out of bounds for "sw2" data
%   --> neither sets of data needed for Harris-Priester
MJD_UT1 = cal2mjd([1950,1,1,0,0,0]);
TEST_NO_ERROR(f,MJD_UT1,sw1,sw2,'Harris-Priester');

% error NOT expected for 2050 January 1 00:00:00 UT1, Harris-Priester
%   --> date out of bounds for "sw1" data
%   --> date out of bounds for "sw2" data
%   --> neither sets of data needed for Harris-Priester
MJD_UT1 = cal2mjd([2050,1,1,0,0,0]);
TEST_NO_ERROR(f,MJD_UT1,sw1,sw2,'Harris-Priester');