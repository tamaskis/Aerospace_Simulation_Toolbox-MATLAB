%==========================================================================
%
% M2nu  True anomaly from mean anomaly.
%
%   nu = M2nu(M,e)
%
% See also E2M, E2nu, M2E, nu2E, nu2M.
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   M       - (1×1 double) mean anomaly [rad]
%   e       - (1×1 double) eccentricity [-]
%
% -------
% OUTPUT:
% -------
%   nu      - (1×1 double) true anomaly [rad]
%
% -----
% NOTE:
% -----
%   --> M,ν ∈ [0,2π)
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function nu = M2nu(M,e)

    % eccentric anomaly [rad]
    E = M2E(M,e);

    % true anomaly [rad]
    nu = E2nu(E,e);
    
end