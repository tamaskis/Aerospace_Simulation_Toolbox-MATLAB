%==========================================================================
%
% tai2tt  TT from TAI.
%
%   MJD_TT = tai2tt(MJD_TAI)
%
% See also gps2tai, tai2gps, tai2utc, tt2tai, ut12utc, utc2tai, utc2ut1.
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