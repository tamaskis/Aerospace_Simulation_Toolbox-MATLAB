%==========================================================================
%
% jd2mjd  Determines the modified Julian date from the Julian date.
%
%   MJD = jd2mjd(JD)
%
% See also cal2doy, cal2mjd, doy2cal, f2hms, hms2f, jd2t, mjd2cal, mjd2f,
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
%   MJD     - (1×1 double) modified Julian date [d]
%
%==========================================================================
function MJD = jd2mjd(JD)
    MJD = JD-2400000.5;
end