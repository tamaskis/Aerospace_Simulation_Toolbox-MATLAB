%==========================================================================
%
% eclipse  Determines if a satellite is in eclipse (cylindrical shadow
% model).
%
%   in_eclipse = eclipse(r,r_sun)
%
% Author: Tamas Kis
% Last Update: 2022-01-24
%
% REFERENCES:
%   [1] D'Amico, "Eclipses and Deterministic Attitude Determination", AA 
%       279C Lecture 10 Slides (pp. 5-8)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r           - (3×1 double) satellite position resolved in ECI frame [m]
%   r_sun       - (3×1 double) Sun position resolved in ECI frame [m]
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
%   --> "r" and "r_sun" must be resolved in the same coordinate frame.
%
%==========================================================================
function in_eclipse = eclipse(r,r_sun)
    
    % Earth mean equatorial radius [m]
    R_earth = R_EARTH;
    
    % Sun unit position vector (pointing from center of Earth towards Sun)
    r_hat_sun = r_sun/inorm(r_sun);
    
    % parallel/perpendicular decomposition of r
    r_parallel = idot(r,r_hat_sun)*r_hat_sun;
    r_perp = r-r_parallel;
    
    % determines if satellite is in eclipse
    if (inorm(r_perp) < R_earth) && (idot(r_sun,r_parallel) < 0)
        in_eclipse = true;
    else
        in_eclipse = false;
    end
    
end