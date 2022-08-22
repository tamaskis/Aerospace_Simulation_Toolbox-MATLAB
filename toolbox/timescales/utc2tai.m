%==========================================================================
%
% utc2tai  TAI from UTC.
%
%   MJD_TAI = utc2tai(MJD_UTC,DAT)
%
% See also gps2tai, tai2gps, tai2tt, tai2utc, tt2tai, ut12utc, utc2ut1.
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
%   MJD_UTC - (1×1 double) UTC (Universal Coordinated Time) [MJD]
%   DAT     - (1×1 double) difference between TAI and UTC [s]
%               --> ΔAT = TAI - UTC
%
% -------
% OUTPUT:
% -------
%   MJD_TAI - (1×1 double) TAI (International Atomic Time) [MJD]
%
%==========================================================================
function MJD_TAI = utc2tai(MJD_UTC,DAT)
    MJD_TAI = MJD_UTC+(DAT/86400);
end