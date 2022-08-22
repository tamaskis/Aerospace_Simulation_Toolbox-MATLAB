%% update_DAT.m
% Astrodynamics Toolbox
%
% Updates ΔAT data.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
% ----------------------
% Generated data format.
% ----------------------
%
% This script produces "DAT.mat" which stores the N×2 array "DAT", where 
% N is the number of dates. The columns store the following data:
%   1. MJD - modified Julian date [MJD]
%   2. DAT - difference between TAI (International Atomic Time) and UTC 
%            (Universal Coordinated Time) (ΔAT = TAI - UTC) [s]



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" functions
addpath(genpath('../..'));



%% UPDATING ΔAT DATA

%            year   month   day   ΔAT
DAT_table = [1972   1       1     10;
             1972   7       1     11;
             1973   1       1     12;
             1974   1       1     13;
             1975   1       1     14;
             1976   1       1     15;
             1977   1       1     16;
             1978   1       1     17;
             1979   1       1     18;
             1980   1       1     19;
             1981   7       1     20;
             1982   7       1     21;
             1983   7       1     22;
             1985   7       1     23;
             1988   1       1     24;
             1990   1       1     25;
             1991   1       1     26;
             1992   7       1     27;
             1993   7       1     28;
             1994   7       1     29;
             1996   1       1     30;
             1997   7       1     31;
             1999   1       1     32;
             2006   1       1     33;
             2009   1       1     34;
             2012   7       1     35;
             2015   7       1     36;
             2017   1       1     37];

% number of entries
n = size(DAT_table,1);

% preallocate array to store final form of ΔAT DATA
DAT = zeros(n,2);

% populates second column of DAT with ΔAT data
DAT(:,2) = DAT_table(:,4);

% populates first column of DAT with modified Julian dates
for i = 1:n
    DAT(i,1) = cal2mjd([DAT_table(i,1),DAT_table(i,2),DAT_table(i,3),0,...
        0,0]);
end

% saves DAT as a .mat file
save('../datafiles/DAT.mat','DAT');