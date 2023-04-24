%==========================================================================
%
% wks2gps  GPS time from GPS week and seconds.
%
%   MJD_GPS = gps2wks(wk,s)
%
% See also wks2gps.
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
%   wk      - (1×1 double) GPS week [wk]
%   s       - (1×1 double) GPS seconds [s]
%
% -------
% OUTPUT:
% -------
%   MJD_GPS - (1×1 double) GPS time [MJD]
%
%==========================================================================
function MJD_GPS = wks2gps(wk,s)
    MJD_GPS = 7*wk+(s/86400)+44244;
end