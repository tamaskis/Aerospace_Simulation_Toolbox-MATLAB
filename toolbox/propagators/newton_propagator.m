%==========================================================================
%
% newton_propagator  Time derivative of a satellite's ECI state vector.
%
%   [dXdt,extra] = newton_propagator(X,t,prop,sat)
%   [dXdt,extra] = newton_propagator(X,t,prop,sat,ae_rtn,drho,dB)
%
% See also initialize_propagator.
%
% Author: Tamas Kis
% Last Update: 2022-03-09
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   X       - (6×1 double) orbital state vector
%               --> 1-3. r_eci  - position resolved in ECI frame [m]
%               --> 4-6. v_eci  - inertial velocity resolved in ECI frame 
%                                 [m/s]
%   t       - (1×1 double) simulation time [s]
%   prop    - (1×1 struct) propagator settings (see "initialize_propagator"
%             function for full definition)
%   sat     - (1×1 struct) satellite parameters
%       • m  	- (1×1 double) mass [kg]
%    	• AD   	- (1×1 double) atmospheric drag reference area [m^2]
%    	• CD  	- (1×1 double) drag coefficient [-]
%    	• Asrp  - (1×1 double) solar radiation pressure reference area 
%                 [m^2]
%     	• CR    - (1×1 double) coefficient of reflectivity [-]
%   ae_rtn  - (3×1 double) (OPTIONAL) empirical acceleration resolved in 
%             RTN frame [m/s^2]
%   drho    - (1×1 double) (OPTIONAL) atmospheric mass density offset [-]
%   dB      - (1×1 double) (OPTIONAL) ballistic coefficient offset [-]
%
% -------
% OUTPUT:
% -------
%   dXdt    - (6×1 double) orbital state vector derivative
%               --> 1-3. v_eci - inertial velocity resolved in ECI frame
%                                [m/s]
%               --> 4-6. a_eci - inertial acceleration resolved in ECI
%                                frame [m/s^2]
%   extra   - (1×1 struct) extra parameters to return
%       • a_eci      - (3×1 double) inertial acceleration resolved in ECI 
%                      frame [m/s^2]
%       • r_ecef     - (3×1 double) position resolved in ECEF frame [m]
%       • v_ecef     - (3×1 double) ECEF velocity resolved in ECEF frame 
%                      [m/s]
%       • lat        - (1×1 double) geodetic latitude [deg]
%       • lon        - (1×1 double) geodetic longitude [deg]
%       • h          - (1×1 double) geodetic altitude [deg]
%       • xp         - (1×1 double) polar coordinate of the CIP ['']
%       • yp         - (1×1 double) polar coordinate of the CIP ['']
%       • dX         - (1×1 double) correction term for X [mas]
%       • dY         - (1×1 double) correction term for Y [mas]
%       • LOD        - (1×1 double) length of day [ms]
%       • R_ecef2eci - (3×3 double) rotation matrix (ECEF --> ECI) [-]
%       • R_eci2ecef - (3×3 double) rotation matrix (ECI --> ECEF) [-]
%       • w_eci      - (3×1 double) Earth angular velocity resolved in ECI
%                      frame [rad/s]
%       • Q          - (3×3 double) precession-nutation matrix (CIRS --> 
%                      GCRF) [-]
%       • R          - (3×3 double) sidereal-rotation matrix (TIRS --> 
%                      CIRS) [-]
%       • W          - (3×3 double) polar-motion matrix (ITRF --> TIRS) [-]
%       • epsilon    - (1×1 double) obliquity of the ecliptic [rad]
%       • r_sun_eci  - (3×1 double) Sun position resolved in ECI frame [m]
%       • r_moon_eci - (3×1 double) Moon position resolved in ECI frame [m]
%       • in_eclipse - (1×1 logical) true if satellite is in eclipse, false
%                      otherwise
%       • ap_array   - (1×7 double) planetary amplitude array for
%                      NRLMSISE-00 atmospheric model
%           ‣ 1. Ap       - daily planetary amplitude (current day - no 
%                           lag) [γ]
%           ‣ 2. ap       - planetary amplitude (current time) [γ]
%           ‣ 3. ap3      - planetary amplitude (3 hours before) [γ]
%           ‣ 4. ap6      - planetary amplitude (6 hours before) [γ]
%           ‣ 5. ap9      - planetary amplitude (9 hours before) [γ]
%           ‣ 6. ap_12_33 - planetary amplitude (average of 12-33 hours 
%                           before) [γ]
%           ‣ 7. ap_36_57 - planetary amplitude (average of 36-57 hours 
%                           before) [γ]
%       • dTc        - (1×1 double) temperature change derived from Dst 
%                      index for current time [K]
%       • F107       - (1×1 double) daily 10.7 cm solar flux (1-day lag)
%                      [SFU]
%       • F107_avg   - (1×1 double) centered 81-day average of F10.7 (1-day
%                      lag) [SFU]
%       • Kp         - (1×1 double) planetary index (3-hour lag) [-]
%       • M107       - (1×1 double) daily Mg II index (2-day lag) [SFU]
%       • M107_avg   - (1×1 double) centered 81-day average of M10.7 (2-day
%                      lag) [SFU]
%       • S107       - (1×1 double) daily 26-34 nm EUV index (1-day lag) 
%                      [SFU]
%       • S107_avg   - (1×1 double) centered 81-day average of S10.7 (1-day
%                      lag) [SFU]
%       • Y107       - (1×1 double) daily solar X-ray and Lyman-α emission 
%                      mixed index (5-day lag) [SFU]
%       • Y107_avg   - (1×1 double) centered 81-day average of Y10.7 (5-day
%                      lag) [SFU]
%       • rho        - (1×1 double) atmospheric density [kg/m^3]
%       • nAr        - (1×1 double) atomic argon number density [m^-3]
%       • nH         - (1×1 double) atomic hydrogen number density [m^-3]
%       • nHe        - (1×1 double) atomic helium number density [m^-3]
%       • nN2        - (1×1 double) diatomic nitrogen number density [m^-3]
%       • nO         - (1×1 double) atomic oxygen number density [m^-3]
%       • nO2        - (1×1 double) diatomic oxygen number density [m^-3]
%       • T_h        - (1×1 double) temperature at altitude [K]
%       • T_inf      - (1×1 double) exospheric temperature [K]
%       • g_ecef     - (3×1 double) acceleration due to gravity resolved
%                      in ECEF frame [m/s^2]
%       • g_eci      - (3×1 double) acceleration due to gravity resolved
%                      in ECI frame [m/s^2]
%       • f_D_eci    - (3×1 double) perturbing acceleration due to 
%                      atmospheric drag resolved in ECI frame [m/s^2]
%       • f_srp_eci  - (3×1 double) perturbing acceleration due to solar 
%                      radiation  pressure resolved in ECI frame [m/s^2]
%       • f_moon_eci - (3×1 double) perturbing acceleration due to 3rd-body
%                      gravity from Moon resolved in ECI frame [m/s^2]
%       • f_sun_eci  - (3×1 double) perturbing acceleration due to 3rd-body
%                      gravity from Sun resolved in ECI frame [m/s^2]
%       • f_rel_eci  - (3×1 double) acceleration due to relativistic
%                      effects resolved in ECI frame [m/s^2]
%       • MJD_GPS    - (1×1 double) GPS time [MJD]
%       • MJD_TAI    - (1×1 double) UTC (International Atomic Time) [MJD]
%       • MJD_TT     - (1×1 double) TT (Terrestrial Time) [MJD]
%       • MJD_UT1    - (1×1 double) UT1 (Universal Time 1) [MJD]
%       • MJD_UTC    - (1×1 double) UTC (Universal Coordinated Time) [MJD]
%       • cal_UTC    - (1×6 double) UTC (Universal Coordinated Time)
%                      [y,mo,d,h,m,s]
%
%==========================================================================
function [dXdt,extra] = newton_propagator(X,t,prop,sat,ae_rtn,drho,dB)
    
    % -----------------
    % Input processing.
    % -----------------

    % extracts ECI position [m] and inertial velocity [m/s] 
    r_eci = X(1:3);
    v_eci = X(4:6);

    % defaults optional parameters to 0 if not input
    if (nargin < 5) || isempty(ae_rtn), ae_rtn = [0;0;0]; end
    if (nargin < 6) || isempty(drho), drho = 0; end
    if (nargin < 7) || isempty(dB), dB = 0; end

    % -------
    % Timing.
    % -------
    
    % TODO: need to update time scales/offsets when going to new day

    % time scales [MJD]
    [MJD_GPS,MJD_TAI,MJD_TT,MJD_UT1,MJD_UTC] = time_scales(t,prop.t0);
    
    % Gregorian date of UTC [y,mo,d,h,m,s]
    cal_UTC = mjd2cal(MJD_UTC);
    
    % ------------------
    % Earth orientation.
    % ------------------

    if strcmpi(prop.models.orientation,'IAU2006/2000')

        % Earth orientation parameters for IAU2006/2000 CIO based theory
        [xp,yp,dX,dY,LOD] = eop_iau06(MJD_UT1,prop.data.eop);
        
        % rotation matrices and Earth angular velocity [rad/s] from 
        % IAU2006/2000  CIO based theory
        [R_ecef2eci,R_eci2ecef,w_eci,Q,R,W] = iau06(MJD_UT1,MJD_TT,xp,...
            yp,dX,dY,LOD,prop.data.XYs_iau06);
        
    else

        % rotation matrix from ECI frame to ECEF frame
        R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1,prop.models.gmst);

        % rotation matrix from ECEF frame to ECI frame
        R_ecef2eci = R_eci2ecef.';

        % Earth angular velocity [rad/s]
        w_eci = w_earth_approx;

        % sets Earth orientation parameters to NaN since they are not 
        % calculated
        xp = NaN;
        yp = NaN;
        dX = NaN;
        dY = NaN;
        LOD = NaN;

        % sets precession-nutation, sidereal-rotation, and polar-motion
        % matrices to NaN since they are not calculated
        Q = NaN;
        R = NaN;
        W = NaN;

    end
    
    % ----------------------------
    % Other state representations.
    % ----------------------------

    % position [m] and ECEF velocity [m/s] resolved in ECEF frame
    [r_ecef,v_ecef] = eci2ecef(r_eci,v_eci,w_eci,R_eci2ecef);
    
    % geodetic latitude [°], longitude [°], and altitude [m]
    [lat,lon,h] = ecef2geod(r_ecef);

    % ------------
    % Environment.
    % ------------

    % obliquity of the ecliptic [rad]
    epsilon = obliquity(MJD_TT);

    % Moon position resolved in ECI frame [m]
    r_moon_eci = moon_position(MJD_UT1,epsilon);

    % Sun position resolved in ECI frame [m]
    r_sun_eci = sun_position(MJD_UT1,epsilon);

    % determines if satellite is in eclipse
    in_eclipse = eclipse(r_eci,r_sun_eci);

    % space weather parameters
    sw = space_weather(MJD_UT1,prop.data.sw1,prop.data.sw2,...
        prop.models.density);

    % atmospheric density [kg/m^3], number densities [m^-3], and
    % temperatures [K]
    if strcmpi(prop.models.density,'Exponential')
        rho = exponential(r_ecef);
        n = struct('nAr',NaN,'nH',NaN,'nHe',NaN,'nN2',NaN,'nO',NaN,...
            'nO2',NaN);
        T = struct('T_h',NaN,'T_inf',NaN);
    elseif strcmpi(prop.models.density,'Harris-Priester')
        rho = harris_priester(r_eci,r_ecef,r_sun_eci);
        n = struct('nAr',NaN,'nH',NaN,'nHe',NaN,'nN2',NaN,'nO',NaN,...
            'nO2',NaN);
        T = struct('T_h',NaN,'T_inf',NaN);
    elseif strcmpi(prop.models.density,'Jacchia-Bowman 2008')
        [rho,T] = jacchia_bowman_2008(r_ecef,r_sun_eci,MJD_UT1,sw.F107,...
            sw.F107_avg,sw.S107,sw.S107_avg,sw.M107,sw.M107_avg,sw.Y107,...
            sw.Y107_avg,sw.dTc);
        n = struct('nAr',NaN,'nH',NaN,'nHe',NaN,'nN2',NaN,'nO',NaN,...
            'nO2',NaN);
    elseif strcmpi(prop.models.density,'Jacchia-Roberts')
        [rho,n,T] = jacchia_roberts(r_eci,r_ecef,r_sun_eci,R_eci2ecef,...
            MJD_TT);
    elseif strcmpi(prop.models.density,'NRLMSISE-00')
        [rho,n,T] = nrlmsise00(r_ecef,MJD_UT1,sw.F107_avg,sw.F107,...
            sw.ap_array,prop.data.nrlm_data);
    elseif strcmpi(prop.models.density,'NRLMSISE-00 (MATLAB)')
        [rho,n,T] = nrlmsise00_matlab(r_ecef,MJD_UT1,sw.F107_avg,...
            sw.F107,sw.ap_array);
    else
        rho = 0;
        n = struct('nAr',NaN,'nH',NaN,'nHe',NaN,'nN2',NaN,'nO',NaN,...
            'nO2',NaN);
        T = struct('T_h',NaN,'T_inf',NaN);
    end

    % --------------
    % Accelerations.
    % --------------

    % acceleration due to gravity resolved in ECEF frame [m/s^2]
    g_ecef = gravity(r_ecef,prop.data.C,prop.data.S,prop.models.grav_N);

    % acceleration due to gravity resolved in ECI frame [m/s^2]
    g_eci = R_ecef2eci*g_ecef;

    % perturbing acceleration due to atmospheric drag resolved in ECI frame 
    % [m/s^2]
    %   --> density and ballistic coefficients modified by multiplicative
    %       offsets input to "newton_propagator" function
    if prop.perturb.drag
        f_D_eci = drag(r_eci,v_eci,w_eci,rho*(1+drho),sat.B*(1+dB));
    else
        f_D_eci = [0;0;0];
    end
    
    % perturbing acceleration due to solar radiation pressure resolved in
    % ECI frame [m/s^2]
    if prop.perturb.srp
        f_srp_eci = srp(r_eci,r_sun_eci,sat.CR,sat.Asrp,sat.m);
    else
        f_srp_eci = [0;0;0];
    end
    
    % perturbing acceleration due to 3rd-body gravity from the Moon 
    % resolved in ECI frame [m/s^2]
    if prop.perturb.moon
        f_moon_eci = third_body(r_eci,r_moon_eci,MU_MOON);
    else
        f_moon_eci = [0;0;0];
    end

    % perturbing acceleration due to 3rd-body gravity from the Sun resolved
    % in ECI frame [m/s^2]
    if prop.perturb.sun
        f_sun_eci = third_body(r_eci,r_sun_eci,MU_SUN);
    else
        f_sun_eci = [0;0;0];
    end

    % perturbing acceleration due to general relativity resolved in ECI 
    % frame [m/s^2]
    if prop.perturb.relativity
        f_rel_eci = relativity(r_eci,v_eci);
    else
        f_rel_eci = [0;0;0];
    end

    % empirical acceleration resolved in ECI frame [m/s^2]
    if prop.perturb.empirical
        ae_eci = rtn2eci_matrix(r_eci,v_eci)*ae_rtn;
    else
        ae_eci = [0;0;0];
    end

    % total inertial acceleration resolved in ECI frame [m/s^2]
    a_eci = g_eci+f_D_eci+f_srp_eci+f_moon_eci+f_sun_eci+f_rel_eci+ae_eci;
    
    % ------------------------
    % State vector derivative.
    % ------------------------
    
    dXdt = [v_eci;a_eci];

    % -------------------------
    % Storing extra parameters.
    % -------------------------

    % state
    extra.a_eci = a_eci;
    extra.r_ecef = r_ecef;
    extra.v_ecef = v_ecef;
    extra.lat = lat;
    extra.lon = lon;
    extra.h = h;

    % Earth orientation parameters
    extra.xp = xp;
    extra.yp = yp;
    extra.dX = dX;
    extra.dY = dY;
    extra.LOD = LOD;

    % Earth orientation
    extra.R_ecef2eci = R_ecef2eci;
    extra.R_eci2ecef = R_eci2ecef;
    extra.w_eci = w_eci;
    extra.Q = Q;
    extra.R = R;
    extra.W = W;

    % environment
    extra.epsilon = epsilon;
    extra.r_moon_eci = r_moon_eci;
    extra.r_sun_eci = r_sun_eci;
    extra.in_eclipse = in_eclipse;
    extra.ap_array = sw.ap_array;
    extra.dTc = sw.dTc;
    extra.F107 = sw.F107;
    extra.F107_avg = sw.F107_avg;
    extra.Kp = sw.Kp;
    extra.M107 = sw.M107;
    extra.M107_avg = sw.M107_avg;
    extra.S107 = sw.S107;
    extra.S107_avg = sw.S107_avg;
    extra.Y107 = sw.Y107;
    extra.Y107_avg = sw.Y107_avg;
    extra.rho = rho;
    extra.nAr = n.nAr;
    extra.nH = n.nH;
    extra.nHe = n.nHe;
    extra.nN2 = n.nN2;
    extra.nO = n.nO;
    extra.nO2 = n.nO2;
    extra.T_h = T.T_h;
    extra.T_inf = T.T_inf;
    
    % forces and perturbations
    extra.g_ecef = g_ecef;
    extra.g_eci = g_eci;
    extra.f_D_eci = f_D_eci;
    extra.f_srp_eci = f_srp_eci;
    extra.f_moon_eci = f_moon_eci;
    extra.f_sun_eci = f_sun_eci;
    extra.f_rel_eci = f_rel_eci;

    % time
    extra.MJD_GPS = MJD_GPS;
    extra.MJD_TAI = MJD_TAI;
    extra.MJD_TT = MJD_TT;
    extra.MJD_UT1 = MJD_UT1;
    extra.MJD_UTC = MJD_UTC;
    extra.cal_UTC = cal_UTC;
    
end