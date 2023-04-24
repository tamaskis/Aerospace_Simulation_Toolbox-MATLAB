%==========================================================================
%
% jd2t  Julian centuries since J2000.0 from Julian date.
%
%   T = jd2t(T)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, mjd2cal, mjd2f,
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