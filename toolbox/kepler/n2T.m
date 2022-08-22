%==========================================================================
%
% n2T  Orbital period from mean motion.
%
%   T = n2T(n)
%
% See also a2n, a2T, n2a, T2a, T2n.
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
%   n       - (1×1 double) mean motion [rad/s]
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
function T = n2T(n)
    T = (2*pi)/n;
end