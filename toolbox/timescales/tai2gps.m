%==========================================================================
%
% tai2gps  GPS time from TAI.
%
%   MJD_GPS = tai2gps(MJD_TAI)
%
% See also gps2tai, tai2tt, tai2utc, tt2tai, ut12utc, utc2tai, utc2ut1.
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
%
% -------
% OUTPUT:
% -------
%   MJD_GPS - (1×1 double) GPS time [MJD]
%
%==========================================================================
function MJD_GPS = tai2gps(MJD_TAI)
    MJD_GPS = MJD_TAI-(19/86400);
end