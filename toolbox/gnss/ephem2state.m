%==========================================================================
%
% ephem2state  GPS satellite state from ephemeris parameters.
%
%   [r_sat_ecef,v_sat_ecef,b_sat,b_dot_sat] = ephem2state(t,subframe1,...
%       subframe23)
%
% Author: Tamas Kis
% Last Update: 2022-03-17
%
% REFERENCES:
%   [1] IS-GPS-200M, https://www.gps.gov/technical/icwg/IS-GPS-200M.pdf 
%       (pp. 46, 95-99, 103, 106-108)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   t           - (1×1 double) time of transmission (GPS seconds of week) 
%                 [s]
%   subframe1   - (1×1 struct) subframe 1 parameters for GPS satellite k
%       • TGD       - (1×1 double) group differential delay [s]
%       • toc       - (1×1 double) clock data reference time [s]
%       • af2       - (1×1 double) drift rate correction coefficient 
%                     [s/s^2]
%       • af1       - (1×1 double) SV clock drift correction coefficient 
%                     [s/s]
%       • af0       - (1×1 double) SV clock bias correction coefficient [s]
%   subframe23  - (1×1 struct) subframe 2 and 3 parameters for GPS 
%                 satellite k
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
% -------
% OUTPUT:
% -------
%   r_sat_ecef  - (3×1 double) GPS satellite position resolved in ECEF 
%                 frame [m]
%   r_sat_ecef  - (3×1 double) GPS satellite Earth-fixed velocity resolved 
%                 in ECEF frame [m/s]
%   b_sat       - (1×1 double) GPS satellite clock bias [m]
%   b_dot_sat   - (1×1 double) GPS satellite clock drift [m/s]
%
%==========================================================================
function [r_sat_ecef,v_sat_ecef,b_sat,b_dot_sat] = ephem2state(t,...
    subframe1,subframe23)
    
    % ----------
    % Constants.
    % ----------
    
    % Earth's gravitational constant (WGS84) [m^3/s^2]
    mu = 3.986005e14;

    % Earth's rotation rate (WGS84) [rad/s]
    w_earth = 7.2921151467e-5;

    % speed of light [m/s]
    c = 299792458;

    % -------------------
    % Extract parameters.
    % -------------------
    
    % subframe 1 parameters
    TGD = subframe1.TGD;
    toc = subframe1.toc;
    af2 = subframe1.af2;
    af1 = subframe1.af1;
    af0 = subframe1.af0;

    % subframe 2 and 3 (ephemeris) parameters
    Crs = subframe23.Crs;
    dn = subframe23.dn;
    M0 = subframe23.M0;
    Cuc = subframe23.Cuc;
    e = subframe23.e;
    Cus = subframe23.Cus;
    sqrt_a = subframe23.sqrt_a;
    toe = subframe23.toe;
    Cic = subframe23.Cic;
    Om0 = subframe23.Om0;
    Cis = subframe23.Cis;
    i0 = subframe23.i0;
    Crc = subframe23.Crc;
    w = subframe23.w;
    Om_dot = subframe23.Om_dot;
    IDOT = subframe23.IDOT;
    
    % --------------------------------
    % Position resolved in ECEF frame.
    % --------------------------------
    
    % semi-major axis [m]
    a = sqrt_a^2;
    
    % computed mean motion [rad/s]
    n0 = sqrt(mu/a^3);
    
    % time from ephemeris reference epoch [s]
    tk = t-toe;
    
    % corrected mean motion [rad/s]
    n = n0+dn;
    
    % mean anomaly [rad]
    Mk = M0+n*tk;
    
    % eccentric anomaly [rad]
    Ek = M2E(Mk,e);
    
    % true anomaly [rad]
    nuk = E2nu(Ek,e);
    
    % argument of latitude [rad]
    phik = nuk+w;
    
    % argument of latitude correction (second harmonic perturbation) [rad]
    duk = Cus*sin(2*phik)+Cuc*cos(2*phik);
    
    % radius correction (second harmonic perturbation) [m]
    drk = Crs*sin(2*phik)+Crc*cos(2*phik);
    
    % inclination correction (second harmonic perturbation) [m]
    dik = Cis*sin(2*phik)+Cic*cos(2*phik);
    
    % corrected argument of latitude [rad]
    uk = phik+duk;
    
    % corrected radius [m]
    rk = a*(1-e*cos(Ek))+drk;
    
    % corrected inclination [rad]
    ik = i0+dik+IDOT*tk;
    
    % positions in orbital plane [m]
    xp = rk*cos(uk);
    yp = rk*sin(uk);
    
    % corrected longitude of ascending node
    Omegak = Om0+(Om_dot-w_earth)*tk-w_earth*toe;
    
    % Earth-fixed coordinates
    xk = xp*cos(Omegak)-yp*cos(ik)*sin(Omegak);
    yk = xp*sin(Omegak)+yp*cos(ik)*cos(Omegak);
    zk = yp*sin(ik);
    
    % GPS satellite position resolved in ECEF frame [m]
    r_sat_ecef = [xk;
                  yk;
                  zk];
    
    % -------------------------------------
    % ECEF velocity resolved in ECEF frame.
    % -------------------------------------
    
    % eccentric anomaly rate [rad/s]
    Ek_dot = n/(1-e*cos(Ek));
    
    % true anomaly rate [rad/s]
    nuk_dot = Ek_dot*sqrt(1-e^2)/(1-e*cos(Ek));
    
    % corected inclination angle rate [rad/s]
    dikdt = IDOT+2*nuk_dot*(Cis*cos(2*phik)-Cic*sin(2*phik));
    
    % corrected argument of latitude rate [rad/s]
    uk_dot = nuk_dot+2*nuk_dot*(Cus*cos(2*phik)-Cuc*sin(2*phik));
    
    % corrected radius rate [m/s]
    rk_dot = a*e*Ek_dot*sin(Ek)+2*nuk_dot*(Crs*cos(2*phik)-Crc*sin(2*...
        phik));
    
    % longitude of ascending node rate [rad/s]
    Omegak_dot = Om_dot-w_earth;
    
    % in-plane x velocity [m/s]
    xp_dot = rk_dot*cos(uk)-rk*uk_dot*sin(uk);
    
    % in-plane y velocity [m/s]
    yp_dot = rk_dot*sin(uk)+rk*uk_dot*cos(uk);
    
    % Earth-fixed x velocity [m/s]
    xk_dot = -xp*Omegak_dot*sin(Omegak)+xp_dot*cos(Omegak)-yp_dot*...
        sin(Omegak)*cos(ik)-yp*(Omegak_dot*cos(Omegak)*cos(ik)-dikdt*...
        sin(Omegak)*sin(ik));
    
    % Earth-fixed y velocity [m/s]
    yk_dot = xp*Omegak_dot*cos(Omegak)+xp_dot*sin(Omegak)+yp_dot*...
        cos(Omegak)*cos(ik)-yp*(Omegak_dot*sin(Omegak)*cos(ik)+dikdt*...
        cos(Omegak)*sin(ik));
    
    % Earth-fixed z velocity [m/s]
    zk_dot = yp_dot*sin(ik)+yp*dikdt*cos(ik);
    
    % GPS satellite Earth-fixed velocity resolved in ECEF frame [m/s]
    v_sat_ecef = [xk_dot;
                  yk_dot;
                  zk_dot];
    
    % -----------
    % Clock bias.
    % -----------
    
    % constant for computing relativistic correction term [s/√m]
    F = -2*sqrt(mu)/c;
    
    % relativistic correction term [s]
    dtr = F*e^(sqrt_a)*sin(Ek);
    
    % clock offset [s]
    dt = af0+af1*(t-toc)+af2*(t-toc)^2+dtr-TGD;
    
    % clock offset derivative [s/s]
    dt_dot = af1+2*af2*(t-toc)+((n*F*e*sqrt(a)*cos(Ek))/(1-e*cos(Ek)));
    
    % clock bias [m]
    b_sat = c*dt;
    
    % clock dift [m/s]
    b_dot_sat = c*dt_dot;
    
end