%% TEST_time_scales.m
% Aerospace Simulation Toolbox
%
% Unit testing of the get_DAT and get_DUT1 functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-01
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% DEPENDENCIES:
%   • Simple Unit Testing Toolbox (https://tamaskis.github.io/Simple_Unit_Testing_Toolbox-MATLAB)
%   • Aerospace Simulation Toolbox (https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/)



%% SCRIPT SETUP

% clears Workspace and closes all figures
clear; close all;



%% INITIALIZE TEST SUITE

test_suite = TestSuite('time scale tests');



%% get_DAT

% test of dates contained in data range
test_suite.add_test(TestEqual(get_DAT(cal2mjd([1972,1,1,0,0,0])),10,'ΔAT for 1972 January 1'));
test_suite.add_test(TestEqual(get_DAT(cal2mjd([1972,6,30,0,0,0])),10,'ΔAT for 1972 June 30'));
test_suite.add_test(TestEqual(get_DAT(cal2mjd([1972,7,1,0,0,0])),11,'ΔAT for 1972 July 1'));
test_suite.add_test(TestEqual(get_DAT(cal2mjd([2005,1,1,0,0,0])),32,'ΔAT for 2005 January 1'));
test_suite.add_test(TestEqual(get_DAT(cal2mjd([2005,1,2,0,0,0])),32,'ΔAT for 2005 January 2'));
test_suite.add_test(TestEqual(get_DAT(cal2mjd([2005,12,31,0,0,0])),32,'ΔAT for 2005 December 31'));
test_suite.add_test(TestEqual(get_DAT(cal2mjd([2006,1,1,0,0,0])),33,'ΔAT for 2006 January 1'));
test_suite.add_test(TestEqual(get_DAT(cal2mjd([2022,1,22,0,0,0])),37,'ΔAT for 2022 January 22'));

% test of date outside of data range
test_suite.add_test(TestError(@(MJD_UTC)get_DAT(MJD_UTC),{cal2mjd([1971,12,31,0,0,0])},'Error for ΔAT for 1971 December 31'));



%% get_DUT1

% TODO: These tests were randomly selected from 
% https://datacenter.iers.org/data/html/finals2000A.data.html.

% test of dates contained in data range
test_suite.add_test(TestEqual(get_DUT1(cal2mjd([1992,1,1,0,0,0])),-0.1251659,'ΔUT1 for 1992 January 1'));
test_suite.add_test(TestEqual(get_DUT1(cal2mjd([2004,7,25,0,0,0])),-0.4573568,'ΔUT1 for 2004 July 25'));
test_suite.add_test(TestEqual(get_DUT1(cal2mjd([2017,12,23,0,0,0])),0.2252297,'ΔUT1 for 2017 December 23'));

% test of date outside of data range
test_suite.add_test(TestError(@(MJD_UTC)get_DUT1(MJD_UTC),{cal2mjd([1991,12,31,0,0,0])},'Error for ΔUT1 for 1991 December 31'));
test_suite.add_test(TestError(@(MJD_UTC)get_DUT1(MJD_UTC),{cal2mjd([2030,1,1,0,0,0])},'Error for ΔUT1 for 2030 January 1'));



%% RUNS TEST SUITE

test_suite.run;