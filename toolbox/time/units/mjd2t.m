%==========================================================================
%
% mjd2t  Julian centuries since J2000.0 from modified Julian date.
%
%   T = mjd2t(MJD)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, jd2t, mjd2cal,
% mjd2f, mjd2jd.
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
%   T       - (1×1 double) Julian centuries since J2000.0 [c]
%
%==========================================================================
function T = mjd2t(MJD)
    T = (MJD-51544.5)/36525;
end