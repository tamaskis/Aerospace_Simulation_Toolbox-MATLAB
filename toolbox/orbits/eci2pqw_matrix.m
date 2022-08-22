%==========================================================================
%
% eci2pqw_matrix  Rotation matrix from Earth-centered inertial (ECI) frame
% to perifocal (PQW) frame.
%
%   R_eci2pqw = eci2pqw_matrix(i,Om,w)
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
%   R_eci2pqw   - (3×3 double) rotation matrix (ECI --> PQW)
%
%==========================================================================
function R_eci2pqw = eci2pqw_matrix(i,Om,w)
    R_eci2pqw = rot313(Om,i,w);
end