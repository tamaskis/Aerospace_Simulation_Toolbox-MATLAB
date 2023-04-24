%==========================================================================
%
% Time  Time object.
%
%   [MJD_GPS,MJD_TAI,MJD_TT,MJD_UT1,MJD_UTC] = time_scales(t,t0)
%
% Author: Tamas Kis
% Last Update: 2022-03-05
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   t	    - (1×1 double) current simulation time [s]
%   t0      - (1×1 struct) reference times
%       • t0        - (1×1 double) simulation time [s]
%       • MJD_GPS0  - (1×1 double) GPS time [MJD]
%       • MJD_TAI0  - (1×1 double) TAI (International Atomic Time) [MJD]
%       • MJD_TT0   - (1×1 double) TT (Terrestrial Time) [MJD]
%       • MJD_UT10  - (1×1 double) UT1 (Universal Time 1) [MJD]
%       • MJD_UTC0  - (1×1 double) UTC (Universal Coordinated Time) [MJD]
%
% -------
% OUTPUT:
% -------
%   MJD_GPS - (1×1 double) GPS time [MJD]
%   MJD_TAI - (1×1 double) TAI (International Atomic Time) [MJD]
%   MJD_TT  - (1×1 double) TT (Terrestrial Time) [MJD]
%   MJD_UT1 - (1×1 double) UT1 (Universal Time 1) [MJD]
%   MJD_UTC - (1×1 double) UTC (Universal Coordinated Time) [MJD]
%
%==========================================================================
function [MJD_GPS,MJD_TAI,MJD_TT,MJD_UT1,MJD_UTC] = time_scales(t,t0)
    
    % elapsed time since epoch [s]
    t_elapsed = t-t0.t0;
    
    % converts elapsed time to days
    t_elapsed = t_elapsed/86400;
    
    % time scales [MJD]
    MJD_GPS = t0.MJD_GPS0+t_elapsed;
    MJD_TAI = t0.MJD_TAI0+t_elapsed;
    MJD_TT = t0.MJD_TT0+t_elapsed;
    MJD_UT1 = t0.MJD_UT10+t_elapsed;
    MJD_UTC = t0.MJD_UTC0+t_elapsed;
    
end