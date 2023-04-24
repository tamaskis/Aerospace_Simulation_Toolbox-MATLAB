%==========================================================================
%
% iau06  Rotation matrices and Earth angular velocity from the IAU2006/2000
% CIO based theory.
%
%   [R_itrf2gcrf,R_gcrf2itrf,w_gcrf,Q,R,W] = iau06(MJD_UT1,MJD_TT,xp,yp,...
%       dX,dY,LOD,XYs_iau06)
%
% See also eop_iau06.
%
% Author: Tamas Kis
% Last Update: 2022-03-01
%
% REFERENCES:
%   [1] IERS Technical Note No. 36, Eq. (5.1) (p. 43)
%       https://www.iers.org/SharedDocs/Publikationen/EN/IERS/Publications/tn/TechnNote36/tn36.pdf?__blob=publicationFile&v=1
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (p. 220)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UT1     - (1×1 double) UT1 (Universal Time 1) [MJD]
%   MJD_TT      - (1×1 double) TT (Terrestrial Time) [MJD]
%   xp          - (1×1 double) polar coordinate of the CIP ["]
%   yp          - (1×1 double) polar coordinate of the CIP ["]
%   dX          - (1×1 double) correction term for X [mas]
%   dY          - (1×1 double) correction term for Y [mas]
%   LOD         - (1×1 double) length of day [ms]
%   XYs_iau06   - (1×1 struct) data for calculating X, Y, and s
%       • ax    - (1600×1 double) ax coefficients for X [rad]
%       • ay    - (1275×1 double) ay coefficients for Y [rad]
%       • as    - (66×1 double) ay coefficients for s [rad]
%       • bx    - (1600×1 double) bx coefficients for X [rad]
%       • by    - (1275×1 double) by coefficients for Y [rad]
%       • bs    - (66×1 double) by coefficients for s [rad]
%       • M     - (1600×14 double) fundamental argument coefficients for X
%       • N     - (1275×14 double) fundamental argument coefficients for Y
%       • O     - (66×14 double) fundamental argument coefficients for s
%
% -------
% OUTPUT:
% -------
%   R_itrf2gcrf - (3×3 double) rotation matrix (ITRF --> GCRF)
%   R_gcrf2itrf - (3×3 double) rotation matrix (GCRF --> ITRF)
%   w_gcrf      - (3×1 double) Earth angular velocity resolved in GCRF
%                 [rad/s]
%   Q           - (3×3 double) precession-nutation matrix (CIRS --> GCRF)
%   R           - (3×3 double) sidereal-rotation matrix (TIRS --> CIRS)
%   W           - (3×3 double) polar-motion matrix (ITRF --> TIRS)
%
%==========================================================================
function [R_itrf2gcrf,R_gcrf2itrf,w_gcrf,Q,R,W] = iau06(MJD_UT1,MJD_TT,...
    xp,yp,dX,dY,LOD,XYs_iau06)
    
    % Julian centuries since J2000.0 of TT [c]
    T_TT = mjd2t(MJD_TT);
    
    % precession-nutation matrix
    Q = Q_iau06(T_TT,dX,dY,XYs_iau06);
    
    % sidereal-rotation matrix
    R = R_iau06(MJD_UT1);
    
    % polar-motion matrix
    W = W_iau06(T_TT,xp,yp);
    
    % rotation matrix from ITRF to GCRF
    R_itrf2gcrf = Q*R*W;
    
    % rotation matrix from GCRF to ITRF
    R_gcrf2itrf = R_itrf2gcrf.';
    
    % angular velocity of the Earth resolved in the GCRF [rad/s]
    w_gcrf = w_earth_iau06(LOD,Q,R);
    
end