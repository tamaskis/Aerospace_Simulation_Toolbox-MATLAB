%==========================================================================
%
% jd2t  Julian centuries since J2000.0 from Julian date.
%
%   T = jd2t(T)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, mjd2cal, mjd2f,
% mjd2jd, mjd2t.
%
% Author: Tamas Kis
% Last Update: 2022-02-17
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (3-42) (p. 184)
%
%--------------------------------------------------------------------------
%
% -------
% INPUTS:
% -------
%   JD      - (1×1 double) Julian date [d]
%
% --------
% OUTPUTS:
% --------
%   T       - (1×1 double) Julian centuries since J2000.0 [c]
%
%==========================================================================
function T = jd2t(JD)
    T = (JD-2451545)/36525;
end