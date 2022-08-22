%% create_XYs_iau06.m
% Astrodynamics Toolbox
%
% Creates data for the IAU2006/2000 CIO based precession-nutation matrix
% calculation.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% ----------------------
% Generated data format.
% ----------------------
%
% This script produces "XYs_iau06.mat" which stores the 1×1 struct 
% "XYs_iau06" with the following fields:
%   • ax    - (1600×1 double) ax coefficients for X [rad]
%   • ay    - (1275×1 double) ay coefficients for Y [rad]
%   • as    - (66×1 double) ay coefficients for s [rad]
%   • bx    - (1600×1 double) bx coefficients for X [rad]
%   • by    - (1275×1 double) by coefficients for Y [rad]
%   • bs    - (66×1 double) by coefficients for s [rad]
%   • M     - (1600×14 double) fundamental argument coefficients for X
%   • N     - (1275×14 double) fundamental argument coefficients for Y
%   • O     - (66×14 double) fundamental argument coefficients for s
%
% ----------------
% Raw data format.
% ----------------
%
% tab5.2a.txt:
%   ----------------------------------------------------------------
%      i   |    axi      bxi   |    Mi1      Mi2    ...    Mi14
%   ----------------------------------------------------------------
%      1   |    ax1      bx1   |    M11      M12    ...    M114
%      2   |    ax2      bx2   |    M21      M22    ...    M214
%      3   |    ax3      bx3   |    M31      M32    ...    M314
%      :   |     :        :    |     :        :              :
%    1600  |  ax1600   ax1600  |  M16001   M16002   ...   M160014
%   ----------------------------------------------------------------
%
% tab5.2b.txt:
%   --------------------------------------------------------------
%      i   |    ayi      byi   |    Ni1      Ni2    ...    Ni14
%   --------------------------------------------------------------
%      1   |    ay1      by1   |    N11      N12    ...    N114
%      2   |    ay2      by2   |    N21      N22    ...    N214
%      3   |    ay3      by3   |    N31      N32    ...    N314
%      :   |     :        :    |     :        :              :
%    1275  |  ay1275   ay1275  |  N12751   N12752   ...   N127514
%   --------------------------------------------------------------
%
% tab5.2d.txt:
%   ----------------------------------------------------
%      i  |   ayi    byi  |    Ni1    Ni2   ...   Ni14
%   ----------------------------------------------------
%      1  |   ay1    by1  |    N11    N12   ...   N114
%      2  |   ay2    by2  |    N21    N22   ...   N214
%      3  |   ay3    by3  |    N31    N32   ...   N314
%      :  |    :      :   |     :      :            :
%     66  |  ay66   ay66  |   N661   N662   ...   N6614
%   ----------------------------------------------------
%
% Note that each of the tables above is divided into 5 separate "chunks":
%   • tab5.2a.txt: (1-->1306), (1307-->1559), (1560-->1595), (1596-->1599),
%                  (1600)
%   • tab5.2b.txt: (1-->962), (963-->1239), (1240-->1269), (1270-->1274),
%                  (1275)
%   • tab5.2d.txt: (1-->33), (34-->36), (37-->61), (62-->65), (66)
%
% These data files are stores in the "toolbox/data/rawdata" and are
% originally downloaded from:
%   • tab5.2a.txt: https://iers-conventions.obspm.fr/content/chapter5/additional_info/tab5.2a.txt
%   • tab5.2b.txt: https://iers-conventions.obspm.fr/content/chapter5/additional_info/tab5.2b.txt
%   • tab5.2d.txt: https://iers-conventions.obspm.fr/content/chapter5/additional_info/tab5.2d.txt
%
% Note that all the "a" and "b" coefficients are originally in units of
% microarcseconds. During the data processing we perform here, they are
% converted to units of radians.



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" functions
addpath(genpath('../..'));



%% X DATA

% read in data
data = readmatrix('../rawdata/tab5.2a.txt');

% extracts the different portions of the data
data1 = data((14+1):(14+1306),:);       % portion 1 (1 --> 1306)
data2 = data((15+1307):(15+1559),:);    % portion 2 (1307 --> 1559)
data3 = data((16+1560):(16+1595),:);    % portion 3 (1560 --> 1595)
data4 = data((17+1596):(17+1599),:);    % portion 4 (1596 --> 1599)
data5 = data(18+1600,:);                % portion 5 (1600)

% recombines data
data = [data1;data2;data3;data4;data5];

% extracts ax, bx, and N
ax = data(:,2);
bx = data(:,3);
M = data(:,4:17);

% clear all data from memory
clear data data1 data2 data3 data4 data5;



%% Y DATA

% read in data
data = readmatrix('../rawdata/tab5.2b.txt');

% extracts the different portions of the data
data1 = data((14+1):(14+962),:);        % portion 1 (1 --> 962)
data2 = data((15+963):(15+1239),:);     % portion 2 (963 --> 1239)
data3 = data((16+1240):(16+1269),:);    % portion 3 (1240 --> 1269)
data4 = data((17+1270):(17+1274),:);    % portion 4 (1270 --> 1274)
data5 = data(18+1275,:);                % portion 5 (1275)

% recombines data
data = [data1;data2;data3;data4;data5];

% extracts ay, by, and M
ay = data(:,2);
by = data(:,3);
N = data(:,4:17);

% clear "data" from memory
clear data data1 data2 data3 data4 data5;



%% S DATA

% read in data
data = readmatrix('../rawdata/tab5.2d.txt');

% extracts the different portions of the data
data1 = data((2+1):(2+33),:);       % portion 1 (1 --> 33)
data2 = data((3+34):(3+36),:);      % portion 2 (34 --> 36)
data3 = data((4+37):(4+61),:);      % portion 3 (37 --> 61)
data4 = data((5+62):(5+65),:);      % portion 4 (62 --> 65)
data5 = data(6+66,:);               % portion 5 (66)

% recombines data
data = [data1;data2;data3;data4;data5];

% extracts as, bs, and O
as = data(:,2);
bs = data(:,3);
O = data(:,4:17);

% clear "data" from memory
clear data data1 data2 data3 data4 data5;



%% UNIT CONVERSIONS

% converts "a" and "b" vectors from microarcseconds to radians
ax = arcsec2rad(1e-6*ax);
ay = arcsec2rad(1e-6*ay);
as = arcsec2rad(1e-6*as);
bx = arcsec2rad(1e-6*bx);
by = arcsec2rad(1e-6*by);
bs = arcsec2rad(1e-6*bs);



%% PACKAGES DATA INTO A STRUCT AND SAVES TO FILE

% struct definition
XYs_iau06.ax = ax;
XYs_iau06.ay = ay;
XYs_iau06.as = as;
XYs_iau06.bx = bx;
XYs_iau06.by = by;
XYs_iau06.bs = bs;
XYs_iau06.M = M;
XYs_iau06.N = N;
XYs_iau06.O = O;

% save data to MAT file
save('../datafiles/XYs_iau06.mat','XYs_iau06');