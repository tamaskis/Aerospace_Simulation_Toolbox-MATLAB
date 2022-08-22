%==========================================================================
%
% load_sw  Loads space weather data.
%
%   [sw1,sw2] = load_sw
%   [sw1,sw2] = load_sw(MJD_UTC0,duration)
%
% Author: Tamas Kis
% Last Update: 2022-02-17
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UTC0    - (1×1 double) (OPTIONAL) initial UTC [MJD]
%   duration    - (1×1 double) (OPTIONAL) simulation duration [h]
%
% -------
% OUTPUT:
% -------
%   sw1         - (N×20 double) 1st half of space weather data; columns:
%                    1. MJD_UT1  - UT1 (Universal Time 1)[MJD]
%                    2. Kp1      - planetary index (00:00-03:00) [-]
%                    3. Kp2      - planetary index (03:00-06:00) [-]
%                    4. Kp3      - planetary index (06:00-09:00) [-]
%                    5. Kp4      - planetary index (09:00-12:00) [-]
%                    6. Kp5      - planetary index (12:00-15:00) [-]
%                    7. Kp6      - planetary index (15:00-18:00) [-]
%                    8. Kp7      - planetary index (18:00-21:00) [-]
%                    9. Kp8      - planetary index (21:00-00:00) [-]
%                   10. ap1      - planetary amplitude (00:00-03:00) [γ]
%                   11. ap2      - planetary amplitude (03:00-06:00) [γ]
%                   12. ap3      - planetary amplitude (06:00-09:00) [γ]
%                   13. ap4      - planetary amplitude (09:00-12:00) [γ]
%                   14. ap5      - planetary amplitude (12:00-15:00) [γ]
%                   15. ap6      - planetary amplitude (15:00-18:00) [γ]
%                   16. ap7      - planetary amplitude (18:00-21:00) [γ]
%                   17. ap8      - planetary amplitude (21:00-00:00) [γ]
%                   18. Ap       - daily planetary amplitude [γ]
%                   19. F107     - daily 10.7 cm solar flux [SFU]
%                   20. F107_avg - centered 81-day average of F10.7 [SFU]
%   sw2         - (M×31 double) 2nd half of space weather data; columns:
%                      1. MJD_UT1  - UT1 (Universal Time 1)[MJD]
%                      2. S107     - daily 26-34 nm EUV index [SFU]
%                      3. S107_avg - centered 81-day average of S10.7 [SFU]
%                      4. M107     - daily Mg II index [SFU]
%                      5. M107_avg - centered 81-day average of M10.7 [SFU]
%                      6. Y107     - daily solar X-ray and Lyman-α emission 
%                                    mixed index [SFU]
%                      7. Y107_avg - centered 81-day average of Y10.7 [SFU]
%                   8-31. dTc      - temperature change derived from Dst 
%                                    index for each hour of the day (column
%                                    8 --> 00:00, column 31 --> 23:00) [K]
%
% -----
% NOTE:
% -----
%   --> N = # of data entries for 1st half of space weather data
%   --> M = # of data entries for 2nd half of space weather data
%
%==========================================================================
function [sw1,sw2] = load_sw(MJD_UTC0,duration)
    
    % loads full data sets
    sw1 = struct2array(load('sw1.mat'));
    sw2 = struct2array(load('sw2.mat'));

    % determines if inputs are provided
    MJD_UTC0_input = (nargin >= 1) && ~isempty(MJD_UTC0);
    duration_input = (nargin == 2) && ~isempty(duration);
    
    % ---------------------
    % 1st half of data set.
    % ---------------------
    
    % trims data set to only keep relevant data for simulation
    if MJD_UTC0_input && duration_input

        % start and end dates of data to keep (from 3 days before start to 
        % end of simulation)
        MJD_start = floor(MJD_UTC0)-3;
        MJD_end = ceil(MJD_UTC0+duration/24);
    
        % start and end indices
        i_start = interval_search(sw1(:,1),MJD_start,false);
        [~,i_end] = interval_search(sw1(:,1),MJD_end,false);
    
        % removes unnecessary data
        sw1 = sw1(i_start:i_end,:);

    end

    % ---------------------
    % 2nd half of data set.
    % ---------------------
    
    % trims data set to only keep relevant data for simulation
    if MJD_UTC0_input && duration_input

        % start and end dates of data to keep (from 5 days before start to 
        % end of simulation)
        MJD_start = floor(MJD_UTC0)-5;
        MJD_end = ceil(MJD_UTC0+duration/24);
    
        % start and end indices
        i_start = interval_search(sw2(:,1),MJD_start,false);
        [~,i_end] = interval_search(sw2(:,1),MJD_end,false);
    
        % removes unnecessary data
        sw2 = sw2(i_start:i_end,:);

    end

end