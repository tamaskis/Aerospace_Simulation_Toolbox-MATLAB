%% gravity_coeffs_test.m
% Astrodynamics Toolbox
%
% Unit testing of the gravity_coeffs function.
%
% Author: Tamas Kis
% Last Update: 2022-02-15



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');

% relative error tolerance
err = 1e-3;



%% NOTE

% These test cases are adapted from Vallado, "Fundamentals of Astrodynamics 
% and Applications", 4th Ed. (pp. 547, 1040). Note that they use a 
% different gravity model, hence the error tolerance defined above.



%% LOAD DATA/FUNCTIONS

% load gravity coefficients
GGM05S = load_GGM05S;
C_norm = GGM05S.C_norm;
S_norm = GGM05S.S_norm;

% de-normalized gravity coefficients
[C,S] = gravity_coeffs(C_norm,S_norm);



%% TESTS OF C COEFFICIENTS

% negative of second zonal harmonic should equal J2
TEST_EQUAL(-C(2,0),J2_EARTH);

% n = 4, m = 1
TEST_EQUAL(C(4,1),-5.08643560439584e-7,err);

% n = 41, m = 4
TEST_EQUAL(C(41,4),-7.19967819600023e-15,err);



%% TESTS OF S COEFFICIENTS

% n = 4, m = 1
TEST_EQUAL(S(4,1),-4.49265432143808e-7,err);

% n = 41, m = 4
TEST_EQUAL(S(41,4),1.63027868851955e-14,err);