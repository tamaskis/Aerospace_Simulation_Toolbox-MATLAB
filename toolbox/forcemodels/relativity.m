%==========================================================================
%
% relativity  Perturbing acceleration due to relativistic effects.
%
%   f_rel = relativity(r,v)
%
% Author: Tamas Kis
% Last Update: 2022-02-10
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (3.146) (p. 111)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r       - (3×1 double) position [m]
%   v       - (3×1 double) inertial velocity [m/s]
%
% -------
% OUTPUT:
% -------
%   f_rel   - (3×1 double) perturbing acceleration due to relativistic
%             effects [m/s^2]
%
% -----
% NOTE:
% -----
%   --> All vectors must be relative to an inertial frame.
%   --> "r" and "v" must be resolved in the same coordinate frame.
%
%==========================================================================
function f_rel = relativity(r,v)

    % parameters
    mu = MU_EARTH;      % Earth gravitational parameter [m^3/s^2]
    c = C_LIGHT;        % speed of light [m/s]
    
    % position [m] and inertial velocity [m/s] magnitudes
    r_mag = inorm(r);
    v_mag = inorm(v);
    
    % satellite unit position and unit inertial velocity vectors,
    % resolved in ECI frame
    r_hat = r/r_mag;
    v_hat = r/r_mag;
    
    % perturbing acceleration due to relativistic effects [m/s^2]
    f_rel = (mu/r_mag^2)*(((4*mu)/(c^2*r_mag)-(v_mag^2/c^2))*r_hat+(4*...
        v_mag^2/c^2)*idot(r_hat,v_hat)*v_hat);

end