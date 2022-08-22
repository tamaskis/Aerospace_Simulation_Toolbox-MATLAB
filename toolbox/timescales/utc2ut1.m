%==========================================================================
%
% utc2ut1  UT1 from UTC.
%
%   MJD_UT1 = utc2ut1(MJD_UTC,DUT1)
%
% See also gps2tai, tai2gps, tai2tt, tai2utc, tt2tai, ut12utc, utc2tai.
%
% Author: Tamas Kis
% Last Update: 2022-01-22
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (3-49) (p. 190)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UTC - (1×1 double) UTC (Universal Coordinate Time) [MJD]
%   DUT1    - (1×1 double) difference between UT1 and UTC [s]
%               --> ΔUT1 = UT1 - UTC
%
% -------
% OUTPUT:
% -------
%   MJD_UT1 - (1×1 double) UT1 (Universal Time 1) [MJD]
%
%==========================================================================
function MJD_UT1 = utc2ut1(MJD_UTC,DUT1)
    MJD_UT1 = MJD_UTC+(DUT1/86400);
end