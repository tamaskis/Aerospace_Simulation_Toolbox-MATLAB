%==========================================================================
%
% nu2M  Mean anomaly from true anomaly.
%
%   M = nu2M(nu,e)
%
% See also E2M, E2nu, M2E, M2nu, nu2E.
%
% Author: Tamas Kis
% Last Update: 2022-02-05
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
%   M       - (1×1 double) mean anomaly [rad]
%
% -----
% NOTE:
% -----
%   --> M,ν ∈ [0,2π)
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function M = nu2M(nu,e)

    % eccentric anomaly [rad]
    E = nu2E(nu,e);

    % mean anomaly [rad]
    M = E2M(E,e);
    
end