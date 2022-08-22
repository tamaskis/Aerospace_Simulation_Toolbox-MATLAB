%==========================================================================
%
% jd2mjd  Determines the modified Julian date from the Julian date.
%
%   MJD = jd2mjd(JD)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2t, mjd2cal, mjd2f,
% mjd2jd, mjd2t.
%
% Author: Tamas Kis
% Last Update: 2022-02-17
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (A.1) (p. 319)
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
%   MJD     - (1×1 double) modified Julian date [d]
%
%==========================================================================
function MJD = jd2mjd(JD)
    MJD = JD-2400000.5;
end