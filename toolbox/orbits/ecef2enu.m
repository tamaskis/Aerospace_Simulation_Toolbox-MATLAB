%==========================================================================
%
% ecef2enu  ENU position and velocity from ECEF position and velocity.
%
%   rho_enu = ecef2enu(r_ecef,r0_ecef)
%   [rho_enu,rho_dot_enu] = ecef2enu(r_ecef,r0_ecef,v_ecef)
%   [rho_enu,rho_dot_enu] = ecef2enu(r_ecef,r0_ecef,v_ecef,v0_ecef)
%
% See also enu2ecef.
%
% Author: Tamas Kis
% Last Update: 2022-02-27
%
% REFERENCES:
%   [1] https://gssc.esa.int/navipedia/index.php/Transformations_between_ECEF_and_ENU_coordinates
%   [2] Montenbruck and Gill, "Satellite Orbits" (pp. 36-38)
%   [3] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 262-263)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef      - (3×1 double) satellite position resolved in ECEF frame
%   r0_ecef     - (3×1 double) origin of ENU frame resolved in ECEF frame
%   v_ecef      - (3×1 double) (OPTIONAL) satellite ECEF velocity resolved 
%                 in ECEF frame
%   v0_ecef     - (3×1 double) (OPTIONAL) ECEF velocity of ENU frame's 
%                 origin resolved in ECEF frame
%
% -------
% OUTPUT:
% -------
%   rho_enu     - (3×1 double) ENU position resolved in ENU frame
%   rho_dot_enu - (3×1 double) ENU velocity resolved in ENU frame
%
% -----
% NOTE:
% -----
%   --> "r_ecef", "r0_ecef", "v_ecef", and "v0_ecef" can be input in any 
%       units, but they MUST be consistent. The units of "rho_enu" will
%       match those of "r_ecef", and the units of "rho_dot_enu" will match
%       those of "v_ecef".
%
%==========================================================================
function [rho_enu,rho_dot_enu] = ecef2enu(r_ecef,r0_ecef,v_ecef,v0_ecef)

    % -------------
    % ENU position.
    % -------------

    % rotation matrix (ECEF --> ENU)
    R_ecef2enu = ecef2enu_matrix(r0_ecef);

    % ENU position resolved in ECEF frame
    rho_ecef = r_ecef-r0_ecef;

    % ENU position resolved in ENU frame
    rho_enu = R_ecef2enu*rho_ecef;

    % -------------
    % ENU velocity.
    % -------------

    if (nargin >= 3) && ~isempty(v_ecef)

        % assume reference point is stationary if not specified otherwise
        if (nargin < 4) || isempty(v0_ecef)
            v0_ecef = [0;0;0];
        end
    
        % ECEF relative velocity resolved in ECEF frame
        ecef_rho_dot_ecef = v_ecef-v0_ecef;
    
        % angular velocity of ENU frame relative to AND resolved in ECEF 
        % frame [rad/s]
        w_enu_ecef = rv2w(r0_ecef,v0_ecef);
    
        % ENU velocity resolved in ECEF frame
        rho_dot_ecef = ecef_rho_dot_ecef+cross(w_enu_ecef,rho_ecef);
    
        % ENU velocity resolved in ENU frame
        rho_dot_enu = R_ecef2enu*rho_dot_ecef;

    end
    
end