%==========================================================================
%
% rv2fpa  Flight path angle from position and velocity.
%
%   phi_fpa = rv2fpa(r,v)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-09-05
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
%   r       - (3×1 double) position expressed in an inertial frame [m]
%   v 	    - (3×1 double) inertial velocity expressed in an inertial frame
%             [m/s]
%
% -------
% OUTPUT:
% -------
%   phi_fpa - (1×1 double) flight path angle [rad]
%
%==========================================================================
function phi_fpa = rv2fpa(r,v)
    phi_fpa = asin(idot(r,v)/(inorm(r)*inorm(v)));
end