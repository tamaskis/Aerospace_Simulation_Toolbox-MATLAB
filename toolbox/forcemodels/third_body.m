%==========================================================================
%
% third_body  Perturbing acceleration due to third-body gravity.
%
%   f3 = third_body(r,r3,mu3)
%
% Author: Tamas Kis
% Last Update: 2022-01-24
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (3.37) (p. 69)
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (8-34) (p. 574)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r       - (3×1 double) satellite position [m]
%   r3      - (3×1 double) third-body position [m]
%   mu3     - (1×1 double) third-body gravitational parameter [m^3/s^2]
%
% -------
% OUTPUT:
% -------
%   f3      - (3×1 double) perturbing acceleration due to third-body
%             gravity [m/s^2]
%
% -----
% NOTE:
% -----
%   --> "r" and "r3" must be resolved in the same geocentric coordinate 
%       frame.
%
%==========================================================================
function f3 = third_body(r,r3,mu3)
    f3 = mu3*(((r3-r)/inorm(r3-r)^3)-(r3/inorm(r3)^3));
end