%==========================================================================
%
% rv2e  Eccentricity from position and velocity.
%
%   e = rv2e(r,v,mu)
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
%   e       - (1×1 double) eccentricity [-]
%
%==========================================================================
function e = rv2e(r,v,mu)
    
    % eccentricity vector expressed in the inertial frame
    e_vec = rv2e_vec(r,v,mu);
    
    % eccentricity
    e = inorm(e_vec);
    
end