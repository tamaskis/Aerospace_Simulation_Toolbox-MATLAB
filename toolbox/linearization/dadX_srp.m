%==========================================================================
%
% dadX_srp  Partial derivatives of solar radiation pressure acceleration
% with respect to position and inertial velocity.
%
%   [dadr_srp,dadv_srp] = dadX_srp(r,r_sun,CR,Asrp,m)
%
% Author: Tamas Kis
% Last Update: 2022-02-27
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (7.77) (p. 248)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r           - (3×1 double) satellite position [m]
%   r_sun       - (3×1 double) Sun position [m]
%   CR          - (1×1 double) coefficient of reflectivity
%   Asrp        - (1×1 double) SRP reference area [m^2]
%   m           - (1×1 double) mass [kg]
%
% -------
% OUTPUT:
% -------
%   dadr_srp    - (3×3 double) partial derivative of solar radiation
%                 pressure acceleration w.r.t. position [1/s^2]
%   dadv_srp    - (3×3 double) partial derivative of solar radiation
%                 pressure acceleration w.r.t. inertial velocity [1/s]
%
% -----
% NOTE:
% -----
%   --> "r" and "r_sun" must be resolved in the same coordinate frame.
%
%==========================================================================
function [dadr_srp,dadv_srp] = dadX_srp(r,r_sun,CR,Asrp,m)
    
    % determines if satellite is in eclipse
    in_eclipse = eclipse(r,r_sun);

    % returns 0 if satellite is in eclipse
    if in_eclipse
        dadr_srp = zeros(3,3);
        dadv_srp = zeros(3,3);
        return;
    end

    % solar radiation pressure [N/m^2]
    P_srp = P_SRP;
    
    % position of the satellite with respect to the Sun [m]
    r_rel = r-r_sun;
    
    % magnitude of relative position [m]
    r_rel_mag = inorm(r_rel);
    
    % partial derivative of SRP acceleration w.r.t. position [1/s^2]
    dadr_srp = (P_srp*CR*Asrp/m)*((eye(3,3)/r_rel_mag^3)+(3*(r_rel*...
        r_rel.')/r_rel_mag^5));
    
    % partial derivative of SRP acceleration w.r.t. inertial velocity [1/s]
    dadv_srp = zeros(3,3);
    
end