%% eci2rtn_test.m
% Astrodynamics Toolbox
%
% Unit testing of the eci2rtn function.
%
% Author: Tamas Kis
% Last Update: 2022-03-13



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 1e-3;



%% NOTE

% This test case is adapted from Curtis, "Orbital Mechanics for Engineering
% Students", 3rd Ed. (pp. 373-374).



%% TEST CONDITIONS

% chief ECI state [km][km/s]
rc_eci = [-266.77;
           3865.8;
           5426.2];
vc_eci = [-6.4836;
          -3.6198;
           2.4156];
Xc = [rc_eci;
      vc_eci];

% deputy ECI state [km][km/s]
rd_eci = [-5890.7;
          -2979.8;
           1792.2];
vd_eci = [ 0.93583;
          -5.2403;
          -5.5009];
Xd = [rd_eci;
      vd_eci];



%% TEST

% expected results
dX_exp = [-6701.2;
           6828.3;
          -406.26;
           0.31667;
           0.11199;
           1.2470];

% actual results
dX_act = eci2rtn(Xc,Xd);

% unit tests
TEST_EQUAL(dX_act,dX_exp,err);