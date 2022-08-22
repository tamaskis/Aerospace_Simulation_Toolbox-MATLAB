%==========================================================================
%
% E2M  Mean anomaly from eccentric anomaly.
%
%   M = E2M(E,e)
%
% See also E2nu, M2E, M2nu, nu2E, nu2M.
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (2-4) (p. 45)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   E       - (1×1 double) eccentric anomaly [rad]
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
%   --> M,E ∈ [0,2π)
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function M = E2M(E,e)
    M = E-e*sin(E);  
end