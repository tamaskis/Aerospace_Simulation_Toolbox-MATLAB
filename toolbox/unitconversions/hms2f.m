%==========================================================================
%
% hms2f  Fraction of day from hours, minutes, and seconds.
%
%   f_DD = hms2f(hh,mm,ss)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, jd2mjd, jd2t, mjd2cal, mjd2f,
% mjd2jd, mjd2t.
%
% Author: Tamas Kis
% Last Update: 2022-02-17
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       (p. 199)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   hh      - (1×1 double) hours [h]
%   mm      - (1×1 double) minutes [m]
%   ss      - (1×1 double) seconds [s]
%
% -------
% OUTPUT:
% -------
%   f_DD    - (1×1 double) fraction of day [d]
%
%==========================================================================
function f_DD = hms2f(hh,mm,ss)
    f_DD = (hh/24)+(mm/1440)+(ss/86400);
end