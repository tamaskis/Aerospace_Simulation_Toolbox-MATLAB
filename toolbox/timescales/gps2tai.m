%==========================================================================
%
% gps2tai  TAI from GPS time.
%
%   MJD_TAI = gps2tai(MJD_GPS)
%
% See also tai2gps, tai2tt, tai2utc, tt2tai, ut12utc, utc2tai, utc2ut1.
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
%   MJD_GPS - (1×1 double) GPS time [MJD]
%
% -------
% OUTPUT:
% -------
%   MJD_TAI - (1×1 double) TAI (International Atomic Time) [MJD]
%
%==========================================================================
function MJD_TAI = gps2tai(MJD_GPS)
    MJD_TAI = MJD_GPS+(19/86400);
end