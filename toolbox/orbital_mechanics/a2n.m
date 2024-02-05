%==========================================================================
%
% a2n  Mean motion from semi-major axis.
%
%   n = a2n(a)
%   n = a2n(a,mu)
%
% See also a2T, n2a, n2T, T2a, T2n.
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (1-27) (p. 31)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   a       - (1×1 double) semi-major axis [m]
%   mu      - (1×1 double) (OPTIONAL) gravitational parameter [m^3/s^2]
%
% -------
% OUTPUT:
% -------
%   n       - (1×1 double) mean motion [rad/s]
%
% -----
% NOTE:
% -----
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function n = a2n(a,mu)

    % defaults gravitational parameter to Earth's if not input [m^3/s^2]
    if nargin == 1
        mu = MU_EARTH;
    end

    % mean motion [rad/s]
    n = sqrt(mu/a^3);
    
end