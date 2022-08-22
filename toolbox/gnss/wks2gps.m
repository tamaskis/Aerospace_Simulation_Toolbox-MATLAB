%==========================================================================
%
% wks2gps  GPS time from GPS week and seconds.
%
%   MJD_GPS = gps2wks(wk,s)
%
% See also gps2wks.
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