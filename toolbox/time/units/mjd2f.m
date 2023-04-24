%==========================================================================
%
% mjd2f  Fraction of day from modified Julian date.
%
%   f_DD = mjd2f(MJD)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, jd2t, mjd2cal,
% mjd2jd, mjd2t.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-01
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Aerospace_Simulation.pdf
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
    f_DD = MJD-floor(MJD);
end