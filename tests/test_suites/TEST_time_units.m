%% TEST_time_units.m
% Aerospace Simulation Toolbox
%
% Unit testing of the cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, 
% jd2t, mjd2cal, mjd2f, mjd2jd, and mjd2t functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-03
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

test_suite = TestSuite('time unit tests');



%% cal2doy

test_suite.add_test(TestEqual(cal2doy([2022,1,22]),22,'cal2doy for date in January'));
test_suite.add_test(TestEqual(cal2doy([2020,3,18]),78,'cal2doy for date in leap year after February'));
test_suite.add_test(TestEqual(cal2doy([2020,12,31]),366,'cal2doy for last day of year in leap year'));
test_suite.add_test(TestEqual(cal2doy([2022,1,1]),1,'cal2doy for first day of year'));
test_suite.add_test(TestEqual(cal2doy([2022,12,31]),365,'cal2doy for last day of year in non-leap year'));



%% cal2mjd

% test valid dates
test_suite.add_test(TestEqual(cal2mjd([1582,10,15,0,0,0]),-100840,'cal2mjd for 1582 October 15 00:00:00'));
test_suite.add_test(TestEqual(cal2mjd([1600,1,1,0,0,0]),-94553,'cal2mjd for 1600 January 1 00:00:00'));
test_suite.add_test(TestEqual(cal2mjd([1600,1,1,6,0,0]),-94552.75,'cal2mjd for 1600 January 1 06:00:00'));
test_suite.add_test(TestEqual(cal2mjd([1600,1,1,12,0,0]),-94552.5,'cal2mjd for 1600 January 1 12:00:00'));
test_suite.add_test(TestEqual(cal2mjd([1600,1,1,18,0,0]),-94552.25,'cal2mjd for 1600 January 1 18:00:00'));
test_suite.add_test(TestEqual(cal2mjd([1858,11,16,18,0,0]),-0.25,'cal2mjd for 1858 November 16 18:00:00'));
test_suite.add_test(TestEqual(cal2mjd([1858,11,17,0,0,0]),0,'cal2mjd for 1858 November 17 00:00:00'));
test_suite.add_test(TestEqual(cal2mjd([1858,11,17,6,0,0]),0.25,'cal2mjd for 1858 November 17 06:00:00'));
test_suite.add_test(TestEqual(cal2mjd([2000,1,1,12,0,0]),51544.5,'cal2mjd for J2000.0 epoch'));
test_suite.add_test(TestEqual(cal2mjd([2005,5,24,0,0,0]),53514,'cal2mjd for 2005 May 24 00:00:00'));
test_suite.add_test(TestEqual(cal2mjd([2006,12,19,0,0,0]),54088,'cal2mjd for 2006 December 19 00:00:00'));
test_suite.add_test(TestEqual(cal2mjd([2006,12,19,6,0,0]),54088.25,'cal2mjd for 2006 December 19 06:00:00'));
test_suite.add_test(TestEqual(cal2mjd([2006,12,19,18,0,0]),54088.75,'cal2mjd for 2006 December 19 18:00:00'));

% test invalid date
test_suite.add_test(TestError(@(cal)cal2mjd(cal),{[1582,10,14,23,59,59]},'cal2mjd for 1582 October 14 23:59:59'));



%% doy2cal

test_suite.add_test(TestEqual(doy2cal(2022,22),[2022,1,22,0,0,0],'doy2cal for date in January'));
test_suite.add_test(TestEqual(doy2cal(2020,78),[2020,3,18,0,0,0],'doy2calfor date in leap year after February'));
test_suite.add_test(TestEqual(doy2cal(2020,366),[2020,12,31,0,0,0],'doy2cal for last day of year in leap year'));
test_suite.add_test(TestEqual(doy2cal(2022,1),[2022,1,1,0,0,0],'doy2cal for first day of year'));
test_suite.add_test(TestEqual(doy2cal(2022,365),[2022,12,31,0,0,0],'doy2cal for last day of year in non-leap year'));



%% f2hms

[hh,mm,ss] = f2hms(0.524223);
test_suite.add_test(TestEqual([hh,mm,ss],[12,34,52.867199],'f2hms for 0.524223',6));



%% hms2f

test_suite.add_test(TestEqual(hms2f(12,34,52.890204),0.524223,'hms2f for 12:34:52.890204',6));



%% jd2mjd

