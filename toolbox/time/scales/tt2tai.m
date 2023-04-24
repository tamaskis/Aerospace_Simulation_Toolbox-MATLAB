%==========================================================================
%
% tt2tai  TAI from TT.
%
%   MJD_TAI = tt2tai(MJD_TT)
%
% See also gps2tai, tai2gps, tai2tt, tai2utc, ut12utc, utc2tai, utc2ut1.
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