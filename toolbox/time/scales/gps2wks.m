%==========================================================================
%
% gps2wks  GPS week and seconds from GPS time.
%
%   [wk,s] = gps2wks(MJD_GPS)
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
%   MJD_GPS - (1×1 double) GPS time [MJD]
%
% -------
% OUTPUT:
% -------
%   wk      - (1×1 double) GPS week [wk]
%   s       - (1×1 double) GPS seconds [s]
%
%==========================================================================
function [wk,s] = gps2wks(MJD_GPS)
    
    % GPS week [wk]
    wk = floor((MJD_GPS-44244)/7);
    
    % GPS seconds [s]
    s = 86400*(MJD_GPS-44244)-604800*wk;
    
end