%==========================================================================
%
% mjd2f  Fraction of day from modified Julian date.
%
%   f_DD = mjd2f(MJD)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, jd2t, mjd2cal,
% mjd2jd, mjd2t.
%
% Author: Tamas Kis
% Last Update: 2022-02-17
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
%   f_DD    - (1×1 double) fraction of day [d]
%
%==========================================================================
function f_DD = mjd2f(MJD)
    if MJD > 0
        f_DD = MJD-floor(MJD);
    else
        f_DD = ceil(MJD)-MJD;
    end
end