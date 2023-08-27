%==========================================================================
%
% rv2e_vec  Eccentricity vector from position and velocity.
%
%   e_vec = rv2e_vec(r,v,mu)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-08-27
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
%   r       - (3×1 double) position expressed in the inerial frame [m]
%   v 	    - (3×1 double) inertial velocity expressed in the inertial
%             frame [m/s]
%   mu      - (1×1 double) standard gravitational parameter [m³/s²]
%
% -------
% OUTPUT:
% -------
%   e_vec   - (3×1 double) eccentricity vector expressed in the inertial
%             frame [-]
%
%==========================================================================
function e_vec = rv2e_vec(r,v,mu)
    e_vec = ((dot(v,v)/mu)-(1/inorm(r)))*r-(idot(r,v)/mu)*v;
end