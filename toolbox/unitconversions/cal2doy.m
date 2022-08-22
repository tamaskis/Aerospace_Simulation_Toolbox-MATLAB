%==========================================================================
%
% cal2doy  Day of year from Gregorian (calendar) date.
%
%   DOY = cal2doy(cal)
%   DOY = cal2doy([YYYY,MM,DD])
%   DOY = cal2doy([YYYY,MM,DD,hh,mm,ss])
%
% See also cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, jd2t, mjd2cal, mjd2f, 
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
%   cal     - (1×6 double) Gregorian (calendar) date [y,mo,d] (or 
%             [y,mo,d,h,m,s])
%               --> input as [YYYY,MM,DD] or [YYYY,MM,DD,hh,mm,ss]
%
% -------
% OUTPUT:
% -------
%   DOY     - (1×1 double) day of the year [d]
%
% -----
% NOTE:
% -----
%   --> This function is only valid between the years 1901 and 2099.
%   --> "cal" can be input either as [YYYY,MM,DD] or as 
%       [YYYY,MM,DD,hh,mm,ss] (for the latter case, the hours, minutes, and
%       seconds are ignored).
%
%==========================================================================
function DOY = cal2doy(cal)

    % extracts year [y], month [mo], and day [d] from Gregorian date
    YYYY = cal(1);
    MM = cal(2);
    DD = cal(3);

    % number of days in each month for non-leap year [d]
    d = [31,28,31,30,31,30,31,31,30,31,30,31];

    % changes the number of days in February to 29 if in leap year [d]
    if mod(YYYY,4) == 0
        d(2) = 29;
    end
    
    % calculates day of year [d]
    DOY = DD;
    for i = 1:(MM-1)
        DOY = DOY+d(i);
    end

end