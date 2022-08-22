%==========================================================================
%
% space_weather  Space weather data for atmospheric models.
%
%   sw = space_weather(MJD_UT1,sw1,sw2,model)
%
% See also load_sw.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 560, 604, 1001-1002, 1053-1055)
%   [2] Long et al., "Goddard Trajectory Determination System (GTDS)
%       Mathematical Theory: Revision 1" (pp. 4-37 to 4-38)
%   [3] nrlmsise-00.h 
%       (https://git.linta.de/?p=~brodo/nrlmsise-00.git;a=summary)
%   [4] Bowman et al., "A New Empirical Thermospheric Density Model JB2008 
%       Using New Solar and Geomagnetic Indices"
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UT1 - (1×1 double) UT1 (Universal Time 1) [MJD]
%   sw1     - (N×20 double) 1st half of space weather data; columns:
%                1. MJD_UT1  - UT1 (Universal Time 1)[MJD]
%                2. Kp1      - planetary index (00:00-03:00) [-]
%                3. Kp2      - planetary index (03:00-06:00) [-]
%                4. Kp3      - planetary index (06:00-09:00) [-]
%                5. Kp4      - planetary index (09:00-12:00) [-]
%                6. Kp5      - planetary index (12:00-15:00) [-]
%                7. Kp6      - planetary index (15:00-18:00) [-]
%                8. Kp7      - planetary index (18:00-21:00) [-]
%                9. Kp8      - planetary index (21:00-00:00) [-]
%               10. ap1      - planetary amplitude (00:00-03:00) [γ]
%               11. ap2      - planetary amplitude (03:00-06:00) [γ]
%               12. ap3      - planetary amplitude (06:00-09:00) [γ]
%               13. ap4      - planetary amplitude (09:00-12:00) [γ]
%               14. ap5      - planetary amplitude (12:00-15:00) [γ]
%               15. ap6      - planetary amplitude (15:00-18:00) [γ]
%               16. ap7      - planetary amplitude (18:00-21:00) [γ]
%               17. ap8      - planetary amplitude (21:00-00:00) [γ]
%               18. Ap       - daily planetary amplitude [γ]
%               19. F107     - daily 10.7 cm solar flux [SFU]
%               20. F107_avg - centered 81-day average of F10.7 [SFU]
%   sw2     - (M×31 double) 2nd half of space weather data; columns:
%                  1. MJD_UT1  - UT1 (Universal Time 1)[MJD]
%                  2. S107     - daily 26-34 nm EUV index [SFU]
%                  3. S107_avg - centered 81-day average of S10.7 [SFU]
%                  4. M107     - daily Mg II index [SFU]
%                  5. M107_avg - centered 81-day average of M10.7 [SFU]
%                  6. Y107     - daily solar X-ray and Lyman-α emission 
%                                mixed index [SFU]
%                  7. Y107_avg - centered 81-day average of Y10.7 [SFU]
%               8-31. dTc      - temperature change derived from Dst index
%                                for each hour of the day (column 8 --> 
%                                00:00, column 31 --> 23:00) [K]
%   model   - (1×1 char) atmospheric model being used ('Exponential', 
%             'Harris-Priester', 'Jacchia-Bowman 2008', 'Jacchia-Roberts',
%             or 'NRLMSISE-00')
%
% -------
% OUTPUT:
% -------
%   sw      - (1×1 struct) space weather data for atmospheric models
%       • ap_array  - (1×7 double) planetary amplitude array for
%                     NRLMSISE-00 atmospheric model
%           ‣ 1. Ap       - daily planetary amplitude (current day - no 
%                           lag) [γ]
%           ‣ 2. ap       - planetary amplitude (current time) [γ]
%           ‣ 3. ap3      - planetary amplitude (3 hours before) [γ]
%           ‣ 4. ap6      - planetary amplitude (6 hours before) [γ]
%           ‣ 5. ap9      - planetary amplitude (9 hours before) [γ]
%           ‣ 6. ap_12_33 - planetary amplitude (average of 12-33 hours 
%                           before) [γ]
%           ‣ 7. ap_36_57 - planetary amplitude (average of 36-57 hours 
%                           before) [γ]
%       • dTc       - (1×1 double) temperature change derived from Dst 
%                     index for current time [K]
%       • F107      - (1×1 double) daily 10.7 cm solar flux (1-day lag)
%                     [SFU]
%       • F107_avg  - (1×1 double) centered 81-day average of F10.7 (1-day
%                     lag) [SFU]
%       • Kp        - (1×1 double) planetary index (3-hour lag) [-]
%       • M107      - (1×1 double) daily Mg II index (2-day lag) [SFU]
%       • M107_avg  - (1×1 double) centered 81-day average of M10.7 (2-day
%                     lag) [SFU]
%       • S107      - (1×1 double) daily 26-34 nm EUV index (1-day lag) 
%                     [SFU]
%       • S107_avg  - (1×1 double) centered 81-day average of S10.7 (1-day
%                     lag) [SFU]
%       • Y107      - (1×1 double) daily solar X-ray and Lyman-α emission 
%                     mixed index (5-day lag) [SFU]
%       • Y107_avg  - (1×1 double) centered 81-day average of Y10.7 (5-day
%                     lag) [SFU]
%
% -----
% NOTE:
% -----
%   --> The F10.7 parameters are NOT adjusted to 1 AU.
%
%==========================================================================
function sw = space_weather(MJD_UT1,sw1,sw2,model)
    
    % extracts data from sw1
    MJD_UT1_sw1_data = sw1(:,1);
    Kp_data = sw1(:,2:9);
    ap_data = sw1(:,10:17);
    Ap_data = sw1(:,18);
    F107_data = sw1(:,19);
    F107_avg_data = sw1(:,20);

    % extracts data from sw2
    MJD_UT1_sw2_data = sw2(:,1);
    S107_data = sw2(:,2);
    S107_avg_data = sw2(:,3);
    M107_data = sw2(:,4);
    M107_avg_data = sw2(:,5);
    Y107_data = sw2(:,6);
    Y107_avg_data = sw2(:,7);
    dTc_data = sw2(:,8:31);
    
    % ---------------------------
    % Indices for "sw1" data set.
    % ---------------------------

    % index for current day for "sw1" data set
    today_sw1 = interval_search(MJD_UT1_sw1_data,MJD_UT1,false);

    % index for previous day for "sw1" data set
    yesterday_sw1 = today_sw1-1;
    
    % ---------------------------
    % Indices for "sw2" data set.
    % ---------------------------
    
    % index for current day for "sw2" data set
    today_sw2 = interval_search(MJD_UT1_sw2_data,MJD_UT1,false);

    % index for previous day for "sw2" data set
    yesterday_sw2 = today_sw2-1;

    % index for 2-day lag for "sw2" data set
    two_day_lag_sw2 = today_sw2-2;

    % index for 5-day lag for "sw2" data set
    five_day_lag_sw2 = today_sw2-5;

    % index for current hour in "dTc" array
    hour_sw2 = f2hms(mjd2f(MJD_UT1))+1;

    % ----------------------------------------------------------
    % Determines which sets of space weather data are essential.
    % ----------------------------------------------------------

    % determines if data stored in "sw1" is needed
    sw1_data_needed = strcmpi(model,'Jacchia-Roberts') ||...
        strcmpi(model,'NRLMSISE-00') ||...
        strcmpi(model,'Jacchia-Bowman 2008');

    % determines if data stored in "sw2" is needed
    sw2_data_needed = strcmpi(model,'Jacchia-Bowman 2008');

    % --------------------------------------------------
    % Determine if data is available for specified date.
    % --------------------------------------------------

    % determine if specified date out of bound for "sw1" data set
    sw1_below_bound = yesterday_sw1 < 1;
    sw1_above_bound = MJD_UT1_sw1_data(today_sw1) ~= floor(MJD_UT1);
    sw1_out_of_bound = sw1_below_bound || sw1_above_bound;

    % determine if specified date out of bound for "sw2" data set
    sw2_below_bound = five_day_lag_sw2 < 1;
    sw2_above_bound = MJD_UT1_sw2_data(today_sw2) ~= floor(MJD_UT1);
    sw2_out_of_bound = sw2_below_bound || sw2_above_bound;
    
    % -------------------------------------------------
    % Space weather parameters from 1st data set (sw1).
    % -------------------------------------------------

    % throws error if date out of bound but data needed
    if sw1_out_of_bound && sw1_data_needed
        error('Specified date not available in "sw1" data set.')

    % sets data as NaN if date out of bound but data not needed
    elseif sw1_out_of_bound && ~sw1_data_needed
        ap_array = NaN;
        F107 = NaN;
        F107_avg = NaN;
        Kp = NaN;

    % returns data needed for atmospheric models
    else

        % daily 10.7 cm solar flux (1-day lag) [SFU]
        F107 = F107_data(yesterday_sw1);
    
        % centered 81-day average of F10.7 (1-day lag) [SFU]
        F107_avg = F107_avg_data(yesterday_sw1);
    
        % planetary index (3-hour lag)
        Kp = t2Kp(MJD_UT1-3/24,MJD_UT1_sw1_data,Kp_data);
    
        % daily planetary amplitude [γ]
        Ap = Ap_data(today_sw1);
    
        % planetary amplitudes until 57 hours before current time [γ]
        ap = zeros(20,1);
        for i = 1:20
            ap(i) = t2ap(MJD_UT1-(3*(i-1))/24,MJD_UT1_sw1_data,ap_data);
        end
        
        % relevant planetary amplitudes for NRLMSISE-00 model [γ]
        ap0 = ap(1);                % current time
        ap3 = ap(2);                % 3 hours before current time
        ap6 = ap(3);                % 6 hours before current time
        ap9 = ap(4);                % 9 hours before current time
        ap_12_33 = mean(ap(5:12));  % avg. of 12-33 hrs before current time
        ap_36_57 = mean(ap(13:20)); % avg. of 36-57 hrs before current time
    
        % planetary amplitude array for NRLMSISE-00 atmospheric model [γ]
        ap_array = [Ap,ap0,ap3,ap6,ap9,ap_12_33,ap_36_57];

    end
    
    % -------------------------------------------------
    % Space weather parameters from 2nd data set (sw2).
    % -------------------------------------------------
    
    % throws error if date out of bound but data needed
    if sw2_out_of_bound && sw2_data_needed
        error('Specified date not available in "sw2" data set.')

    % sets data as NaN if date out of bound but data not needed
    elseif sw2_out_of_bound && ~sw2_data_needed
        dTc = NaN;
        M107 = NaN;
        M107_avg = NaN;
        S107 = NaN;
        S107_avg = NaN;
        Y107 = NaN;
        Y107_avg = NaN;

    % returns data needed for atmospheric models
    else

        % daily 26-34 nm EUV index (1-day lag) [SFU]
        S107 = S107_data(yesterday_sw2);
    
        % centered 81-day average of S10.7 (1-day lag) [SFU]
        S107_avg = S107_avg_data(yesterday_sw2);
    
        % daily Mg II index (2-day lag) [SFU]
        M107 = M107_data(two_day_lag_sw2);
    
        % centered 81-day average of M10.7 (2-day lag) [SFU]
        M107_avg = M107_avg_data(two_day_lag_sw2);
    
        % solar X-ray and Lyman-α emission mixed index (5-day lag) [SFU]
        Y107 = Y107_data(five_day_lag_sw2);
    
        % centered 81-day average of Y10.7 (5-day lag) [SFU]
        Y107_avg = Y107_avg_data(five_day_lag_sw2);
        
        % temperature change derived from Dst index for each hour of the 
        % current day (column 8 --> 00:00, column 31 --> 23:00) [K]
        dTc = dTc_data(today_sw2,hour_sw2);

    end

    % -------------------
    % Packages structure.
    % -------------------
    
    sw.ap_array = ap_array;
    sw.dTc = dTc;
    sw.F107 = F107;
    sw.F107_avg = F107_avg;
    sw.Kp = Kp;
    sw.M107 = M107;
    sw.M107_avg = M107_avg;
    sw.S107 = S107;
    sw.S107_avg = S107_avg;
    sw.Y107 = Y107;
    sw.Y107_avg = Y107_avg;
    
end