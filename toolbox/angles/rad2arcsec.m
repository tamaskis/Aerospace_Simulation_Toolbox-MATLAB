%==========================================================================
%
% rad2arcsec  Radians to arcseconds.
%
%   theta_sec = rad2arcsec(theta_rad)
%
% See also arcsec2deg, arcsec2rad, deg2arcsec, deg2dms, deg2rad, dms2deg,
% dms2rad, rad2deg, rad2dms.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-04
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
%   theta_rad       - (1×1 double) angle in radians [rad]
%
% -------
% OUTPUT:
% -------
%   theta_arcsec    - (1×1 double) angle in arcseconds ["]
%
%==========================================================================
function theta_arcsec = rad2arcsec(theta_rad)
    theta_arcsec = (648000/pi)*theta_rad;
end