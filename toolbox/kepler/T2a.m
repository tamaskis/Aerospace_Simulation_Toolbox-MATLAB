%==========================================================================
%
% T2a  Semi-major axis from orbital period.
%
%   a = T2a(T)
%   a = T2a(T,mu)
%
% See also a2n, a2T, n2a, n2T, T2n.
%
% Author: Tamas Kis
% Last Update: 2022-02-05
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (1-29) (p. 31)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   T       - (1×1 double) orbital period [s]
%   mu      - (1×1 double) (OPTIONAL) gravitational parameter [m^3/s^2]
%
% -------
% OUTPUT:
% -------
%   a       - (1×1 double) semi-major axis [m]
%
% -----
% NOTE:
% -----
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function a = T2a(T,mu)
    
    % defaults gravitational parameter to Earth's if not input [m^3/s^2]
    if nargin == 1
        mu = MU_EARTH;
    end
    
    % semi-major axis [m]
    a = (mu*(T/(2*pi))^2)^(1/3);
    
end