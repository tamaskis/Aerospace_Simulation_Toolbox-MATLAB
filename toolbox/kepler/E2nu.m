%==========================================================================
%
% E2nu  True anomaly from eccentric anomaly.
%
%   nu = E2nu(E,e)
%
% See also E2M, M2E, M2nu, nu2E, nu2M.
%
% Author: Tamas Kis
% Last Update: 2022-03-19
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (2-13) (p. 48)
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
%   nu      - (1×1 double) true anomaly [rad]
%
% -----
% NOTE:
% -----
%   --> ν,E ∈ [0,2π)
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function nu = E2nu(E,e)
    nu = imod(2*atan(sqrt((1+e)/(1-e))*tan(E/2)),2*pi);
end