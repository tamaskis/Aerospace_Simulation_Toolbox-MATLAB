%==========================================================================
%
% drag  Perturbing acceleration due to atmospheric drag resolved in the ECI
% frame.
%
%   f_D_eci = drag(r_eci,v_eci,w_eci,rho,B)
%
% Author: Tamas Kis
% Last Update: 2022-02-27
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits" (pp. 83-86)
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 551-552)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_eci   - (3×1 double) position resolved in ECI frame [m]
%   v_eci   - (3×1 double) inertial velocity resolved in ECI frame [m/s]
%   w_eci   - (3×1 double) Earth angular velocity resolved in ECI frame 
%             [rad/s]
%   B       - (1×1 double) ballistic coefficient [m^2/kg]
%   rho     - (1×1 double) atmospheric mass density [kg/m^3]
%
% -------
% OUTPUT:
% -------
%   f_D_eci - (3×1 double) perturbing acceleration due to atmospheric drag
%             resolved in ECI frame [m/s^2]
%
%==========================================================================
function f_D_eci = drag(r_eci,v_eci,w_eci,rho,B)
    
    % velocity of satellite rel. to atmosphere resolved in ECI frame [m/s]
    v_rel_eci = v_eci-cross(w_eci,r_eci);
    
    % acceleration due to atmospheric drag [m/s]
    f_D_eci = -0.5*B*rho*inorm(v_rel_eci)*v_rel_eci;

end