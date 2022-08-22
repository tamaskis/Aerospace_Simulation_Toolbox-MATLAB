%% CN0_vs_El.m
% Astrodynamics Toolbox
%
% Obtaining an approximate relationship between C/N0 and elevation angle.
%
% Author: Tamas Kis
% Last Update: 2022-03-21



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" functions
addpath(genpath("../toolbox"));



%% DERIVATION

% data
El = [0,15,30,45,60,75,90];
CN0 = [25,35,40,42.5,43.5,44.25,45];

% least-squares fit
[c,r2,eqn] = lsqcurvefit_approx(El,CN0,'poly',4)

% initialize the domain and evaluate the fit over that domain
El_fit = min(El):((max(El)-min(El))/1000):max(El);
CN0_fit = c(1)+c(2)*El_fit+c(3)*El_fit.^2+c(4)*El_fit.^3+c(5)*El_fit.^4;

% plot results
figure('Position',[540,300,700,500]);
hold on;
plot(El,CN0,'ko','MarkerSize',7,'LineWidth',1.5);
plot(El_fit,CN0_fit,'color',[0.5490,0.0824,0.0824],'linewidth',1.5);
hold off;
grid on;
xlim([0,90]);
ylim([0,50]);
xlabel('Elevation Angle, $\mathrm{El}\;[^{\circ}]$','Interpreter',...
    'latex','FontSize',18);
ylabel('$C/N_{0}\;[\mathrm{dB}\textrm{-}\mathrm{Hz}]$','Interpreter',...
    'latex','FontSize',18);
legend('data','polynomial fit','Interpreter','latex','FontSize',14,...
    'Location','best');