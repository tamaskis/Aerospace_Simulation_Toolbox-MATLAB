%==========================================================================
%
% generate_subrame_23  Subframes 2 and 3 of GPS navigation message from 
% GPS data.
%
%   subframe23 = generate_subframe_23(file_name)
%
% Author: Tamas Kis
% Last Update: 2022-03-17
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   file_name   - (char) file name for GPS data
%
% -------
% OUTPUT:
% -------
%   subframe23  - (1×1 struct) GPS satellite subframe 2 and 3 (ephemeris) 
%                 parameters
%       • Crs       - (1×1 double) amplitude of the sine harmonic
%                     correction term to the orbit radius [m]
%       • dn        - (1×1 double) mean motion difference from computed
%                     value [rad/s]
%       • M0        - (1×1 double) mean anomaly at reference time [rad]
%       • Cuc       - (1×1 double) amplitude of the cosine harmonic 
%                     correction term to the argument of latitude [rad]
%       • e         - (1×1 double) eccentricity [-]
%       • Cus       - (1×1 double) amplitude of the sine harmonic
%                     correction term to the argument of latitude [rad]
%       • sqrt_a    - (1×1 double) square root of the semi-major axis [√m]
%       • toe       - (1×1 double) reference time ephemeris [s]
%       • Cic       - (1×1 double) amplitude of the cosine harmonic
%                     correction term to the angle of inclination [rad]
%       • Om0       - (1×1 double) longitude of ascending node of orbit 
%                     plane at weekly epoch [rad]
%       • Cis       - (1×1 double) amplitude of the sine harmonic
%                     correction term to the angle of inclination [rad]
%       • i0        - (1×1 double) inclination angle at reference time 
%                     [rad]
%       • Crc       - (1×1 double) amplitude of the cosine harmonic
%                     correction term to the orbit radius [m]
%       • w         - (1×1 double) argument of perigee [rad]
%       • Om_dot    - (1×1 double) rate of right ascension [rad/s]
%       • IDOT      - (1×1 double) rate of inclination angle [rad/s]
%
%==========================================================================
function subframe23 = generate_subframe_23(file_name)
    
    % read in GPS data
    gps_data = readtable(file_name);

    % number of satellites in data set
    M = size(gps_data,1);

    % preallocates structure
    subframe23(M,1) = struct();
    
    % generates subframes 2 and 3 sub-structure for each satellite
    for k = 1:M
        subframe23(k).Crs = gps_data.Crs(k);
        subframe23(k).dn = gps_data.DeltaN(k);
        subframe23(k).M0 = gps_data.M0(k);
        subframe23(k).Cuc = gps_data.Cuc(k);
        subframe23(k).e = gps_data.Eccentricity(k);
        subframe23(k).Cus = gps_data.Cus(k);
        subframe23(k).sqrt_a = gps_data.sqrtA(k);
        subframe23(k).toe = gps_data.Toe(k);
        subframe23(k).Cic = gps_data.Cic(k);
        subframe23(k).Om0 = gps_data.Omega0(k);
        subframe23(k).Cis = gps_data.Cis(k);
        subframe23(k).i0 = gps_data.Io(k);
        subframe23(k).Crc = gps_data.Crc(k);
        subframe23(k).w = gps_data.omega(k);
        subframe23(k).Om_dot = gps_data.OmegaDot(k);
        subframe23(k).IDOT = gps_data.IDOT(k);
    end
    
end