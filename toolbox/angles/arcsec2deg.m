%==========================================================================
%
% arcsec2deg  Arcseconds to degrees.
%
%   theta_deg = arcsec2deg(theta_arcsec)
%
% See also arcsec2rad, deg2arcsec, deg2dms, deg2rad, dms2deg, dms2rad,
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
%   theta_arcsec    - (1×1 double) angle in arcseconds ["]
%
% -------
% OUTPUT:
% -------
%   theta_deg       - (1×1 double) angle in degrees [°]
%
%==========================================================================
function theta_deg = arcsec2deg(theta_arcsec)
    theta_deg = (1/3600)*theta_arcsec;
end