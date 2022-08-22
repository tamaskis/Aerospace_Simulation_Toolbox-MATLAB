%==========================================================================
%
% tai2tt  TT from TAI.
%
%   MJD_TT = tai2tt(MJD_TAI)
%
% See also gps2tai, tai2gps, tai2utc, tt2tai, ut12utc, utc2tai, utc2ut1.
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
%   MJD_TT  - (1×1 double) TT (Terrestrial Time) [MJD]
%
%==========================================================================
function MJD_TT = tai2tt(MJD_TAI)
    MJD_TT = MJD_TAI+(32.184/86400);
end