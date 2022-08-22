%% jacchia_bowman_2008_test.m
% Astrodynamics Toolbox
%
% Unit testing of the jacchia_bowman_2008 function.
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

% This test is adapted from the "test_JB2008.m" script by Mahooti, which
% can be found at:
%   https://www.mathworks.com/matlabcentral/fileexchange/56163-jacchia-bowman-atmospheric-density-model?s_tid=srchtitle
%
% Note that the in "test_JB2008.m", the days solar indices appear to be off
% by one day (i.e. 2-day lag used instead of 1-day lag, 6-day lag used
% instead of 5-day lag, etc.). The solar parameters are similar for the
% days in question, so this does not cause a major discrepancy in the
% computed density. "test_JB2008.m" yields a density of 
% 2.44632918571114e-12 kg/m^3, a temperature of 971.751061869608 K, and an
% exospheric temperature of 983.156312097745 K.



%% TEST CONDITIONS

% ------
% Epoch.
% ------

% year [y] and day of year [d]
YYYY = 2001;
DOY = 200;

% UT1 [y,mo,d,h,m,s]
cal_UT1 = doy2cal(YYYY,DOY);

% UT1 [MJD]
MJD_UT1 = cal2mjd(cal_UT1);

% --------------
% ECEF position.
% --------------

% geodetic latitude [deg], longitude [deg], and altitude [m]
lat = rad2deg(-1.22173047639603);
lon = rad2deg(6.22835493307531);
h = 400*1000;

% ECEF position [m]
r_ecef = geod2ecef(lat,lon,h);

% -------------
% Sun position.
% -------------

% assume TT approximately UT1
MJD_TT = MJD_UT1;

% Sun position resolved in ECI frame [m]
r_sun_eci = sun_position(MJD_UT1,MJD_TT);

% --------------
% Space weather.
% --------------

% load space weather data
[sw1,sw2] = load_sw;

% extract relevant data
sw = space_weather(MJD_UT1,sw1,sw2,'Jacchia-Bowman 2008');



%% TEST

% expected result [kg/m^3]
rho_exp = 2.499714503452761e-12;

% actual result [kg/m^3]
[rho_act,T_act] = jacchia_bowman_2008(r_ecef,r_sun_eci,MJD_UT1,sw.F107,...
    sw.F107_avg,sw.S107,sw.S107_avg,sw.M107,sw.M107_avg,sw.Y107,...
    sw.Y107_avg,sw.dTc);

% unit test
TEST_EQUAL(rho_act,rho_exp);