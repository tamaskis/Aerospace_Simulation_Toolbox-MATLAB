%==========================================================================
%
% dadX_third_body  Partial derivatives of third-body gravitational 
% acceleration with respect to position and inertial velocity.
%
%   [dadr_3,dadv_3] = dadX_third_body(r,r3,mu3)
%
% Author: Tamas Kis
% Last Update: 2022-03-01
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (7.75) (p. 248)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r       - (3×1 double) satellite position [m]
%   r3      - (3×1 double) third-body position [m]
%   mu3     - (1×1 double) third-body gravitational parameter [m^3/s^2]
%
% -------
% OUTPUT:
% -------
%   dadr_3  - (3×3 double) partial derivative of third-body gravitational
%             acceleration w.r.t. position [1/s^2]
%   dadv_3  - (3×3 double) partial derivative of third-body gravitational
%             acceleration w.r.t. inertial velocity [1/s]
%
% -----
% NOTE:
% -----
%   --> "r" and "r3" must be resolved in the same geocentric coordinate 
%       frame.
%
%==========================================================================
function [dadr_3,dadv_3] = dadX_third_body(r,r3,mu3)
    
    % position of the satellite with respect to the third body [m]
    r_rel = r-r3;
    
    % magnitude of relative position [m]
    r_rel_mag = inorm(r_rel);
    
    % partial derivative of third-body gravitational acceleration w.r.t. 
    % position [1/s^2]
    dadr_3 = -mu3*((eye(3,3)/r_rel_mag^3)+(3*(r_rel*r_rel.')/r_rel_mag^5));
    
    % partial derivative of third-body gravitational acceleration w.r.t. 
    % inertial velocity [1/s]
    dadv_3 = zeros(3,3);
    
end