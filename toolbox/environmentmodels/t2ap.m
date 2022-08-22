%==========================================================================
%
% t2ap  Planetary amplitude from current time.
%
%   ap = t2ap(MJD_UT1,MJD_UT1_data,ap_data)
%
% See also load_sw, t2Kp.
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
%   ap_data         - (N×8 double) planetary amplitude data; columns:
%                       1. ap1 - planetary amplitude (00:00-03:00) [γ]
%                       2. ap2 - planetary amplitude (03:00-06:00) [γ]
%                       3. ap3 - planetary amplitude (06:00-09:00) [γ]
%                       4. ap4 - planetary amplitude (09:00-12:00) [γ]
%                       5. ap5 - planetary amplitude (12:00-15:00) [γ]
%                       6. ap6 - planetary amplitude (15:00-18:00) [γ]
%                       7. ap7 - planetary amplitude (18:00-21:00) [γ]
%                       8. ap8 - planetary amplitude (21:00-00:00) [γ]
%
% -------
% OUTPUT:
% -------
%   ap          - (1×1 double) planetary amplitude at beginning of 3-hour
%                 interval containing specified MJD_UT1 [γ]
%
% -----
% NOTE:
% -----
%   --> N = number of data entries
%
%==========================================================================
function ap_UT1 = t2ap(MJD_UT1,MJD_UT1_data,ap_data)

    % fraction of day [d]
    f_DD = mjd2f(MJD_UT1);

    % hours [h]
    h = f2hms(f_DD);

    % determine index corresponding to date
    i = interval_search(MJD_UT1_data,MJD_UT1,false);

    % ap corresponding to time interval within date [γ]
    if h < 3
        ap_UT1 = ap_data(i,1);
    elseif (h >= 3) && (h < 6)
        ap_UT1 = ap_data(i,2);
    elseif (h >= 6) && (h < 9)
        ap_UT1 = ap_data(i,3);
    elseif (h >= 9) && (h < 12)
        ap_UT1 = ap_data(i,4);
    elseif (h >= 12) && (h < 15)
        ap_UT1 = ap_data(i,5);
    elseif (h >= 15) && (h < 18)
        ap_UT1 = ap_data(i,6);
    elseif (h >= 18) && (h < 21)
        ap_UT1 = ap_data(i,7);
    elseif (h >= 21) && (h < 24)
        ap_UT1 = ap_data(i,8);
    end
    
end