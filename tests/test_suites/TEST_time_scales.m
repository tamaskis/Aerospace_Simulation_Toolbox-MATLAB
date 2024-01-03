%% TEST_time_scales.m
% Aerospace Simulation Toolbox
%
% Unit testing of the get_dat and get_dut1 functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-05-07
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



%% get_dat

% tests dates contained in data range
test_suite.add_test(TestEqual(get_dat(cal2mjd([1972,1,1,0,0,0])),10,'ΔAT for 1972 January 1'));
test_suite.add_test(TestEqual(get_dat(cal2mjd([1972,6,30,0,0,0])),10,'ΔAT for 1972 June 30'));
test_suite.add_test(TestEqual(get_dat(cal2mjd([1972,7,1,0,0,0])),11,'ΔAT for 1972 July 1'));
test_suite.add_test(TestEqual(get_dat(cal2mjd([2005,1,1,0,0,0])),32,'ΔAT for 2005 January 1'));
test_suite.add_test(TestEqual(get_dat(cal2mjd([2005,1,2,0,0,0])),32,'ΔAT for 2005 January 2'));
test_suite.add_test(TestEqual(get_dat(cal2mjd([2005,12,31,0,0,0])),32,'ΔAT for 2005 December 31'));
test_suite.add_test(TestEqual(get_dat(cal2mjd([2006,1,1,0,0,0])),33,'ΔAT for 2006 January 1'));

% tests dates outside of data range
test_suite.add_test(TestEqual(get_dat(cal2mjd([1971,12,31,0,0,0])),10,'ΔAT for 1971 December 31'));
test_suite.add_test(TestEqual(get_dat(cal2mjd([1900,1,1,0,0,0])),10,'ΔAT for 1900 January 1'));
test_suite.add_test(TestEqual(get_dat(cal2mjd([2017,1,2,0,0,0])),37,'ΔAT for 2017 January 2'));
test_suite.add_test(TestEqual(get_dat(cal2mjd([2023,5,7,0,0,0])),37,'ΔAT for 2023 May 7'));



%% get_dut1

% tests dates contained in data range
test_suite.add_test(TestEqual(get_dut1(cal2mjd([1992,1,1,0,0,0])),-0.1251659,'ΔUT1 for 1992 January 1'));
test_suite.add_test(TestEqual(get_dut1(cal2mjd([2004,7,25,0,0,0])),-0.4573568,'ΔUT1 for 2004 July 25'));
test_suite.add_test(TestEqual(get_dut1(cal2mjd([2017,12,23,0,0,0])),0.2252297,'ΔUT1 for 2017 December 23'));

% tests date outside of data range
test_suite.add_test(TestEqual(get_dut1(cal2mjd([1991,12,31,0,0,0])),-0.1251659,'ΔUT1 for 1991 December 31'));



%% RUNS TEST SUITE

test_suite.run;