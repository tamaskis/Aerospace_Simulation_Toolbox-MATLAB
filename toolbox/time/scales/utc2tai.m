%==========================================================================
%
% utc2tai  TAI from UTC.
%
%   MJD_TAI = utc2tai(MJD_UTC,DAT)
%
% See also gps2tai, tai2gps, tai2tt, tai2utc, tt2tai, ut12utc, utc2ut1.
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