%==========================================================================
%
% dadX_drag  Partial derivatives of drag acceleration with respect to 
% position and inertial velocity, resolved in the ECI frame.
%
%   [dadr_D,dadv_D] = dadX_drag(r_eci,v_eci,w_eci,B,rho,drhodr,R_ecef2eci)
%
% Author: Tamas Kis
% Last Update: 2022-03-01
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (7.81) (p. 249)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_eci       - (3×1 double) position resolved in ECI frame [m]
%   v_eci       - (3×1 double) inertial velocity resolved in ECI frame 
%                 [m/s]
%   w_eci       - (3×1 double) Earth angular velocity resolved in ECI frame 
%                 [rad/s]
%   B           - (1×1 double) ballistic coefficient [m^2/kg]
%   rho         - (1×1 double) atmospheric mass density [kg/m^3]
%   drhodr      - (3×1 double) partial derivative of atmospheric mass
%                 density w.r.t. position, resolved in ECEF frame [kg/m^4]
%   R_ecef2eci  - (3×3 double) rotation matrix (ECEF --> ECI)
%
% -------
% OUTPUT:
% -------
%   dadr_D      - (3×1 double) partial derivative of drag acceleration
%                 w.r.t. position, resolved in ECI frame [1/s^2]
%   dadv_D      - (3×1 double) partial derivative of drag acceleration
%                 w.r.t. inertial velocity, resolved in ECI frame [1/s]
%
%==========================================================================
function [dadr_D,dadv_D] = dadX_drag(r_eci,v_eci,w_eci,B,rho,drhodr,...
    R_ecef2eci)
    
    % velocity of satellite rel. to atmosphere resolved in ECI frame [m/s]
    v_rel_eci = v_eci-cross(w_eci,r_eci);

    % relative velocity vector magnitude [m/s]
    v_rel = inorm(v_rel_eci);

    % partial derivative of drag acceleration w.r.t. inertial vel. [1/s]
    dadv_D = -(B*rho/2)*(((v_rel_eci*v_rel_eci.')/v_rel)+v_rel*eye(3,3));
    
    % cross product matrix for Earth angular velocity [rad/s]
    wx = cross_matrix(w_eci);

    % partial derivative of atmospheric mass density w.r.t. position
    % resolved in ECI frame [kg/m^4]
    %drhodr_eci = R_ecef2eci*drhodr;

    % partial derivative of drag acceleration w.r.t. position, resolved in
    % ECI frame [1/s^2]
    %dadr_D = -(B*v_rel*v_rel_eci/2)*drhodr_eci-dadv_D*wx;
    dadr_D = -(B*v_rel*v_rel_eci/2)*drhodr-dadv_D*wx;

end