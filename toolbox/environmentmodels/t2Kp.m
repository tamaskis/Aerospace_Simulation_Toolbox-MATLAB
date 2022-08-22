%==========================================================================
%
% t2Kp  Planetary index from current time.
%
%   Kp = t2Kp(MJD_UT1,MJD_UT1_data,Kp_data)
%
% See also load_sw, t2ap.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UT1         - (1×1 double) current UT1 (Universal Time 1) [MJD]
%   MJD_UT1_data    - (N×1 double) UT1 for each data entry [MJD]
%   Kp_data         - (N×8 double) planetary index data; columns:
%                       1. Kp1 - planetary index (00:00-03:00) [-]
%                       2. Kp2 - planetary index (03:00-06:00) [-]
%                       3. Kp3 - planetary index (06:00-09:00) [-]
%                       4. Kp4 - planetary index (09:00-12:00) [-]
%                       5. Kp5 - planetary index (12:00-15:00) [-]
%                       6. Kp6 - planetary index (15:00-18:00) [-]
%                       7. Kp7 - planetary index (18:00-21:00) [-]
%                       8. Kp8 - planetary index (21:00-00:00) [-]
%
% -------
% OUTPUT:
% -------
%   Kp              - (1×1 double) planetary index at beginning of 3-hour
%                     interval containing specified MJD_UT1 [-]
%
% -----
% NOTE:
% -----
%   --> N = number of data entries
%
%==========================================================================
function Kp_UT1 = t2Kp(MJD_UT1,MJD_UT1_data,Kp_data)

    % fraction of day [d]
    f_DD = mjd2f(MJD_UT1);

    % hours [h]
    h = f2hms(f_DD);

    % determine index corresponding to date
    i = interval_search(MJD_UT1_data,MJD_UT1,false);

    % Kp corresponding to time interval within date [-]
    if h < 3
        Kp_UT1 = Kp_data(i,1);
    elseif (h >= 3) && (h < 6)
        Kp_UT1 = Kp_data(i,2);
    elseif (h >= 6) && (h < 9)
        Kp_UT1 = Kp_data(i,3);
    elseif (h >= 9) && (h < 12)
        Kp_UT1 = Kp_data(i,4);
    elseif (h >= 12) && (h < 15)
        Kp_UT1 = Kp_data(i,5);
    elseif (h >= 15) && (h < 18)
        Kp_UT1 = Kp_data(i,6);
    elseif (h >= 18) && (h < 21)
        Kp_UT1 = Kp_data(i,7);
    elseif (h >= 21) && (h < 24)
        Kp_UT1 = Kp_data(i,8);
    end
    
end