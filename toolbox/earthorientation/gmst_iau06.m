%==========================================================================
%
% gmst_iau06  Greenwich mean sidereal time (GMST) (IAU2006/2000).
%
%   GMST = gmst_iau06(MJD_UT1)
%
% See also gmst_linear, gmst_vallado.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] IERS Technical Note No. 36 (p. 61)
%       https://www.iers.org/SharedDocs/Publikationen/EN/IERS/Publications/tn/TechnNote36/tn36.pdf?__blob=publicationFile&v=1
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (p. 216)
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
%   GMST    - (1×1 double) Greenwich mean sidereal time [rad]
%
%==========================================================================
function GMST = gmst_iau06(MJD_UT1)
    
    % difference between UT1 and UTC [s]
    DUT1 = get_DUT1(MJD_UT1);

    % difference between TAI and UTC [s]
    DAT = get_DAT(MJD_UT1);

    % modified Julian date of UTC [MJD]
    MJD_UTC = ut12utc(MJD_UT1,DUT1);

    % modified Julian date of TAI [MJD]
    MJD_TAI = utc2tai(MJD_UTC,DAT);

    % modified Julian date of TT [MJD]
    MJD_TT = tai2tt(MJD_TAI);

    % Julian centuries since J2000.0 of TT [c]
    T_TT = mjd2t(MJD_TT);

    % Earth rotation angle [rad]
    ERA = era_iau06(MJD_UT1);
    
    % convert ERA to arcseconds
    ERA = rad2arcsec(ERA);

    % GMST in arcseconds
    GMST = ERA+0.014506+(4612.156534*T_TT)+(1.3915817*T_TT^2)-...
        (0.00000044*T_TT^3)-(0.000029956*T_TT^4)-(0.0000000368*T_TT^5);
    
    % convert GMST to radians
    GMST = arcsec2rad(GMST);

    % wrap GMST to the interval [0,2π)
    GMST = mod(GMST,2*pi);
    
end