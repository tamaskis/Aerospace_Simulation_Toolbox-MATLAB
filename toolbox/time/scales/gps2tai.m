%==========================================================================
%
% gps2tai  TAI from GPS time.
%
%   MJD_TAI = gps2tai(MJD_GPS)
%
% See also tai2gps, tai2tt, tai2utc, tt2tai, ut12utc, utc2tai, utc2ut1.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-01
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Aerospace_Simulation.pdf
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