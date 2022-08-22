%==========================================================================
%
% w_earth_iau06  Angular velocity of the Earth resolved in the GCRF
% (IAU2006/2000, CIO based).
%
%   w_gcrf = w_earth_iau06(LOD,Q,R)
%
% See also w_earth_approx.
%
% Author: Tamas Kis
% Last Update: 2022-03-01
%
% REFERENCES:
%   [1] https://www.iers.org/IERS/EN/Science/EarthRotation/UT1LOD.html
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (p. 220)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   LOD     - (1×1 double) length of day [ms]
%   Q       - (3×3 double) precession-nutation matrix (CIRS --> GCRF)
%   R       - (3×3 double) sidereal-rotation matrix (TIRS --> CIRS)
%
% -------
% OUTPUT:
% -------
%   w_gcrf  - (3×1 double) Earth angular velocity resolved in GCRF [rad/s]
%
%==========================================================================
function w_gcrf = w_earth_iau06(LOD,Q,R)
    
    % convert length of day to seconds
    LOD = 0.001*LOD;

    % rotation rate of the Earth [rad/s]
    w_earth = (7.292115146706979e-5)*(1-(LOD/86400));

    % angular velocity of the Earth resolved in the TIRS frame [rad/s]
    w_TIRS = [0;
              0;
              w_earth];

    % angular velocity of the Earth resolved in the GCRF [rad/s]
    w_gcrf = Q*R*w_TIRS;
    
end