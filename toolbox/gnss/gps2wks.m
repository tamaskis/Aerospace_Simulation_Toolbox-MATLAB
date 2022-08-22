%==========================================================================
%
% gps2wks  GPS week and seconds from GPS time.
%
%   [wk,s] = gps2wks(MJD_GPS)
%
% See also wks2gps.
%
% Author: Tamas Kis
% Last Update: 2022-02-01
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", 4th Ed., Appendix A.2 
%       (pp. 324-325)
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