%==========================================================================
%
% nu2E  Eccentric anomaly from true anomaly.
%
%   E = nu2E(nu,e)
%
% See also E2M, E2nu, M2E, M2nu, nu2M.
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (2-14) (p. 48)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   nu      - (1×1 double) true anomaly [rad]
%   e       - (1×1 double) eccentricity [-]
%
% -------
% OUTPUT:
% -------
%   E       - (1×1 double) eccentric anomaly [rad]
%
% -----
% NOTE:
% -----
%   --> ν,E ∈ [0,2π)
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function E = nu2E(nu,e)
    E = mod(2*atan(sqrt((1-e)/(1+e))*tan(nu/2)),2*pi);
end