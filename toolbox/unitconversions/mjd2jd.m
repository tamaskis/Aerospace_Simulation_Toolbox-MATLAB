%==========================================================================
%
% mjd2jd  Determines the Julian date from the modified Julian date.
%
%   JD = mjd2jd(MJD)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, jd2t, mjd2cal,
% mjd2f, mjd2t.
%
% Author: Tamas Kis
% Last Update: 2022-02-17
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (A.1) (p. 319)
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
%   JD      - (1×1 double) Julian date [d]
%
%==========================================================================
function JD = mjd2jd(MJD)
    JD = MJD+2400000.5;
end