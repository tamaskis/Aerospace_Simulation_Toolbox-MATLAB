%==========================================================================
%
% mjd2t  Julian centuries since J2000.0 from modified Julian date.
%
%   T = mjd2t(MJD)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, jd2t, mjd2cal,
% mjd2f, mjd2jd.
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
%   MJD     - (1×1 double) modified Julian date [d]
%
% --------
% OUTPUTS:
% --------
%   T       - (1×1 double) Julian centuries since J2000.0 [c]
%
%==========================================================================
function T = mjd2t(MJD)
    T = (MJD-51544.5)/36525;
end