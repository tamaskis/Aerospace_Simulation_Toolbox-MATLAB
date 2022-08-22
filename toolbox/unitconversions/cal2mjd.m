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
% Author: Tamas Kis
% Last Update: 2022-02-17
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", 4th Ed., Appendix A.1.1 
%       (pp. 321-322)
%   [2] https://en.wikipedia.org/wiki/Gregorian_calendar#Gregorian_reform
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

    % assume Gregorian date is between (and including) 1582/10/05 and
    % 1582/10/14 (deleted days)
    pre = false;
    post = false;

    % set "pre" to true if date is pre-1582
    if (YYYY < 1582)
        pre = true;

    % set "post" to true if date is post-1582
    elseif (YYYY > 1582)
        post = true;

    % handle case where the year is 1582
    else

        % set "pre" to true if date is on or before October 4, 1582
        if ((MM < 10) || ((MM == 10) && (DD <= 4)))
            pre = true;

        % set "post" to true if date is on or after October 15, 1582
        elseif ((MM > 10) || ((MM == 10) && (DD >= 15)))
            post = true;

        end
        
    end

    % handles leap days
    if pre
        B = -2+floor((y+4716)/4)-1179;
    elseif post
        B = floor(y/400)-floor(y/100)+floor(y/4);
    else
        error('Calendar date does not exist in Gregorian calendar.');
    end
    
    % modified Julian date [MJD]
    MJD = 365*y-679004+B+floor(30.6001*(m+1))+DD;
    
end