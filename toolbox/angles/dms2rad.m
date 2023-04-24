%==========================================================================
%
% dms2rad  Degree-minute-second to radians.
%
%   theta_rad = dms2rad(d,m,s)
%
% See also arcsec2deg, arcsec2rad, deg2arcsec, deg2dms, deg2rad, dms2deg,
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
%   d           - (1×1 double) degrees [°]
%   m           - (1×1 double) arcminutes [']
%   s           - (1×1 double) arcseconds ["]
%
% -------
% OUTPUT:
% -------
%   theta_rad   - (1×1 double) angle in radians [rad]
%
%==========================================================================
function theta_rad = dms2rad(d,m,s)
    
    % angle in degrees [°]
    theta_deg = dms2deg(d,m,s);
    
    % angle in radians [rad]
    theta_rad = deg2rad(theta_deg);
    
end