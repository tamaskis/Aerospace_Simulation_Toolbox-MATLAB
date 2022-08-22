%% klobuchar_coeffs_test.m
% Astrodynamics Toolbox
%
% Testing of the klobuchar_coeffs_test function (checking to make sure
% plots are the same as in Lee et al., "Generation of Klobuchar 
% Coefficients for Ionospheric Error Simulation".
%
% Author: Tamas Kis
% Last Update: 2022-03-21



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" and testing functions
addpath(genpath('../../toolbox'));
addpath('..');



%% TEST

t = 2006:0.01:2009;
alpha = zeros(4,length(t));
beta = zeros(4,length(t));
for i = 1:length(t)
    [alpha(:,i),beta(:,i)] = klobuchar_coeffs(t(i));
end

figure;plot(t,alpha(1,:));ylim([4e-9,14e-9]);yticks(4e-9:2e-9:14e-9);
% figure;plot(t,alpha(2,:))
% figure;plot(t,alpha(3,:))
% figure;plot(t,alpha(4,:))
% 
% figure;plot(t,beta(1,:))
% figure;plot(t,beta(2,:))
% figure;plot(t,beta(3,:))
% figure;plot(t,beta(4,:))