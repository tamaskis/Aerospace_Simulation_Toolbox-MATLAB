%==========================================================================
%
% era_iau06  Earth rotation angle (ERA) (IAU2006/2000, CIO based).
%
%   ERA = era_iau06(MJD_UT1)
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] IERS Technical Note No. 36 (p. 52)
%       https://www.iers.org/SharedDocs/Publikationen/EN/IERS/Publications/tn/TechnNote36/tn36.pdf?__blob=publicationFile&v=1
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 212-213)
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
%   ERA     - (1×1 double) Earth rotation angle [rad] 
%
%==========================================================================
function ERA = era_iau06(MJD_UT1)
    
    % Julian date of UT1 [JD]
    JD_UT1 = mjd2jd(MJD_UT1);
    
    % Earth rotation angle [rad]
    ERA = 2*pi*(0.7790572732640+1.00273781191135448*(JD_UT1-2451545));
    
    % wrap ERA to the interval [0,2π)
    ERA = mod(ERA,2*pi);
    
end