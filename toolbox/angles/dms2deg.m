%==========================================================================
%
% dms2deg  Degree-minute-second to degrees.
%
%   theta_deg = dms2deg(d,m,s)
%
% See also arcsec2deg, arcsec2rad, deg2arcsec, deg2dms, deg2rad, dms2rad,
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
%   theta_deg   - (1×1 double) angle in degrees [°]
%
%==========================================================================
function theta_deg = dms2deg(d,m,s)
    theta_deg = d+(m/60)+(s/3600);
end