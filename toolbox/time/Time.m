%==========================================================================
%
% Time  Time object.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-03-31
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
%==========================================================================

classdef Time < handle
    
    % -----------
    % Properties.
    % -----------
    
    properties
        t_initial       % (1×1 double) initial simulation time [s]
        MJD_GPS_initial % (1×1 double) initial GPS time [MJD]
        MJD_TAI_initial % (1×1 double) initial TAI (International Atomic Time) [MJD]
        MJD_TT_initial  % (1×1 double) initial TT (Terrestrial Time) [MJD]
        MJD_UT1_initial % (1×1 double) initial UT1 (Universal Time 1) [MJD]
        MJD_UTC_initial % (1×1 double) initial UTC (Universal Coordinated Time) [MJD]
    end
    
    % ---------------
    % Public methods.
    % ---------------
    
    methods (Access = public)
        
        function obj = Time(UTC_initial,t_initial)
            % time = Time(UTC_initial,t_initial)
            %
            % Constructor.
            %--------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   UTC_initial - (1×6 double) initial UTC time [y,mo,d,h,m,s]
            %   t_initial   - (OPTIONAL) (1×1 double) initial simulation
            %                 time (defaults to 0) [s]
            %
            % -------
            % OUTPUT:
            % -------
            %   obj         - (1×1 Time) Time object
            %
            %--------------------------------------------------------------
            
            % sets initial simulation time (defaults to 0)
            if (nargin < 2) || isempty(t_initial)
                t_initial = 0;
            end
            
            % modified Julian date of initial UTC [MJD]
            MJD_UTC0 = cal2mjd(UTC_initial);
            
            % difference between UT1 and UTC (ΔUT1 = UT1 - UTC) [s]
            DUT1 = get_DUT1(MJD_UTC0);
            
            % difference between TAI and UTC (ΔAT = TAI - UTC) [s]
            DAT = get_DAT(MJD_UTC0);
            
            % modified Julian dates of initial times in remaining time
            % scales [MJD]
            MJD_UT10 = utc2ut1(MJD_UTC0,DUT1);
            MJD_TAI0 = utc2tai(MJD_UTC0,DAT);
            MJD_GPS0 = tai2gps(MJD_TAI0);
            MJD_TT0 = tai2tt(MJD_TAI0);
            
            % stores initial times
            obj.t_initial = t_initial;
            obj.MJD_GPS_initial = MJD_GPS0;
            obj.MJD_TAI_initial = MJD_TAI0;
            obj.MJD_TT_initial = MJD_TT0;
            obj.MJD_UT1_initial = MJD_UT10;
            obj.MJD_UTC_initial = MJD_UTC0;
            
        end
        
        function times = get_times(obj,t)
            % times = time.get_times(test)
            %
            % TODO
            %--------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   t       - (1×1 double) current simulation time [s]
            %
            % -------
            % OUTPUT:
            % -------
            %   times   - (1×1 struct) times in different time scales:
            %       • MJD_GPS - (1×1 double) GPS time [MJD]
            %       • MJD_TAI - (1×1 double) TAI (International Atomic
            %                   Time) [MJD]
            %       • MJD_TT  - (1×1 double) TT (Terrestrial Time) [MJD]
            %       • MJD_UT1 - (1×1 double) UT1 (Universal Time 1) [MJD]
            %       • MJD_UTC - (1×1 double) UTC (Universal Coordinated
            %                   Time) [MJD]
            %
            %--------------------------------------------------------------
            
            % elapsed time since epoch [s]
            t_elapsed = t-obj.t0;
            
            % unit conversion: seconds → days
            t_elapsed = t_elapsed/86400;
            
            % time in different time scales [MJD]
            times.MJD_GPS = obj.MJD_GPS0+t_elapsed;
            times.MJD_TAI = obj.MJD_TAI0+t_elapsed;
            times.MJD_TT = obj.MJD_TT0+t_elapsed;
            times.MJD_UT1 = obj.MJD_UT1+t_elapsed;
            times.MJD_UTC = obj.MJD_UTC+t_elapsed;
            
        end
        
    end
    
end