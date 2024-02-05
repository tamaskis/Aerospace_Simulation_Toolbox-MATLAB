%% TEST_angles.m
% Aerospace Simulation Toolbox
%
% Unit testing of the arcsec2deg, arcsec2rad, deg2arcsec, deg2rad, 
% rad2arcsec, and rad2deg functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-04
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

test_suite = TestSuite('angle tests');



%% arcsec2deg

test_suite.add_test(TestEqual(arcsec2deg(23456),6.515555555555555,'arcsec2deg for 23456"'));
test_suite.add_test(TestEqual(arcsec2deg(19555.56),5.4321,'arcsec2deg for 19555.56"'));



%% arcsec2rad

test_suite.add_test(TestEqual(arcsec2rad(20000),0.096962736221907,'arcsec2rad for 20000"',15));
test_suite.add_test(TestEqual(arcsec2rad(20626.48062470964),0.1,'arcsec2rad for 20626.48062470964"',15));



%% deg2arcsec

test_suite.add_test(TestEqual(deg2arcsec(5.4321),19555.56,'deg2arcsec for 5.4321°'));
test_suite.add_test(TestEqual(deg2arcsec(6.515555555555555),23456,'deg2arcsec for 6.515555555555555°'));



%% deg2dms

[d,m,s] = deg2dms(-35.264897);
test_suite.add_test(TestEqual([d,m,s],[-35,-15,-53.63],'deg2dms for -35.264897°',3));



%% deg2rad

test_suite.add_test(TestEqual(deg2rad(-45),-pi/4,'deg2rad for -45°'));
test_suite.add_test(TestEqual(deg2rad(0),0,'deg2rad for 0°'));
test_suite.add_test(TestEqual(deg2rad(45),pi/4,'deg2rad for 45°'));
test_suite.add_test(TestEqual(deg2rad(360),2*pi,'deg2rad for 360°'));
test_suite.add_test(TestEqual(deg2rad(720),4*pi,'deg2rad for 720°'));


%% dms2deg

test_suite.add_test(TestEqual(dms2deg(-35,-15,-53.63),-35.264897,'dms2deg for -35° -15 arcmin -53.63 arcsec',6));



%% dms2rad

test_suite.add_test(TestEqual(dms2rad(-35,-15,-53.63),-0.6154886,'dms2rad for -35° -15 arcmin -53.63 arcsec',7));



%% rad2arcsec

test_suite.add_test(TestEqual(rad2arcsec(0.1),20626.48062470964,'rad2arcsec for 0.1 rad'));
test_suite.add_test(TestEqual(rad2arcsec(0.096962736221907),20000,'rad2arcsec for 0.096962736221907 rad',10));



%% rad2deg

test_suite.add_test(TestEqual(rad2deg(-pi/4),-45,'rad2deg for -π/4'));
test_suite.add_test(TestEqual(rad2deg(0),0,'rad2deg for 0'));
test_suite.add_test(TestEqual(rad2deg(pi/4),45,'rad2deg for π/4'));
test_suite.add_test(TestEqual(rad2deg(2*pi),360,'rad2deg for 2π'));
test_suite.add_test(TestEqual(rad2deg(4*pi),720,'rad2deg for 4π-pi/4'));



%% rad2dms

[d,m,s] = rad2dms(-0.6154886);
test_suite.add_test(TestEqual([d,m,s],[-35,-15,-53.63],'rad2dms for -0.6154886°',2));



%% RUNS TEST SUITE

test_suite.run;