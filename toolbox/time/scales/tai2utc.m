%==========================================================================
%
% tai2utc  UTC from TAI.
%
%   MJD_UTC = tai2utc(MJD_TAI,DAT)
%
% See also gps2tai, tai2gps, tai2tt, tt2tai, ut12utc, utc2tai, utc2ut1.
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