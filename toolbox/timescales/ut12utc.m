%==========================================================================
%
% ut12utc  UTC from UT1.
%
%   MJD_UTC = ut12utc(MJD_UT1,DUT1)
%
% See also gps2tai, tai2gps, tai2tt, tai2utc, tt2tai, utc2tai, utc2ut1.
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
%   MJD_UT1 - (1×1 double) UT1 (Universal Time 1) [MJD]
%   DUT1    - (1×1 double) difference between UT1 and UTC [s]
%               --> ΔUT1 = UT1 - UTC
%
% -------
% OUTPUT:
% -------
%   MJD_UTC - (1×1 double) UTC (Universal Coordinated Time) [MJD]
%
%==========================================================================
function MJD_UTC = ut12utc(MJD_UT1,DUT1)
    MJD_UTC = MJD_UT1-(DUT1/86400);
end