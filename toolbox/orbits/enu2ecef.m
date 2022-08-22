%==========================================================================
%
% enu2ecef  ENU position and velocity from ECEF position and velocity.
%
%   r_ecef = enu2ecef(rho_enu,r0_ecef)
%   [r_ecef,v_ecef] = enu2ecef(rho_enu,r0_ecef,rho_dot_enu)
%   [r_ecef,v_ecef] = enu2ecef(rho_enu,r0_ecef,rho_dot_enu,v0_ecef)
%
% See also ecef2enu.
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
%   rho_enu     - (3×1 double) ENU position resolved in ENU frame
%   r0_ecef     - (3×1 double) origin of ENU frame resolved in ECEF frame
%   rho_dot_enu - (3×1 double) (OPTIONAL) ENU velocity resolved in ENU 
%                 frame
%   v0_ecef     - (3×1 double) (OPTIONAL) ECEF velocity of ENU frame's 
%                 origin resolved in ECEF frame
%
% -------
% OUTPUT:
% -------
%   r_ecef      - (3×1 double) satellite position resolved in ECEF frame
%   v_ecef      - (3×1 double) satellite ECEF velocity resolved in ECEF
%                 frame
%
% -----
% NOTE:
% -----
%   --> "rho_enu", "r0_ecef", "rho_dot_enu", and "v0_ecef" can be input in 
%       any units, but they MUST be consistent. The units of "r_ecef" will
%       match those of "rho_enu", and the units of "v_ecef" will match
%       those of "rho_dot_enu".
%
%==========================================================================
function [r_ecef,v_ecef] = enu2ecef(rho_enu,r0_ecef,rho_dot_enu,v0_ecef)

    % -------------
    % ENU position.
    % -------------

    % rotation matrix (ENU --> ECEF)
    R_enu2ecef = enu2ecef_matrix(r0_ecef);

    % ENU position resolved in ECEF frame
    rho_ecef = R_enu2ecef*rho_enu;

    % ECEF position resolved in ECEF frame
    r_ecef = r0_ecef+rho_ecef;

    % -------------
    % ENU velocity.
    % -------------

    if (nargin >= 3) && ~isempty(rho_dot_enu)

        % assume reference point is stationary if not specified otherwise
        if (nargin < 4) || isempty(v0_ecef)
            v0_ecef = [0;0;0];
        end

        % angular velocity of ENU frame relative to AND resolved in ECEF 
        % frame [rad/s]
        w_enu_ecef = rv2w(r0_ecef,v0_ecef);
        
        % angular velocity of ECEF frame relative to AND resolved in ENU 
        % frame [rad/s]
        w_ecef_enu = -(R_enu2ecef.')*w_enu_ecef;
        
        % ECEF relative velocity resolved in ENU frame
        ecef_rho_dot_enu = rho_dot_enu+cross(w_ecef_enu,rho_enu);
        
        % ECEF relative velocity resolved in ECEF frame
        ecef_rho_dot_ecef = R_enu2ecef*ecef_rho_dot_enu;
        
        % ECEF velocity resolved in ECEF frame
        v_ecef = v0_ecef+ecef_rho_dot_ecef;
        
    end
    
end