%==========================================================================
%
% n2a  Semi-major axis from mean motion.
%
%   a = n2a(n)
%   a = n2a(n,mu)
%
% See also a2n, a2T, n2T, T2a, T2n.
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
%   n       - (1×1 double) mean motion [rad/s]
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
function a = n2a(n,mu)

    % defaults gravitational parameter to Earth's if not input [m^3/s^2]
    if nargin == 1
        mu = MU_EARTH;
    end

    % semi-major axis [m]
    a = (mu/n^2)^(1/3);
    
end