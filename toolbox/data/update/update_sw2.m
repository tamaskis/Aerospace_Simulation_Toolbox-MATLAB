%% update_sw2.m
% Astrodynamics Toolbox
%
% Updates S₁₀.₇, M₁₀.₇, Y₁₀.₇, and dTc data (second half of space weather 
% data).
%
% Author: Tamas Kis
% Last Update: 2022-02-19

% ----------------------
% Generated data format.
% ----------------------
%
% This script produces "sw2.mat" which stores the N×31 array "sw2", where N
% is the number of dates. The columns store the following data:
%      1. MJD_UT1  - UT1 (Universal Time 1)[MJD]
%      2. S107     - daily 26-34 nm EUV index [SFU]
%      3. S107_avg - centered 81-day average of S10.7 [SFU]
%      4. M107     - daily Mg II index [SFU]
%      5. M107_avg - centered 81-day average of M10.7 [SFU]
%      6. Y107     - daily solar X-ray and Lyman-α emission mixed index
%                    [SFU]
%      7. Y107_avg - centered 81-day average of Y10.7 [SFU]
%   8-31. dTc      - temperature change derived from Dst index for each
%                    hour of the day (column 8 --> 00:00, column 31 --> 
%                    23:00) [K]
%
% --------------------------------------------------------------
% Raw data format for first 7 columns of desired generated data.
% --------------------------------------------------------------
%
% The raw data needed for the first 7 columns of the desired generated data
% can be found at the following link:
%   https://sol.spacenvironment.net/jb2008/indices/SOLFSMY.TXT
%
% The relevant data that we want is stored in the following columns:
%    1. YYYY     - year [y]
%    2. DOY      - day of year [d]
%    6. S107     - daily 26-34 nm EUV index [SFU]
%    7. S107_avg - centered 81-day average of S10.7 [SFU]
%    8. M107     - daily Mg II index [SFU]
%    9. M107_avg - centered 81-day average of M10.7 [SFU]
%   10. Y107     - daily solar X-ray and Lyman-α emission mixed index [SFU]
%   11. Y107_avg - centered 81-day average of Y10.7 [SFU]
%
% -----------------------------------------------------------
% Raw data format for columns 8-31 of desired generated data.
% -----------------------------------------------------------
%
% The raw data needed for columns 8-31 of the desired generated data can be
% found at the following link:
%   https://sol.spacenvironment.net/jb2008/indices/DTCFILE.TXT
%
% The relevant data that we want is stored in the following columns:
%
%    4-27. dTc  - temperature change derived from Dst index for each hour
%                 of the day (column 4 --> 00:00, column 27 --> 23:00) [K]
%
% Note that we ignore the dates provided in this second set of data. This
% is because they correspond exactly to the dates in the first set of data.
% However, it is important to know they may not updated simultaneously
% (i.e. there might be an updated lag of a few minutes to hours). This is
% handled in the "CREATING DATA FILE" section below.



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to all "Astrodynamics Toolbox" functions
addpath(genpath('../..'));



%% UPDATING S₁₀.₇, M₁₀.₇, Y₁₀.₇ DATA

% reads data from website
data = webread("https://sol.spacenvironment.net/jb2008/indices/SOLFSMY"+...
    ".TXT");

% data is imported as a single char array --> split into a cell array
% of char arrays, with each cell corresponding to a single line of data
data = splitlines(data);

% discard first four lines of data
data = data(5:end);

% discard last line of data (empty)
data = data(1:end-1);

% determine number of data points
N1 = length(data);

% preallocate arrays to store data
MJD_UT1 = zeros(N1,1);
S107 = zeros(N1,1);
S107_avg = zeros(N1,1);
M107 = zeros(N1,1);
M107_avg = zeros(N1,1);
Y107 = zeros(N1,1);
Y107_avg = zeros(N1,1);

% examine each line of data one by one
for i = 1:N1

    % each line is a single char array --> split into a cell array of
    % char arrays, with each cell corresponding to a single data entry
    line = split(data(i));
    
    % remove empty first cell
    line = line(2:end);
    
    % year [y]
    YYYY = str2double(line{1});

    % day of year [d]
    DOY = str2double(line{2});

    % Gregorian date [y,mo,d,h,m,s]
    cal = doy2cal(YYYY,DOY);

    % modified Julian date of UT1 [MJD]
    MJD_UT1(i) = cal2mjd(cal);
    
    % indices [SFU]
    S107(i) = str2double(line{6});
    S107_avg(i) = str2double(line{7});
    M107(i) = str2double(line{8});
    M107_avg(i) = str2double(line{9});
    Y107(i) = str2double(line{10});
    Y107_avg(i) = str2double(line{11});

end



%% UPDATING dTc DATA

% reads data from website
data = webread("https://sol.spacenvironment.net/jb2008/indices/DTCFILE"+...
    ".TXT");

% data is imported as a single char array --> split into a cell array
% of char arrays, with each cell corresponding to a single line of data
data = splitlines(data);

% discard last line of data (empty)
data = data(1:(end-1));

% determine number of data points
N2 = length(data);

% preallocate arrays to store data
dTc = zeros(N2,24);

% examine each line of data one by one
for i = 1:N2
    
    % each line is a single char array --> split into a cell array of
    % char arrays, with each cell corresponding to a single data entry
    line = split(data(i));
    
    % dTc for each hour [K]
    for j = 1:24
        dTc(i,j) = str2double(line{j+3});
    end

end



%% CREATING DATA FILE

% creates two "parts" to full data file
sw2_part1 = [MJD_UT1,S107,S107_avg,M107,M107_avg,Y107,Y107_avg];
sw2_part2 = dTc;

% the two files are not updated simultaneously -- therefore, we only keep
% data for days that occur in both files
N = min([N1,N2]);
sw2_part1 = sw2_part1(1:N,:);
sw2_part2 = sw2_part2(1:N,:);

% concatenates data into single array
sw2 = [sw2_part1,sw2_part2];

% saves sw2 as a .mat file
save('../datafiles/sw2.mat','sw2');