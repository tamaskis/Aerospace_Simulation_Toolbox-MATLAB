%==========================================================================
%
% mjd2cal  Gregorian (calendar) date from modified Julian date.
%
%   cal = mjd2cal(MJD)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, jd2t, mjd2f,
% mjd2jd, mjd2t.
%
% Author: Tamas Kis
% Last Update: 2022-02-17
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", 4th Ed., Appendix A.1.2 
%       (pp. 322-323)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD     - (1×1 double) modified Julian date [d]
%
% -------
% OUTPUT:
% -------
%   cal     - (1×6 double) Gregorian (calendar) date [y,mo,d,h,m,s]
%               --> output as [YYYY,MM,DD,hh,mm,ss]
%
%==========================================================================
function cal = mjd2cal(MJD)
    
    % integer Julian day (Julian date at noon) [JD]
    a = floor(MJD)+2400001;

    % fraction of day [d]
    f_DD = MJD-floor(MJD);
    
    % auxiliary quantities
    if a < 2299161
        c = a+1524;
    else
        b = floor((a-1867216.25)/36524.25);
        c = a+b-floor(b/4)+1525;
    end
    d = floor((c-121.1)/365.25);
    e = floor(365.25*d);
    f = floor((c-e)/30.6001);
    
    % day of month [d]
    DD = c-e-floor(30.6001*f);
    
    % month of year [mo]
    MM = f-1-12*floor(f/14);

    % year [y]
    YYYY = d-4715-floor((7+MM)/10);

    % hours, minutes, and seconds [h,m,s]
    [hh,mm,ss] = f2hms(f_DD);

    % Gregorian date [y,mo,d,h,m,s]
    cal = [YYYY,MM,DD,hh,mm,ss];
    
end