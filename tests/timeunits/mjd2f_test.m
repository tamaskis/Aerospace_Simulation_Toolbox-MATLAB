%% mjd2f_test.m
% Astrodynamics Toolbox
%
% Unit testing of the mjd2f function.
%
% Author: Tamas Kis
% Last Update: 2022-02-17



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 1e-7;



%% TESTS

TEST_EQUAL(mjd2f(58321.67),0.67,err);
TEST_EQUAL(mjd2f(-5.34),0.34);
TEST_EQUAL(mjd2f(0.67),0.67);
TEST_EQUAL(mjd2f(-0.34),0.34);