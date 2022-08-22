%==========================================================================
%
% doy2cal  Gregorian (calendar) date from year and day of year.
%
%   cal = doy2cal(YYYY,DOY)
%
% See also cal2doy, cal2mjd, f2hms, hms2f, jd2mjd, jd2t, mjd2cal, mjd2f, 
% mjd2jd, mjd2t.
%
% Author: Tamas Kis
% Last Update: 2022-02-17
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       (p. 200)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   YYYY    - (1×1 double) year [y]
%   DOY     - (1×1 double) day of the year [d]
%
% -------
% OUTPUT:
% -------
%   cal     - (1×6 double) Gregorian (calendar) date [y,mo,d,h,m,s]
%               --> output as [YYYY,MM,DD,hh,mm,ss]
%
% -----
% NOTE:
% -----
%   --> This function is only valid between the years 1901 and 2099.
%
%==========================================================================
function cal = doy2cal(YYYY,DOY)

    % number of days in each month for non-leap year [d]
    d = [31,28,31,30,31,30,31,31,30,31,30,31];

    % changes the number of days in February to 29 if in leap year [d]
    if mod(YYYY,4) == 0
        d(2) = 29;
    end
    
    % determines month [mo]
    MM = 0;
    while sum(d(1:MM)) < DOY
        MM = MM+1;
    end
    
    % day of month [d]
    if MM == 1
        DD = DOY;
    else
        DD = DOY-sum(d(1:(MM-1)));
    end
    
    % assembles Gregorian (calendar) date [y,mo,d,h,m,s]
    cal = [YYYY,MM,DD,0,0,0];

end