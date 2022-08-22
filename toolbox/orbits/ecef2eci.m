%==========================================================================
%
% ecef2eci  ECI position and velocity from ECEF position and velocity.
%
%   [r_eci,v_eci] = ecef2eci(r_ecef,v_ecef,w_eci,R_ecef2eci)
%
% See also eci2ecef.
%
% Author: Tamas Kis
% Last Update: 2022-02-26
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 220, 222)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef      - (3×1 double) position resolved in ECEF frame
%   v_ecef      - (3×1 double) ECEF velocity resolved in ECEF frame
%   w_eci       - (3×1 double) Earth angular velocity resolved in ECI frame
%                 [rad/s]
%   R_ecef2eci  - (1×1 double) rotation matrix (ECEF --> ECI)
%
% -------
% OUTPUT:
% -------
%   r_eci       - (3×1 double) position resolved in ECI frame
%   v_eci       - (3×1 double) inertial velocity resolved in ECI frame
%
% -----
% NOTE:
% -----
%   --> "r_ecef" and "v_ecef" can be input in any units, but they MUST be 
%       consistent. The units of "r_eci" will match those of "r_ecef", and
%       the units of "v_eci" will match those of "v_ecef".
%   --> By definition, the angular velocity of the Earth is defined as the
%       angular velocity of the ECEF frame with respect to the ECI frame.
%
%==========================================================================
function [r_eci,v_eci] = ecef2eci(r_ecef,v_ecef,w_eci,R_ecef2eci)

    % position resolved in ECI frame
    r_eci = R_ecef2eci*r_ecef;

    % inertial velocity resolved in ECI frame
    v_eci = R_ecef2eci*v_ecef+cross(w_eci,r_eci);
    
end