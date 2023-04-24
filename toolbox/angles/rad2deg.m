%==========================================================================
%
% rad2deg  Radians to degrees.
%
%   theta_deg = rad2deg(theta_deg)
%
% See also arcsec2deg, arcsec2rad, deg2arcsec, deg2dms, deg2rad, dms2deg,
% dms2rad, rad2arcsec, rad2dms.
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
%   theta_rad   - (1×1 double) angle in radians [rad]
%
% -------
% OUTPUT:
% -------
%   theta_deg   - (1×1 double) angle in degrees [°]
%
%==========================================================================
function theta_deg = rad2deg(theta_rad)
    theta_deg = (180/pi)*theta_rad;
end