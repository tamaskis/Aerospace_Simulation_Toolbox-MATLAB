%% update_DUT1.m
% Astrodynamics Toolbox
%
% Updates ΔUT1 data.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
% ----------------------
% Generated data format.
% ----------------------
%
% This script produces "DUT1.mat" which stores the N×2 array "DUT1", where 
% N is the number of dates. The columns store the following data:
%   1. MJD  - modified Julian date [MJD]
%   2. DUT1 - difference between UT1 (Universal Time 1) and UTC (Universal
%              Coordinated Time) (ΔUT1 = UT1 - UTC) [s]
%
% ----------------
% Raw data format.
% ----------------
%
% The raw data is formatted as in the following link:
%   https://datacenter.iers.org/data/html/finals2000A.data.html
%
% The relevant data that we want is stored in the following columns:
%    1. MJD  - modified Julian date [MJD]
%   11. DUT1 - difference between UT1 (Universal Time 1) and UTC (Universal
%              Coordinated Time) (ΔUT1 = UT1 - UTC) [s]



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;



%% UPDATING ΔUT1 DATA

% reads data from website
data = webread("https://datacenter.iers.org/data/csv/finals2000A."+...
    "data.csv");

% keeps relevant columns and converts to double array
DUT1 = table2array([data(:,1),data(:,11)]);

% remove rows that have NaN
DUT1 = DUT1(~isnan(DUT1(:,2)),:);

% saves DUT1 as a .mat file
save('../datafiles/DUT1.mat','DUT1');