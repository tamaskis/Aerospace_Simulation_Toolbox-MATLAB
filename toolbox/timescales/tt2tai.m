%==========================================================================
%
% tt2tai  TAI from TT.
%
%   MJD_TAI = tt2tai(MJD_TT)
%
% See also gps2tai, tai2gps, tai2tt, tai2utc, ut12utc, utc2tai, utc2ut1.
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
%   MJD_TT  - (1×1 double) TT (Terrestrial Time) [MJD]
%
% -------
% OUTPUT:
% -------
%   MJD_TAI - (1×1 double) TAI (International Atomic Time) [MJD]
%
%==========================================================================
function MJD_TAI = tt2tai(MJD_TT)
    MJD_TAI = MJD_TT-(32.184/86400);
end