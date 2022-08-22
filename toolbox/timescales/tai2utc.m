%==========================================================================
%
% tai2utc  UTC from TAI.
%
%   MJD_UTC = tai2utc(MJD_TAI,DAT)
%
% See also gps2tai, tai2gps, tai2tt, tt2tai, ut12utc, utc2tai, utc2ut1.
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
%   MJD_TAI - (1×1 double) TAI (International Atomic Time) [MJD]
%   DAT     - (1×1 double) difference between TAI and UTC [s]
%               --> ΔAT = TAI - UTC
%
% -------
% OUTPUT:
% -------
%   MJD_UTC - (1×1 double) UTC (Universal Coordinate Time) [MJD]
%
%==========================================================================
function MJD_UTC = tai2utc(MJD_TAI,DAT)
    MJD_UTC = MJD_TAI-(DAT/86400);
end