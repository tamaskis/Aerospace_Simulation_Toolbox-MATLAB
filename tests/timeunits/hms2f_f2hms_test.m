%% hms2f_f2hms_test.m
% Astrodynamics Toolbox
%
% Unit testing of the hms2f and f2hms functions.
%
% Author: Tamas Kis
% Last Update: 2022-01-22



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 1e-10;



%% TEST FUNCTIONALITY

% time
hh = 12;
mm = 34;
ss = 52.8902;

% conversion loop
[hh_result,mm_result,ss_result] = f2hms(hms2f(hh,mm,ss));

% test equality
TEST_EQUAL([hh_result,mm_result,ss_result],[hh,mm,ss],err);