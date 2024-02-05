%==========================================================================
%
% T2n  Mean motion from orbital period.
%
%   n = T2n(T)
%
% See also a2n, a2T, n2a, n2T, T2a.
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
%   T       - (1×1 double) orbital period [s]
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
function n = T2n(T)
    n = (2*pi)/T;
end