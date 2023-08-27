%==========================================================================
%
% eclipse_cylindrical  Determines if a satellite is in eclipse (cylindrical
% model).
%
%   in_eclipse = eclipse_cylindrical(r,r_sun)
%
% See also eclipse_conical.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-08-14
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
%   r           - (3×1 double) satellite position [m]
%   r_sun       - (3×1 double) Sun position [m]
%
% -------
% OUTPUT:
% -------
%   in_eclipse  - (1×1 logical) true if satellite is in eclipse, false
%                 otherwise
%
% -----
% NOTE:
% -----
%   • r and r_sun must be expressed in the same Earth-centered coordinate
%     frame.
%
%==========================================================================
function in_eclipse = eclipse(r,r_sun)
    
    % Earth mean equatorial radius [m]
    R_earth = R_EARTH;
    
    % Sun unit position vector (pointing from center of Earth towards Sun)
    r_hat_sun = r_sun/inorm(r_sun);
    
    % dot product of satellite position with Sun position unit vector
    d = idot(r,r_hat_sun);
    
    % parallel/perpendicular decomposition of r
    r_parallel = d*r_hat_sun;
    r_perp = r-r_parallel;
    
    % determines if satellite is in eclipse
    if (inorm(r_perp) < R_earth) && (d < 0)
        in_eclipse = true;
    else
        in_eclipse = false;
    end
    
end