test_suite.add_test(TestEqual(jd2mjd(0),-2400000.5,'jd2mjd for 0 JD'));
test_suite.add_test(TestEqual(jd2mjd(100),-2399900.5,'jd2mjd for 100 JD'));
test_suite.add_test(TestEqual(jd2mjd(2400000.5),0,'jd2mjd for 2400000.5 JD'));
test_suite.add_test(TestEqual(jd2mjd(2400100.5),100,'jd2mjd for 2400000.5 JD'));



%% jd2t

test_suite.add_test(TestEqual(jd2t(2448855.009722222),-0.073647919,'jd2t for 1992 August 20 12:14:00',9));



%% mjd2cal

% test valid dates
test_suite.add_test(TestEqual(mjd2cal(-100840),[1582,10,15,0,0,0],'mjd2cal for -100840 MJD'));
test_suite.add_test(TestEqual(mjd2cal(-94553),[1600,1,1,0,0,0],'mjd2cal for -94553 MJD'));
test_suite.add_test(TestEqual(mjd2cal(-94552.75),[1600,1,1,6,0,0],'mjd2cal for -94552.75 MJD'));
test_suite.add_test(TestEqual(mjd2cal(-94552.5),[1600,1,1,12,0,0],'mjd2cal for -94552.5 MJD'));
test_suite.add_test(TestEqual(mjd2cal(-94552.25),[1600,1,1,18,0,0],'mjd2cal for -94552.25 MJD'));
test_suite.add_test(TestEqual(mjd2cal(-0.25),[1858,11,16,18,0,0],'mjd2cal for -0.25 MJD'));
test_suite.add_test(TestEqual(mjd2cal(0),[1858,11,17,0,0,0],'mjd2cal for 0 MJD'));
test_suite.add_test(TestEqual(mjd2cal(0.25),[1858,11,17,6,0,0],'mjd2cal for 0.25 MJD'));
test_suite.add_test(TestEqual(mjd2cal(51544.5),[2000,1,1,12,0,0],'mjd2cal for 51544.5 MJD'));
test_suite.add_test(TestEqual(mjd2cal(53514),[2005,5,24,0,0,0],'mjd2cal for 53514 MJD'));
test_suite.add_test(TestEqual(mjd2cal(54088),[2006,12,19,0,0,0],'mjd2cal for 54088 MJD'));
test_suite.add_test(TestEqual(mjd2cal(54088.25),[2006,12,19,6,0,0],'mjd2cal for 54088.25 MJD'));
test_suite.add_test(TestEqual(mjd2cal(54088.75),[2006,12,19,18,0,0],'mjd2cal for 54088.75 MJD'));

% test invalid date
test_suite.add_test(TestError(@(mjd)mjd2cal(mjd),{-100841},'mjd2cal for MJD -100841'));



%% mjd2f

test_suite.add_test(TestEqual(mjd2f(cal2mjd([1858,11,11,15,50,24])),0.66,'mjd2f for 1858 November 11 15:50:24 (negative MJD)'));
test_suite.add_test(TestEqual(mjd2f(cal2mjd([1858,11,16,15,50,24])),0.66,'mjd2f for 1858 November 16 15:50:24 (barely negative MJD)'));
test_suite.add_test(TestEqual(mjd2f(cal2mjd([1858,11,17,16,04,48])),0.67,'mjd2f for 1858 November 17 16:04:48 (barely positive MJD)',14));
test_suite.add_test(TestEqual(mjd2f(cal2mjd([2018,7,22,16,4,48])),0.67,'mjd2f for 2018 July 22 16:04:48 (positive MJD)',11));



%% mjd2jd

test_suite.add_test(TestEqual(mjd2jd(-2400000.5),0,'mjd2jd for -2400000.5 MJD'));
test_suite.add_test(TestEqual(mjd2jd(-2399900.5),100,'mjd2jd for -2399900.5 MJD'));
test_suite.add_test(TestEqual(mjd2jd(0),2400000.5,'mjd2jd for 0 MJD'));
test_suite.add_test(TestEqual(mjd2jd(100),2400100.5,'mjd2jd for 100 MJD'));



%% mjd2t

test_suite.add_test(TestEqual(mjd2t(48854.50972222222),-0.073647919,'mjd2t for 1992 August 20 12:14:00',9));



%% RUNS TEST SUITE

test_suite.run;