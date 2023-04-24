%==========================================================================
%
% deg2arcsec  Degrees to arcseconds.
%
%   theta_arcsec = deg2arcsec(theta_deg)
%
% See also arcsec2deg, arcsec2rad, deg2dms, deg2rad, dms2deg, dms2rad,
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
%   theta_deg       - (1×1 double) angle in degrees [°]
%
% -------
% OUTPUT:
% -------
%   theta_arcsec    - (1×1 double) angle in arcseconds ["]
%
%==========================================================================
function theta_arcsec = deg2arcsec(theta_deg)
    theta_arcsec = 3600*theta_deg;
end