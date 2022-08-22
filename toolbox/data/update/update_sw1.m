%% update_sw1.m
% Astrodynamics Toolbox
%
% Updates Kₚ, aₚ, Aₚ, and F₁₀.₇ data (first half of space weather data).
%
% Author: Tamas Kis
% Last Update: 2022-02-19

% ----------------------
% Generated data format.
% ----------------------
%
% This script produces "sw1.mat" which stores the N×20 array "sw1", where N
% is the number of dates. The columns store the following data:
%    1. MJD_UT1  - UT1 (Universal Time 1)[MJD]
%    2. Kp1      - planetary index (00:00-03:00) [-]
%    3. Kp2      - planetary index (03:00-06:00) [-]
%    4. Kp3      - planetary index (06:00-09:00) [-]
%    5. Kp4      - planetary index (09:00-12:00) [-]
%    6. Kp5      - planetary index (12:00-15:00) [-]
%    7. Kp6      - planetary index (15:00-18:00) [-]
%    8. Kp7      - planetary index (18:00-21:00) [-]
%    9. Kp8      - planetary index (21:00-00:00) [-]
%   10. ap1      - planetary amplitude (00:00-03:00) [γ]
%   11. ap2      - planetary amplitude (03:00-06:00) [γ]
%   12. ap3      - planetary amplitude (06:00-09:00) [γ]
%   13. ap4      - planetary amplitude (09:00-12:00) [γ]
%   14. ap5      - planetary amplitude (12:00-15:00) [γ]
%   15. ap6      - planetary amplitude (15:00-18:00) [γ]
%   16. ap7      - planetary amplitude (18:00-21:00) [γ]
%   17. ap8      - planetary amplitude (21:00-00:00) [γ]
%   18. Ap       - daily planetary amplitude [γ]
%   19. F107     - daily 10.7 cm solar flux [SFU]
%   20. F107_avg - centered 81-day average of F10.7 [SFU]
%
% ----------------
% Raw data format.
% ----------------
%
% The raw data is formatted as in described in the following link:
%   https://celestrak.com/SpaceData/SpaceWx-format.php
%
% The relevant data that we want is stored in the following columns:
%    1. YYYY     - year [y]
%    2. MM       - month [mo]
%    3. DD       - day [d]
%    6. Kp1      - 10 × planetary index (00:00-03:00) [-]
%    7. Kp2      - 10 × planetary index (03:00-06:00) [-]
%    8. Kp3      - 10 × planetary index (06:00-09:00) [-]
%    9. Kp4      - 10 × planetary index (09:00-12:00) [-]
%   10. Kp5      - 10 × planetary index (12:00-15:00) [-]
%   11. Kp6      - 10 × planetary index (15:00-18:00) [-]
%   12. Kp7      - 10 × planetary index (18:00-21:00) [-]
%   13. Kp8      - 10 × planetary index (21:00-00:00) [-]
%   15. ap1      - planetary amplitude (00:00-03:00) [γ]
%   16. ap2      - planetary amplitude (03:00-06:00) [γ]
%   17. ap3      - planetary amplitude (06:00-09:00) [γ]
%   18. ap4      - planetary amplitude (09:00-12:00) [γ]
%   19. ap5      - planetary amplitude (12:00-15:00) [γ]
%   20. ap6      - planetary amplitude (15:00-18:00) [γ]
%   21. ap7      - planetary amplitude (18:00-21:00) [γ]
%   22. ap8      - planetary amplitude (21:00-00:00) [γ]
%   23. Ap       - daily planetary amplitude [γ]
%   31. F107     - daily 10.7 cm solar flux [SFU]
%   32. F107_avg - centered 81-day average of F10.7



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" functions
addpath(genpath('../..'));



%% UPDATING Kₚ, aₚ, Aₚ, F₁₀.₇ DATA

% reads data from website
data = webread('https://celestrak.com/SpaceData/SW-All.txt');

% data is imported as a single char array --> split into a cell array
% of char arrays, with each cell corresponding to a single line of data
data = splitlines(data);

% number of observed data points
N_obs = split(data(16,1));
N_obs = str2double(N_obs{2});

% number of predicted data points
N_pred = split(data(20+N_obs,1));
N_pred = str2double(N_pred{2});

% observed data
data_obs = data(18:(17+N_obs));

% predicted data
data_pred = data((22+N_obs):(21+N_obs+N_pred));

% concatenates observed and predicted data
data = [data_obs;data_pred];

% total number of data points
N = N_obs+N_pred;

% preallocate arrays to store data
MJD_UT1 = zeros(N,1);
Kp = zeros(N,8);
Ap = zeros(N,1);
ap = zeros(N,8);
F107 = zeros(N,1);
F107_avg = zeros(N,1);

% examine each line of data one by one
for i = 1:N

    % each line is a single char array --> split into a cell array of
    % char arrays, with each cell corresponding to a single data entry
    line = split(data(i));
    
    % Gregorian date
    cal = [str2double(line{1}),str2double(line{2}),str2double(line{3})];

    % modified Julian date of UT1 [MJD]
    MJD_UT1(i) = cal2mjd([cal,0,0,0]);

    % planetary index
    Kp(i,1) = str2double(line{6})/10;
    Kp(i,2) = str2double(line{7})/10;
    Kp(i,3) = str2double(line{8})/10;
    Kp(i,4) = str2double(line{9})/10;
    Kp(i,5) = str2double(line{10})/10;
    Kp(i,6) = str2double(line{11})/10;
    Kp(i,7) = str2double(line{12})/10;
    Kp(i,8) = str2double(line{13})/10;
    
    % planetary amplitude [γ]
    ap(i,1) = str2double(line{15});
    ap(i,2) = str2double(line{16});
    ap(i,3) = str2double(line{17});
    ap(i,4) = str2double(line{18});
    ap(i,5) = str2double(line{19});
    ap(i,6) = str2double(line{20});
    ap(i,7) = str2double(line{21});
    ap(i,8) = str2double(line{22});

    % daily planetary amplitude [γ]
    Ap(i) = str2double(line{23});

    % daily F10.7 [SFU]
    F107(i) = str2double(line{31});

    % centered 81-day average of F10.7 [SFU]
    F107_avg(i) = str2double(line{32});

end



%% CREATING DATA FILE

% concatenates data into single array
sw1 = [MJD_UT1,Kp,ap,Ap,F107,F107_avg];

% saves Kp_ap_F107 as a .mat file
save('../datafiles/sw1.mat','sw1');