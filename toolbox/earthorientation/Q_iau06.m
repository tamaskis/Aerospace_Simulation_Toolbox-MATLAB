%==========================================================================
%
% Q_iau06  Precession-nutation matrix (IAU2006/2000, CIO based). This
% matrix represents the transformation from the Celestial Intermediate 
% Reference System (CIRS) to the Geocentric Celestial Reference Frame 
% (GCRF).
%
%   Q = Q_iau06(T_TT,dX,dY,XYs_iau06)
%
% See also iau06, load_XYs_iau06, R_iau06, W_iau06.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] IERS Technical Note No. 36 (pp. 49, 54-55, 59, 66-68)
%       https://www.iers.org/SharedDocs/Publikationen/EN/IERS/Publications/tn/TechnNote36/tn36.pdf?__blob=publicationFile&v=1
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 213-215)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   T_TT        - (1×1 double) Julian centuries since J2000.0 of TT
%                 (Terrestrial Time) [c]
%   dX          - (1×1 double) correction term [mas]
%   dY          - (1×1 double) correction term [mas]
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
%   Q       - (3×3 double) precession-nutation matrix (CIRS --> GCRF)
%
%==========================================================================
function Q = Q_iau06(T_TT,dX,dY,XYs_iau06)

    % extract fields of XYs_iau06
    ax = XYs_iau06.ax;
    ay = XYs_iau06.ay;
    as = XYs_iau06.as;
    bx = XYs_iau06.bx;
    by = XYs_iau06.by;
    bs = XYs_iau06.bs;
    M = XYs_iau06.M;
    N = XYs_iau06.N;
    O = XYs_iau06.O;
    
    % fundamental arguments for nutation theory [rad]
    F = fund_arg_iau06(T_TT);

    % converts dX and dY to arcseconds
    dX = 0.001*dX;
    dY = 0.001*dY;

    % converts dX and dY to radians
    dX = arcsec2rad(dX);
    dY = arcsec2rad(dY);
    
    % --------------
    % Calculating X.
    % --------------

    % 0th term
    X0 = (pi/648000)*(-0.016617+2004.191898*T_TT-0.4297829*T_TT^2-...
        0.19861834*T_TT^3+0.000007578*T_TT^4+0.0000059285*T_TT^5);

    % 1st term
    X1 = 0;
    for i = 1:1306
        f = 0; for j = 1:14, f = f+M(i,j)*F(j); end
        X1 = X1+ax(i)*sin(f)+bx(i)*cos(f);
    end

    % 2nd term
    X2 = 0;
    for i = 1307:1559
        f = 0; for j = 1:14, f = f+M(i,j)*F(j); end
        X2 = X2+ax(i)*sin(f)+bx(i)*cos(f);
    end
    X2 = X2*T_TT;

    % 3rd term
    X3 = 0;
    for i = 1560:1595
        f = 0; for j = 1:14, f = f+M(i,j)*F(j); end
        X3 = X3+ax(i)*sin(f)+bx(i)*cos(f);
    end
    X3 = X3*T_TT^2;

    % 4th term
    X4 = 0;
    for i = 1596:1599
        f = 0; for j = 1:14, f = f+M(i,j)*F(j); end
        X4 = X4+ax(i)*sin(f)+bx(i)*cos(f);
    end
    X4 = X4*T_TT^3;

    % 5th term
    f = 0; for j = 1:14, f = f+M(1600,j)*F(j); end
    X5 = T_TT^4*(ax(1600)*cos(f)+bx(1600)*sin(f));

    % X [rad]
    X = X0+X1+X2+X3+X4+X5+dX;

    % --------------
    % Calculating Y.
    % --------------

    % 0th term
    Y0 = (pi/648000)*(-0.006951-0.025896*T_TT-22.4072747*T_TT^2+...
        0.00190059*T_TT^3+0.001112526*T_TT^4+0.0000001358*T_TT^5);

    % 1st term
    Y1 = 0;
    for i = 1:962
        g = 0; for j = 1:14, g = g+N(i,j)*F(j); end
        Y1 = Y1+ay(i)*sin(g)+by(i)*cos(g);
    end

    % 2nd term
    Y2 = 0;
    for i = 963:1239
        g = 0; for j = 1:14, g = g+N(i,j)*F(j); end
        Y2 = Y2+ay(i)*sin(g)+by(i)*cos(g);
    end
    Y2 = Y2*T_TT;

    % 3rd term
    Y3 = 0;
    for i = 1240:1269
        g = 0; for j = 1:14, g = g+N(i,j)*F(j); end
        Y3 = Y3+ay(i)*sin(g)+by(i)*cos(g);
    end
    Y3 = Y3*T_TT^2;

    % 4th term
    Y4 = 0;
    for i = 1270:1274
        g = 0; for j = 1:14, g = g+N(i,j)*F(j); end
        Y4 = Y4+ay(i)*sin(g)+by(i)*cos(g);
    end
    Y4 = Y4*T_TT^3;

    % 5th term
    g = 0; for j = 1:14, g = g+N(1275,j)*F(j); end
    Y5 = T_TT^4*(ay(1275)*cos(g)+by(1275)*sin(g));

    % Y [rad]
    Y = Y0+Y1+Y2+Y3+Y4+Y5+dY;
    
    % --------------
    % Calculating s.
    % --------------

    % 0th term
    s0 = (pi/648000)*(-0.006951-0.025896*T_TT-22.4072747*T_TT^2+...
        0.00190059*T_TT^3+0.001112526*T_TT^4+0.0000001358*T_TT^5);

    % 1st term
    s1 = 0;
    for i = 1:33
        h = 0; for j = 1:14, h = h+O(i,j)*F(j); end
        s1 = s1+as(i)*sin(h)+bs(i)*cos(h);
    end

    % 2nd term
    s2 = 0;
    for i = 34:36
        h = 0; for j = 1:14, h = h+O(i,j)*F(j); end
        s2 = s2+as(i)*sin(h)+bs(i)*cos(h);
    end
    s2 = s2*T_TT;

    % 3rd term
    s3 = 0;
    for i = 37:61
        h = 0; for j = 1:14, h = h+O(i,j)*F(j); end
        s3 = s3+as(i)*sin(h)+bs(i)*cos(h);
    end
    s3 = s3*T_TT^2;

    % 4th term
    s4 = 0;
    for i = 62:65
        h = 0; for j = 1:14, h = h+O(i,j)*F(j); end
        s4 = s4+as(i)*sin(h)+bs(i)*cos(h);
    end
    s4 = s4*T_TT^3;

    % 5th term
    h = 0; for j = 1:14, h = h+O(66,j)*F(j); end
    s5 = T_TT^4*(as(66)*cos(h)+bs(66)*sin(h));
    
    % s [rad]
    s = -((X*Y)/2)+s0+s1+s2+s3+s4+s5;

    % ---------------------------
    % Precession-nutation matrix.
    % ---------------------------
    
    % a [rad]
    a = 0.5+0.125*(X^2+Y^2);
    
    % precession-nutation matrix
    Q = [ 1-a*X^2  -a*X*Y     X;
         -a*X*Y     1-a*Y^2   Y;
         -X        -Y         1-a*(X^2+Y^2)]*rot3(s);
    
end