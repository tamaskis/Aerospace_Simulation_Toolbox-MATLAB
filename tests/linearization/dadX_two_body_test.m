%% dadX_two_body_test.m
% Astrodynamics Toolbox
%
% Unit testing of the dadX_two_body function.
%
% Author: Tamas Kis
% Last Update: 2022-02-28



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% TEST CONDITION

% ECEF position [m]
r_ecef = [10000;20000;30000];



%% TESTS

% function handle for gravity
g_ecef = @(r) two_body(r);

% numerical result (expected result)
dadr_kep_exp = ijacobian(g_ecef,r_ecef);

% actual result
dadr_kep_act = dadX_two_body(r_ecef);

% unit test
TEST_EQUAL(dadr_kep_act,dadr_kep_exp);