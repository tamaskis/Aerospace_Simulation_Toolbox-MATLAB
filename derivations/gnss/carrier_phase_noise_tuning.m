%% carrier_phase_noise_tuning.m
% Astrodynamics Toolbox
%
% Determining the phase lock loop bandwidth to get a carrier phase noise
% function similar to that of p. 80 of Giralo, "Precision Navigation of 
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

% phase lock loop bandwidth [Hz]
B_pll = 1.6e13;

% carrier power to noise power ratio [dB]
CN0 = 37.5:0.1:52.5;

% converts C/N₀ to Hz
CN0_Hz = 10.^(CN0./10);

% carrier phase thermal noise standard deviations [m]
sigma_Phi = (C_LIGHT/(2*pi*F_L1))*sqrt(B_pll./CN0_Hz);

% converts carrier phase thermal noise standard deviations to mm
sigma_Phi = 0.001*sigma_Phi;

% plot results
figure('Position',[540,300,700,500]);
plot(CN0,sigma_Phi,'color',[0.5490,0.0824,0.0824],'linewidth',1.5);
grid on;
xlim([30,55]);
ylim([0,1.6]);
xlabel('$C/N_{0}\;[\mathrm{dB}\textrm{-}\mathrm{Hz}]$','Interpreter',...
    'latex','FontSize',18);
ylabel('$\sigma_{\Phi}\;[\mathrm{mm}]$','Interpreter','latex',...
    'FontSize',18);