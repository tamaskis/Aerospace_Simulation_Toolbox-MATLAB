%==========================================================================
%
% dadX_two_body  Partial derivatives of two-body/Keplerian gravitational 
% acceleration with respect to position and inertial velocity.
%
%   [dadr_kep,dadv_kep] = dadX_two_body(r)
%
% Author: Tamas Kis
% Last Update: 2022-02-27
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (7.56) (p. 244)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r           - (3×1 double) position [m]
%
% -------
% OUTPUT:
% -------
%   dadr_kep    - (3×3 double) partial derivative of two-body/Keplerian 
%                 gravitational acceleration w.r.t. position [1/s^2]
%   dadv_kep    - (3×3 double) partial derivative of two-body/Keplerian 
%                 gravitational acceleration w.r.t. inertial velocity [1/s]
%
% -----
% NOTE:
% -----
%   --> "r" must be defined in a geocentric coordinate frame.
%
%==========================================================================
function [dadr_kep,dadv_kep] = dadX_two_body(r)
    
    % Earth gravitational parameter [m^3/s^2]
    mu = MU_EARTH;
    
    % position vector magnitude [m]
    r_mag = inorm(r);
    
    % partial derivative of two-body/Keplerian gravitational acceleration 
    % w.r.t. position [1/s^2]
    dadr_kep = -mu*((eye(3,3)/r_mag^3)-(3*(r*r.')/r_mag^5));
    
    % partial derivative of two-body/Keplerian gravitational acceleration 
    % w.r.t. inertial velocity [1/s]
    dadv_kep = zeros(3,3);
    
end