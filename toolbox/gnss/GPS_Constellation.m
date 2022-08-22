%--------------------------------------------------------------------------
%
% GPS_Constellation  MATLAB class defining a GPS constellation.
%
% Author: Tamas Kis
% Last Update: 2022-03-19
%
%--------------------------------------------------------------------------

classdef GPS_Constellation < handle
    
    properties
        subframe1       % (1×1 struct) subframe 1 of GPS navigation message
        subframe23      % (1×1 struct) subframes 2 and 3 of GPS navigation message
        int_ambiguity   % (M×n double) integer ambiguities between M GPS satellites and n receivers
        MJD_GPS         % (K×1 double) vector of GPS times [MJD]
        ECEF_position   % (M×K double) position resolved in ECEF frame of M GPS satellites at K sample times
    end
    


    methods
        
        
        
        function obj = GPS_Constellation(sim_file_name,gps_file_name,n)
            %==============================================================
            % obj = GPS_Constellation(sim_file_name,gps_file_name,n)
            %
            % Constructor.
            %--------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   sim_file_name   - (char) file name for simulation data
            %   gps_file_name   - (1×1 struct) file name for GPS data
            %   n               - (1×1 double) (OPTIONAL) number of 
            %                      receivers
            %
            % -------
            % OUTPUT:
            % -------
            %   obj         - (1×1 GPS_Constellation) GPS constellation 
            %                 object
            %
            %==============================================================
            
            % defaults "n" to 1 if not input
            if (nargin < 3) || isempty(n)
                n = 1;
            end
            
            % subframe 1 of GPS navigation message
            obj.subframe1 = generate_subframe_1(gps_file_name);
            
            % subframes 2 and 3 of GPS navigation message
            obj.subframe23 = generate_subframe_23(gps_file_name);
            
            % number of GPS satellites
            M = length(obj.subframe1);
            
            % randomly picks integer ambiguities between 50 and 200 for 
            % each spacecraft in a swarm with each GPS satellite
            obj.int_ambiguity = rand2(50,200,[M,n],'int');
            
            % loads simulation data
            simdata = load_simdata(sim_file_name);
            
            % vector of GPS times [MJD]
            obj.MJD_GPS = simdata.MJD_GPS;
            
            % number of sample times
            K = length(obj.MJD_GPS);
            
            % initializes array to store ECEF positions of M satellites at
            % K sample times
            obj.ECEF_position = zeros(M,K,3);
            
            % loop over all GPS satellites and all sample times
            for k = 1:M
                for i = 1:K

                    % GPS seconds of week [s]
                    [~,t] = gps2wks(obj.MJD_GPS(i));
    
                    % GPS satellite k ECEF position [m]
                    obj.ECEF_position(k,i,:) = ephem2state(t,...
                        obj.subframe1(k),obj.subframe23(k));

                end
            end

        end
        
        
        
        function [rho,Phi,rho_gr,rho_dot] = get_measurements(obj,...
                r_rcv_ecef,v_rcv_ecef,b_rcv,b_dot_rcv,SVID,MJD_GPS,...
                RCVID,N,iono_delay,noise)
            %==============================================================
            % [rho,Phi,rho_gr,rho_dot] = get_measurements(obj,...
            %   r_rcv_ecef,v_rcv_ecef,b_rcv,b_dot_rcv,SVID,MJD_GPS)
            % [rho,Phi,rho_gr,rho_dot] = get_measurements(obj,...
            %   r_rcv_ecef,v_rcv_ecef,b_rcv,b_dot_rcv,SVID,MJD_GPS,...
            %   RCVID,N,iono_delay,noise)
            %
            % Pseudorange, carrier phase, GRAPHIC, and pseudorange rate
            % measurement(s) from specified GPS satellite(s).
            %--------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   obj         - (1×1 GPS_Constellation) object of this class
            %   r_rcv_ecef  - (3×1 double) receiver position resolved in
            %                 ECEF frame [m]
            %   v_rcv_ecef  - (3×1 double) receiver Earth-fixed velocity
            %                 resolved in ECEF frame [m/s]
            %   b_rcv       - (1×1 double) receiver clock bias [m]
            %   b_dot_rcv   - (1×1 double) receiver clock drift [m/s]
            %   SVID        - (l×1 double) SVIDs of "l" GPS satellites [-]
            %   MJD_GPS     - (1×1 double) current GPS time [MJD]
            %   RCVID       - (1×1 double) (OPTIONAL) receiver ID [-]
            %   N           - (l×1 double) (OPTIONAL) integer ambiguities
            %                 [-]
            %   iono_delay  - (1×1 logical) (OPTIONAL) "true" if 
            %                 ionospheric path delay should be included, 
            %                 "false" otherwise (defaults to "false")
            %   noise       - (1×1 logical) (OPTIONAL) "true" if random 
            %                 noise should be included, "false" otherwise 
            %                 (defaults to false)
            %
            % -------
            % OUTPUT:
            % -------
            %   rho         - (l×1 double) pseudorange measurement(s) from
            %                 specified GPS satellite(s) [m]
            %   Phi         - (l×1 double) carrier phase measurement(s)
            %                 from specified GPS satellite(s) [m]
            %   rho_gr      - (l×1 double) GRAPHIC measurement(s) from
            %                 specified GPS satellite(s) [m]
            %   rho_dot     - (l×1 double) pseudorange rate measurement(s) 
            %                 from specified GPS satellite(s) [m]
            %
            %==============================================================

            % defaults "iono_delay" to "false" if not input
            if (nargin < 5) || isempty(iono_delay)
                iono_delay = false;
            end
        
            % defaults "noise" to "false" if not input
            if (nargin < 6) || isempty(noise)
                noise = false;
            end

            % defaults "RCVID" to 1 if not input
            if (nargin < 7) || isempty(RCVID)
                RCVID = 1;
            end

            % defaults "N" to true integer ambiguities if not input
            if (nargin < 8) || isempty(N)
                N = obj.int_ambiguity(SVID,RCVID);
            end

            % number of GPS satellites to get pseudoranges from
            l = length(SVID);

            % preallocates vectors to store measurements
            rho = zeros(l,1);
            Phi = zeros(l,1);
            rho_gr = zeros(l,1);
            rho_dot = zeros(l,1);
            
            % GPS time (seconds of week) [s]
            [~,t] = gps2wks(MJD_GPS);

            % loop through specified satellites
            for k = 1:l

                % transit time [s]
                tau = transit_time(r_rcv_ecef,t,obj.subframe1(SVID(k)),...
                    obj.subframe23(SVID(k)));
                
                % GPS satellite position [m] and Earth-fixed velocity [m/s]
                % at time t-τ resolved in ECEF frame at time t, and clock
                % bias [m] and clock drift [m/s] at time t-τ
                [r_sat_ecef,v_sat_ecef,b_sat,b_dot_sat] = ephem2state(...
                    t-tau,obj.subframe1(SVID(k)),obj.subframe23(SVID(k)));
                
                % pseudorange measurement [m]
                rho(k) = pseudorange(r_rcv_ecef,r_sat_ecef,b_rcv,...
                    b_sat,t,iono_delay,noise);
                
                % carrier phase measurement [m]
                Phi(k) = carrier_phase(r_rcv_ecef,r_sat_ecef,b_rcv,...
                    b_sat,t,N(k),iono_delay,noise);

                % GRAPHIC measurement [m]
                rho_gr(k) = graphic(rho(k),Phi(k));
                
                % pseudorange rate measurement [m/s]
                rho_dot(k) = pseudorange_rate(r_rcv_ecef,r_sat_ecef,...
                    v_rcv_ecef,v_sat_ecef,b_dot_rcv,b_dot_sat,noise);
                
            end

        end



        function [drhodr,drhodv,drhodotdr,drhodotdv] =...
                get_linearizations(obj,r_rcv_eci,v_rcv_eci,SVID,MJD_GPS,...
                w_eci,R_ecef2eci)
            %==============================================================
            % [drhodr,drhodv,drhodotdr,drhodotdv] = get_linearizations(...
            %   obj,r_rcv_eci,v_rcv_eci,SVID,MJD_GPS)
            %
            % Linearizations of GPS measurements from specified GPS 
            % satellite(s).
            %--------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   obj         - (1×1 GPS_Constellation) object of this class
            %   r_rcv_eci   - (3×1 double) receiver position resolved in
            %                 ECI frame [m]
            %   v_rcv_eci   - (3×1 double) receiver inertial velocity
            %                 resolved in ECI frame [m/s]
            %   b_rcv       - (1×1 double) receiver clock bias [m]
            %   b_dot_rcv   - (1×1 double) receiver clock drift [m/s]
            %   SVID        - (l×1 double) SVIDs of "l" GPS satellites
            %   MJD_GPS     - (1×1 double) current GPS time [MJD]
            %   w_eci       - (3×1 double) Earth angular velocity resolved
            %                 in ECI frame [rad/s]
            %   R_ecef2eci  - (3×3 double) rotation matrix (ECEF --> ECI)
            %
            % -------
            % OUTPUT:
            % -------
            %   drhodr      - (l×3 double) partial derivative of 
            %                 pseudoranges w.r.t. position resolved in ECI 
            %                 frame [s/s]
            %   drhodv      - (l×3 double) partial derivative of 
            %                 pseudoranges w.r.t. inertial velocity 
            %                 resolved in ECI frame [s]
            %   drhodotdr   - (l×3 double) partial derivative of 
            %                 pseudorange rates w.r.t. position resolved in
            %                 ECI frame [1/s]
            %   drhodotdv   - (l×3 double) partial derivative of 
            %                 pseudorange rates w.r.t. inertial velocity 
            %                 resolved in ECI frame [s/s]
            %
            %==============================================================
            
            % number of GPS satellites to get pseudoranges from
            l = length(SVID);
            
            % preallocates vectors to store measurements
            drhodr = zeros(l,3);
            drhodv = zeros(l,3);
            drhodotdr = zeros(l,3);
            drhodotdv = zeros(l,3);
            
            % GPS time (seconds of week) [s]
            [~,t] = gps2wks(MJD_GPS);
            
            % loop through specified satellites
            for k = 1:l
            
                % transit time [s]
                tau = transit_time(r_rcv_eci,t,obj.subframe1(SVID(k)),...
                    obj.subframe23(SVID(k)));
                
                % GPS satellite position [m] and Earth-fixed velocity [m/s]
                % at time t-τ resolved in ECEF frame at time t
                [r_sat_ecef,v_sat_ecef] = ephem2state(t-tau,...
                    obj.subframe1(SVID(k)),obj.subframe23(SVID(k)));
                
                % GPS satellite position [m] and inertial velocity [m/s]
                % resolved in ECI frame
                [r_sat_eci,v_sat_eci] = ecef2eci(r_sat_ecef,v_sat_ecef,...
                    w_eci,R_ecef2eci);
                
                % partial derivatives of pseudorange
                [drhodr(k,:),drhodv(k,:)] = dydX_pseudorange(r_rcv_eci,...
                    r_sat_eci);
                
                % partial derivatives of pseudorange rate
                [drhodotdr(k,:),drhodotdv(k,:)] = dydX_pseudorange_rate(...
                    r_rcv_eci,r_sat_eci,v_rcv_eci,v_sat_eci);
                
            end

        end
        
        
        
        function SVID = get_closest_SVIDs(obj,r_rcv_ecef,MJD_GPS,l)
            %==============================================================
            % SVID = get_closest_SVIDs(obj,r_rcv_ecef,MJD_GPS,l)
            %
            % SVIDs of the "l" closest GPS satellites to a receiver.
            %--------------------------------------------------------------
            %
            % ------
            % INPUT:
            % ------
            %   obj         - (1×1 GPS_Constellation) object of this class
            %   r_rcv_ecef  - (3×1 double) receiver position resolved in
            %                 ECEF frame [m]
            %   MJD_GPS     - (1×1 double) current GPS time [MJD]
            %   l           - (1×1 double) (OPTIONAL) number of SVIDs to
            %                 return (defaults to 4)
            %
            % -------
            % OUTPUT:
            % -------
            %   SVID        - (l×1 double) SVIDs of the "l" closest GPS
            %                 satellites
            %
            % -----
            % NOTE:
            % -----
            %   --> This function ignores the transit time (i.e. it uses
            %       receiver and GPS satellite positions at the same time
            %       instant).
            %
            %==============================================================
            
            % total number of GPS satellites
            M = size(obj.subframe23,1);
            
            % preallocates vector to true store ranges
            ranges = zeros(M,1);
            
            % index corresponding to current sample time
            i = find(MJD_GPS == obj.MJD_GPS);
            
            % calculates ranges to all GPS satellites
            for k = 1:M
                r_sat_ecef = squeeze(obj.ECEF_position(k,i,1:3));
                ranges(k) = inorm(r_sat_ecef-r_rcv_ecef);
            end
            
            % SVIDs of closest "n" GPS satellites
            [~,SVID] = mink(ranges,l);

            % reshapes vector storing SVIDs
            SVID = SVID.';

        end
        
    end 
end