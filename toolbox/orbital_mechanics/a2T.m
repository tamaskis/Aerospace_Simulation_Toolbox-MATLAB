%==========================================================================
%
% a2T  Orbital period from semi-major axis.
%
%   T = a2T(a)
%   T = a2T(a,mu)
%
% See also a2n, n2a, n2T, T2a, T2n.
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (1-26) (p. 30)
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
%   T       - (1×1 double) orbital period [s]
%
% -----
% NOTE:
% -----
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function T = a2T(a,mu)
    
    % defaults gravitational parameter to Earth's if not input [m^3/s^2]
    if nargin == 1
        mu = MU_EARTH;
    end
    
    % orbital period [s]
    T = 2*pi*sqrt(a^3/mu);
    
end