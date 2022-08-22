%% jd2t_test.m
% Astrodynamics Toolbox
%
% Unit testing of the jd2t function.
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
err = 1e-7;



%% NOTE

% This example is taken from Vallado, "Fundamentals of Astrodynamics and 
% Applications", 4th Ed. (p. 188).



%% TEST

% calendar date
cal = [1992,8,20,12,14,0];

% expected result
T_exp = -0.073647919;

% actual result
MJD = cal2mjd(cal);
JD = mjd2jd(MJD);
T_act = jd2t(JD);

% unit test
TEST_EQUAL(T_act,T_exp,err);