%==========================================================================
%
% eci2ecef  ECEF position and velocity from ECI position and velocity.
%
%   [r_ecef,v_ecef] = eci2ecef(r_eci,v_eci,w_eci,R_eci2ecef)
%
% See also ecef2eci.
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
%   r_eci       - (3×1 double) position resolved in ECI frame
%   v_eci       - (3×1 double) inertial velocity resolved in ECI frame
%   w_eci       - (3×1 double) Earth angular velocity resolved in ECI frame
%                 [rad/s]
%   R_eci2ecef  - (1×1 double) rotation matrix (ECI --> ECEF)
%
% -------
% OUTPUT:
% -------
%   r_ecef  - (3×1 double) position resolved in ECEF frame
%   v_ecef  - (3×1 double) ECEF velocity resolved in ECEF frame
%
% -----
% NOTE:
% -----
%   --> "r_eci" and "v_eci" can be input in any units, but they MUST be 
%       consistent. The units of "r_ecef" will match those of "r_eci", and 
%       the units of "v_ecef" will match those of "v_eci".
%   --> By definition, the angular velocity of the Earth is defined as the
%       angular velocity of the ECEF frame with respect to the ECI frame.
%
%==========================================================================
function [r_ecef,v_ecef] = eci2ecef(r_eci,v_eci,w_eci,R_eci2ecef)

    % position resolved in ECEF frame
    r_ecef = R_eci2ecef*r_eci;

    % ECEF velocity resolved in ECEF frame
    v_ecef = R_eci2ecef*(v_eci-cross(w_eci,r_eci));
    
end