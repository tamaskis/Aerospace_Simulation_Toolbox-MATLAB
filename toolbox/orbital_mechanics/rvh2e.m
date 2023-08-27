%==========================================================================
%
% rvh2e  Eccentricity from position, velocity, and specific angular
% momentum.
%
%   e = rvh2e(r,v,h,mu)
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
%   h 	    - (3×1 double) inertial specific angular momentum expressed in
%             the inertial frame [m²/s]
%   mu      - (1×1 double) standard gravitational parameter [m³/s²]
%
% -------
% OUTPUT:
% -------
%   e       - (1×1 double) eccentricity [-]
%
%==========================================================================
function e = rvh2e(r,v,h,mu)
    
    % eccentricity vector expressed in the inertial frame
    e_vec = rvh2e_vec(r,v,h,mu);
    
    % eccentricity
    e = inorm(e_vec);
    
end