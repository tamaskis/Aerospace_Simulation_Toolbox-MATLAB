%==========================================================================
%
% R_iau06  Sidereal-rotation matrix (IAU2006/2000, CIO based). This matrix
% represents the transformation from the Terrestrial Intermediate Reference
% System (TIRS) to the Celestial Intermediate Reference System (CIRS).
%
%   R = R_iau06(MJD_UT1)
%
% See also ecef2eci_matrix_approx, eci2ecef_matrix_approx, iau06, Q_iau06, 
% W_iau06.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] IERS Technical Note No. 36 (p. 48)
%       https://www.iers.org/SharedDocs/Publikationen/EN/IERS/Publications/tn/TechnNote36/tn36.pdf?__blob=publicationFile&v=1
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 212-213, 220)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UT1 - (1×1 double) UT1 (Universal Time 1) [MJD]
%
% -------
% OUTPUT:
% -------
%   R       - (3×3 double) sidereal-rotation matrix (TIRS --> CIRS)
%
%==========================================================================
function R = R_iau06(MJD_UT1)
    
    % Earth rotation angle [rad]
    ERA = era_iau06(MJD_UT1);

    % sidereal-rotation matrix
    R = rot3(-ERA);
    
end