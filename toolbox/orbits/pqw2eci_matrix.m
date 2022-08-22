%==========================================================================
%
% pqw2eci_matrix  Rotation matrix from perifocal (PQW) frame to Earth-
% centered inertial (ECI) frame.
%
%   R_pqw2eci = pqw2eci_matrix(i,Om,w)
%
% See also pqw2eci_matrix.
%
% Author: Tamas Kis
% Last Update: 2022-02-16
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (p. 168)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   i           - (1×1 double) inclination [rad]
%   Om          - (1×1 double) right ascension of the ascending node [rad]
%   w           - (1×1 double) argument of periapsis [rad]
%
% -------
% OUTPUT:
% -------
%   R_pqw2eci   - (3×3 double) rotation matrix (PQW --> ECI)
%
%==========================================================================
function R_pqw2eci = pqw2eci_matrix(i,Om,w)
    R_pqw2eci = rot313(-w,-i,-Om);
end