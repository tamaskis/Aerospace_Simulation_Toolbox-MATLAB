%==========================================================================
%
% deg2rad  Degrees to radians.
%
%   theta_rad = deg2rad(theta_deg)
%
% See also arcsec2deg, arcsec2rad, deg2arcsec, deg2dms, dms2deg, dms2rad,
% rad2arcsec, rad2deg, rad2dms.
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
%   theta_deg   - (1×1 double) angle in degrees [°]
%
% -------
% OUTPUT:
% -------
%   theta_rad   - (1×1 double) angle in radians [rad]
%
%==========================================================================
function theta_rad = deg2rad(theta_deg)
    theta_rad = (pi/180)*theta_deg;
end