%==========================================================================
%
% ut12utc  UTC from UT1.
%
%   MJD_UTC = ut12utc(MJD_UT1,DUT1)
%
% See also gps2tai, tai2gps, tai2tt, tai2utc, tt2tai, utc2tai, utc2ut1.
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