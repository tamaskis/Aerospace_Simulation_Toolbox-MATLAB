%% legendre_recursion_test.m
% Astrodynamics Toolbox
%
% Unit testing of the legendre_recursion function.
%
% Author: Tamas Kis
% Last Update: 2022-03-02



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% TEST CONDITIONS

% ECEF position [m]
rX = 10000000;
rY = 20000000;
rZ = 30000000;
r_ecef = [rX;rY;rZ];

% magnitude of position vector
r = norm(r_ecef);

% Earth radius [m]
R = 6378136.3;



%% TEST

% initialize
V00 = R/r;
W00 = 0;
V01 = 0;

% coefficients for n ≠ m
nm_term1 = @(n,m) ((2*n-1)/(n-m))*(rZ*R/r^2);
nm_term2 = @(n,m) ((n+m-1)/(n-m))*(R/r)^2;

% coefficients for n = m
mm_term1 = @(m) (2*m-1)*(rX*R/r^2);
mm_term2 = @(m) (2*m-1)*(rY*R/r^2);

% zonal V terms
V10 = nm_term1(1,0)*V00;
V20 = nm_term1(2,0)*V10-nm_term2(2,0)*V00;
V30 = nm_term1(3,0)*V20-nm_term2(3,0)*V10;
V40 = nm_term1(4,0)*V30-nm_term2(4,0)*V20;
V50 = nm_term1(5,0)*V40-nm_term2(5,0)*V30;

% zonal W terms
W10 = nm_term1(1,0)*W00;
W20 = nm_term1(2,0)*W10-nm_term2(2,0)*W00;
W30 = nm_term1(3,0)*W20-nm_term2(3,0)*W10;
W40 = nm_term1(4,0)*W30-nm_term2(4,0)*W20;
W50 = nm_term1(5,0)*W40-nm_term2(5,0)*W30;

% sectorial terms
V11 = mm_term1(1)*V00-mm_term2(1)*W00;
W11 = mm_term1(1)*W00+mm_term2(1)*V00;
V22 = mm_term1(2)*V11-mm_term2(2)*W11;
W22 = mm_term1(2)*W11+mm_term2(2)*V11;
V33 = mm_term1(3)*V22-mm_term2(3)*W22;
W33 = mm_term1(3)*W22+mm_term2(3)*V22;
V44 = mm_term1(4)*V33-mm_term2(4)*W33;
W44 = mm_term1(4)*W33+mm_term2(4)*V33;
V55 = mm_term1(5)*V44-mm_term2(5)*W44;
W55 = mm_term1(5)*W44+mm_term2(5)*V44;

% tesseral terms
V21 = nm_term1(2,1)*V11-nm_term2(2,1)*V01;
V31 = nm_term1(3,1)*V21-nm_term2(3,1)*V11;
V41 = nm_term1(4,1)*V31-nm_term2(4,1)*V21;
V51 = nm_term1(5,1)*V41-nm_term2(5,1)*V31;



%% UNIT TESTS

[V_act,W_act] = legendre_recursion(r_ecef,R,5);

% zonal V terms
TEST_EQUAL(V_act(0,0),V00);
TEST_EQUAL(V_act(1,0),V10);
TEST_EQUAL(V_act(2,0),V20);
TEST_EQUAL(V_act(3,0),V30);
TEST_EQUAL(V_act(4,0),V40);

% zonal W terms
TEST_EQUAL(W_act(0,0),W00);
TEST_EQUAL(W_act(1,0),W10);
TEST_EQUAL(W_act(2,0),W20);
TEST_EQUAL(W_act(3,0),W30);
TEST_EQUAL(W_act(4,0),W40);

% sectorial terms
TEST_EQUAL(V_act(1,1),V11);
TEST_EQUAL(W_act(1,1),W11);
TEST_EQUAL(V_act(2,2),V22);
TEST_EQUAL(W_act(2,2),W22);
TEST_EQUAL(V_act(3,3),V33);
TEST_EQUAL(W_act(3,3),W33);
TEST_EQUAL(V_act(4,4),V44);
TEST_EQUAL(W_act(4,4),W44);
TEST_EQUAL(V_act(5,5),V55);
TEST_EQUAL(W_act(5,5),W55);

% tesseral terms
TEST_EQUAL(V_act(2,1),V21);
TEST_EQUAL(V_act(3,1),V31);
TEST_EQUAL(V_act(4,1),V41);
TEST_EQUAL(V_act(5,1),V51);