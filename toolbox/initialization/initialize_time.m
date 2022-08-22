%==========================================================================
%
% initialize_time  Time initialization.
%
%   t0 = initialize_time(UTC_start)
%   t0 = initialize_time(UTC_start,sim_start)
%
% Author: Tamas Kis
% Last Update: 2022-02-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   UTC_start   - (1×6 double) initial UTC [y,mo,d,h,m,s]
%   sim_start   - (1×1 double) (OPTIONAL) initial simulation time [s]
%
% -------
% OUTPUT:
% -------
%   t0      - (1×1 struct) initial times
%       • t0       - (1×1 double) simulation time [s]
%       • MJD_GPS0 - (1×1 double) GPS time [MJD]
%       • MJD_TAI0 - (1×1 double) TAI (International Atomic Time) [MJD]
%       • MJD_TT0  - (1×1 double) TT (Terrestrial Time) [MJD]
%       • MJD_UT10 - (1×1 double) UT1 (Universal Time 1) [MJD]
%       • MJD_UTC0 - (1×1 double) UTC (Universal Coordinated Time) [MJD]
%
%==========================================================================
function t0 = initialize_time(UTC_start,sim_start)

    % defaults initial simulation time to 0 if not input
    if (nargin < 6) || isempty(sim_start)
        sim_start = 0;
    end

    % modified Julian date of initial UTC [MJD]
    MJD_UTC0 = cal2mjd(UTC_start);

    % difference between UT1 and UTC (ΔUT1 = UT1 - UTC) [s]
    DUT1 = get_DUT1(MJD_UTC0);

    % difference between TAI and UTC (ΔAT = TAI - UTC) [s]
    DAT = get_DAT(MJD_UTC0);

    % modified Julian dates of initial times in remaining time scales [MJD]
    MJD_UT10 = utc2ut1(MJD_UTC0,DUT1);
    MJD_TAI0 = utc2tai(MJD_UTC0,DAT);
    MJD_GPS0 = tai2gps(MJD_TAI0);
    MJD_TT0 = tai2tt(MJD_TAI0);

    % packages initial times into structure
    t0.t0 = sim_start;
    t0.MJD_GPS0 = MJD_GPS0;
    t0.MJD_TAI0 = MJD_TAI0;
    t0.MJD_TT0 = MJD_TT0;
    t0.MJD_UT10 = MJD_UT10;
    t0.MJD_UTC0 = MJD_UTC0;

end