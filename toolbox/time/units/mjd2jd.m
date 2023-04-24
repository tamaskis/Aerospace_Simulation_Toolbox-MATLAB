%==========================================================================
%
% mjd2jd  Determines the Julian date from the modified Julian date.
%
%   JD = mjd2jd(MJD)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2mjd, jd2t, mjd2cal,
% mjd2f, mjd2t.
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