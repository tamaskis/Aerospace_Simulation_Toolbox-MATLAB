%==========================================================================
%
% cal2mjd  Modified Julian date from Gregorian (calendar) date.
%
%   MJD = cal2mjd(cal)
%   MJD = cal2mjd([YYYY,MM,DD,hh,mm,ss])
%
% See also cal2doy, doy2cal, f2hms, hms2f, jd2mjd, jd2t, mjd2cal, mjd2f, 
% mjd2jd, mjd2t.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-01
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Aerospace_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   cal     - (1×6 double) Gregorian (calendar) date [y,mo,d,h,m,s]
%               --> input as [YYYY,MM,DD,hh,mm,ss]
%
% -------
% OUTPUT:
% -------
%   MJD     - (1×1 double) modified Julian date [d]
%
%==========================================================================
function MJD = cal2mjd(cal)
    
    % extracts "YYYY", "MM", "DD", "hh", "mm", and "ss" from "cal".
    YYYY = cal(1);
    MM = cal(2);
    DD = cal(3);
    hh = cal(4);
    mm = cal(5);
    ss = cal(6);
    
    % throws an error if date is before 1582 October 15
    if (YYYY <= 1582) && ((MM < 10) || ((MM == 10) && (DD < 15)))
        error(['This function is only valid for dates after 1582 ',...
            'October 14.']);
    end
    
    % converts time to fraction of a day [d]
    f_DD = hms2f(hh,mm,ss);
    
    % appends time to day [d]
    DD = DD+f_DD;
    
    % handles leap years
    if MM <= 2
        y = YYYY-1;
        m = MM+12;
    else
        y = YYYY;
        m = MM;
    end
    
    % handles leap days
    B = floor(y/400)-floor(y/100)+floor(y/4);
    
    % modified Julian date
    MJD = 365*y-679004+B+floor(30.6001*(m+1))+DD;
    
end