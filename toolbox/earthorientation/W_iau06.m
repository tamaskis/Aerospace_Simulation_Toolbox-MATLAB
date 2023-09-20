%==========================================================================
%
% W_iau06  Polar-motion matrix (IAU2006/2000, CIO based). This matrix 
% represents the transformation from the International Terrestrial 
% Reference Frame (ITRF) to the Terrestrial Intermediate Reference System
% (TIRS).
%
%   W = W_iau06(T_TT,xp,yp)
%
% See also iau06, Q_iau06, R_iau06.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] IERS Technical Note No. 36 (p. 48)
%       https://www.iers.org/SharedDocs/Publikationen/EN/IERS/Publications/tn/TechnNote36/tn36.pdf?__blob=publicationFile&v=1
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (p. 212)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   T_TT    - (1×1 double) Julian centuries since J2000.0 of TT
%             (Terrestrial Time) [c]
%   xp      - (1×1 double) polar coordinate of the CIP ["]
%   yp      - (1×1 double) polar coordinate of the CIP ["]
%
% -------
% OUTPUT:
% -------
%   W       - (3×3 double) polar-motion matrix (ITRF --> TIRS)
%
%==========================================================================
function W = W_iau06(T_TT,xp,yp)
    
    % s' ["]
    sp = -0.000047*T_TT;

    % converts s', xp, and yp to radians
    sp = arcsec2rad(sp);
    xp = arcsec2rad(xp);
    yp = arcsec2rad(yp);

    % polar-motion matrix
    W = rot3(-sp)*rot2(xp)*rot1(yp);
    
end