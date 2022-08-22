%% pseudorange_noise_tuning.m
% Astrodynamics Toolbox
%
% Determining the delay lock loop bandwidth to get a pseudorange noise
% function similar to that of p. 79 of Giralo, "Precision Navigation of 
% Miniaturized Distributed Space Systems using GNSS".
%
% Author: Tamas Kis
% Last Update: 2022-03-21



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" functions
addpath(genpath("../toolbox"));



%% TUNING

% delay lock loop bandwidth [Hz]
B_dll = 0.01;

% carrier power to noise power ratio [dB]
CN0 = 37.5:0.1:52.5;

% converts C/N₀ to Hz
CN0_Hz = 10.^(CN0./10);

% pseudorange thermal noise standard deviations [m]
sigma_rho = (C_LIGHT/(1.023e6))*sqrt(B_dll./CN0_Hz);

% plot results
figure('Position',[540,300,700,500]);
plot(CN0,sigma_rho,'color',[0.5490,0.0824,0.0824],'linewidth',1.5);
grid on;
xlim([30,55]);
ylim([0,0.4]);
xlabel('$C/N_{0}\;[\mathrm{dB}\textrm{-}\mathrm{Hz}]$','Interpreter',...
    'latex','FontSize',18);
ylabel('$\sigma_{\rho}\;[\mathrm{m}]$','Interpreter','latex','FontSize',...
    18);