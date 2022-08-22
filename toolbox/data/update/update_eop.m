%% update_eop.m
% Astrodynamics Toolbox
%
% Updates Earth orientation parameter data.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
% ----------------------
% Generated data format.
% ----------------------
%
% This script produces "eop.mat" which stores the N×6 array "eop", where N 
% is the number of dates. The columns store the following data:
%   1. MJD - modified Julian date [MJD]
%   2. xp  - polar coordinate of the CIP ['']
%   3. yp  - polar coordinate of the CIP ['']
%   4. dX  - correction term for X [mas]
%   5. dY  - correction term for Y [mas]
%   6. LOD - length of day [ms]
%
% ----------------
% Raw data format.
% ----------------
%
% The raw data is formatted as in the following link:
%   https://datacenter.iers.org/data/html/finals2000A.data.html
%
% The relevant data that we want is stored in the following columns:
%    1. MJD - modified Julian date [MJD]
%    6. xp  - polar coordinate of the CIP ['']
%    8. yp  - polar coordinate of the CIP ['']
%   13. LOD - length of day [ms]
%   20. dX  - correction term for X [mas]
%   22. dY  - correction term for Y [mas]



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;



%% UPDATING EOP DATA

% reads data from website
data = webread("https://datacenter.iers.org/data/csv/finals2000A."+...
    "data.csv");

% keeps relevant columns and converts to double array
eop = table2array([data(:,1),data(:,6),data(:,8),data(:,20),data(:,22),...
    data(:,13)]);

% remove any rows that have NaN
eop = eop(~isnan(eop(:,2)),:);
eop = eop(~isnan(eop(:,3)),:);
eop = eop(~isnan(eop(:,4)),:);
eop = eop(~isnan(eop(:,5)),:);
eop = eop(~isnan(eop(:,6)),:);

% saves eop as a .mat file
save('../datafiles/eop.mat','eop');