%==========================================================================
%
% simulate_orbit  Simulates an orbit.
%
%   data = simulate_orbit(sat,prop)
%
% Author: Tamas Kis
% Last Update: 2022-03-06
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   sat     - (1×1 struct) satellite parameters (NOTE: the input structure
%             may contain additional fields; however, the fields below are 
%             all that are needeed for this function)
%       • m  	- (1×1 double) mass [kg]
%    	• AD   	- (1×1 double) atmospheric drag reference area [m^2]
%    	• CD  	- (1×1 double) drag coefficient [-]
%    	• B   	- (1×1 double) ballistic coefficient [m^2/kg]
%    	• Asrp  - (1×1 double) solar radiation pressure reference area 
%                 [m^2]
%     	• CR 	- (1×1 double) coefficient of reflectivity [-]
%    	• ECI   - (6×1 double) initial ECI state
%                   1-3. r_eci - position resolved in ECI frame [m]
%                   4-6. v_eci - inertial vel. resolved in ECI frame [m/s]
%   prop    - (1×1 struct) propagator settings (see "initialize_propagator"
%             function for full definition)
%   drho    - (1×1 double) (OPTIONAL) atmospheric mass density offset [-]
%   dB      - (1×1 double) (OPTIONAL) ballistic coefficient offset [-]
%
% -------
% OUTPUT:
% -------
%   data    - (1×1 struct) structure to store all simulation data
%       • r_eci      - (3×N double) position resolved in ECI frame [m]
%       • v_eci      - (3×N double) inertial velocity resolved in ECI frame
%                      [m/s]
%       • a_eci      - (3×N double) inertial acceleration resolved in ECI 
%                      frame [m/s^2]
%       • r_ecef     - (3×N double) position resolved in ECEF frame [m]
%       • v_ecef     - (3×N double) ECEF velocity resolved in ECEF frame 
%                      [m/s]
%       • lat        - (N×1 double) geodetic latitude [deg]
%       • lon        - (N×1 double) geodetic longitude [deg]
%       • h          - (N×1 double) geodetic altitude [deg]
%       • xp         - (1×1 double) polar coordinate of the CIP ['']
%       • yp         - (1×1 double) polar coordinate of the CIP ['']
%       • dX         - (1×1 double) correction term for X [mas]
%       • dY         - (1×1 double) correction term for Y [mas]
%       • LOD        - (1×1 double) length of day [ms]
%       • epsilon    - (N×1 double) obliquity of the ecliptic [rad]
%       • r_sun_eci  - (3×N double) Sun position resolved in ECI frame [m]
%       • r_moon_eci - (3×N double) Moon position resolved in ECI frame [m]
%       • in_eclipse - (N×1 logical) true if satellite is in eclipse, false
%                      otherwise
%       • rho        - (N×1 double) atmospheric density [kg/m^3]
%       • nAr        - (N×1 double) atomic argon number density [m^-3]
%       • nH         - (N×1 double) atomic hydrogen number density [m^-3]
%       • nHe        - (N×1 double) atomic helium number density [m^-3]
%       • nN2        - (N×1 double) diatomic nitrogen number density [m^-3]
%       • nO         - (N×1 double) atomic oxygen number density [m^-3]
%       • nO2        - (N×1 double) diatomic oxygen number density [m^-3]
%       • T          - (N×1 double) temperature at altitude [K]
%       • T_inf      - (N×1 double) exospheric temperature [K]
%       • g_ecef     - (3×N double) acceleration due to gravity resolved
%                      in ECEF frame [m/s^2]
%       • g_eci      - (3×N double) acceleration due to gravity resolved
%                      in ECI frame [m/s^2]
%       • fD_eci     - (3×N double) perturbing acceleration due to 
%                      atmospheric drag resolved in ECI frame [m/s^2]
%       • f_srp_eci  - (3×N double) perturbing acceleration due to solar 
%                      radiation  pressure resolved in ECI frame [m/s^2]
%       • f_moon_eci - (3×N double) perturbing acceleration due to 3rd-body
%                      gravity from Moon resolved in ECI frame [m/s^2]
%       • f_sun_eci  - (3×N double) perturbing acceleration due to 3rd-body
%                      gravity from Sun resolved in ECI frame [m/s^2]
%       • f_rel_eci  - (3×N double) acceleration due to relativistic
%                      effects resolved in ECI frame [m/s^2]
%       • t          - (N×1 double) simulation time [s]
%       • MJD_GPS    - (N×1 double) GPS time [MJD]
%       • MJD_TAI    - (N×1 double) UTC (International Atomic Time) [MJD]
%       • MJD_TT     - (N×1 double) TT (Terrestrial Time) [MJD]
%       • MJD_UT1    - (N×1 double) UT1 (Universal Time 1) [MJD]
%       • MJD_UTC    - (N×1 double) UTC (Universal Coordinated Time) [MJD]
%       • cal_UTC    - (N×6 double) UTC (Universal Coordinated Time)
%                      [y,mo,d,h,m,s]
%
% -----
% NOTE:
% -----
%   --> N = number of iterations (i.e. length of time vector)
%
%--------------------------------------------------------------------------
function data = simulate_orbit(sat,prop,drho,dB)

    % defaults "drho" to 0 if not input
    if (nargin < 3) || isempty(drho)
        drho = 0;
    end

     % defaults "dB" to 0 if not input
    if (nargin < 4) || isempty(dB)
        dB = 0;
    end

    % -----------------
    % Orbit simulation.
    % -----------------
    
    % extracts parameters needed for ODE solver
    dt = prop.solver.dt;
    x0 = sat.ECI;
    t0 = prop.solver.t0;
    tf = prop.solver.tf;
    
    % dynamics equation
    f = @(t,X) newton_propagator(X,t,prop,sat,[],drho,dB);

    % simulates orbit
    if strcmpi(prop.solver.method,'ABM8')
        [t,X] = ABM8(f,[t0,tf],x0,dt,true);
    elseif strcmpi(prop.solver.method,'RK4')
        [t,X] = RK4(f,[t0,tf],x0,dt,true);
    end
    
    % reshapes solution into 6×N matrix
    X = X';

    % simulation time [s]
    data.t = t;
    
    % extracts ECI position [m] and velocity [m/s]
    data.r_eci = X(1:3,:);
    data.v_eci = X(4:6,:);
    
    % length of time vector
    N = length(t);

    % preallocates arrays to store results
    data.a_eci = zeros(3,N);
    data.r_ecef = zeros(3,N);
    data.v_ecef = zeros(3,N);
    data.lat = zeros(N,1);
    data.lon = zeros(N,1);
    data.h = zeros(N,1);
    data.xp = zeros(N,1);
    data.yp = zeros(N,1);
    data.dX = zeros(N,1);
    data.dY = zeros(N,1);
    data.LOD = zeros(N,1);
    data.R_ecef2eci = zeros(3,3,N);
    data.R_eci2ecef = zeros(3,3,N);
    data.w_eci = zeros(3,N);
    data.Q = zeros(3,3,N);
    data.R = zeros(3,3,N);
    data.W = zeros(3,3,N);
    data.epsilon = zeros(N,1);
    data.r_sun_eci = zeros(3,N);
    data.r_moon_eci = zeros(3,N);
    data.in_eclipse = false(N,1);
    data.ap_array = zeros(N,7);
    data.dTc = zeros(N,1);
    data.F107 = zeros(N,1);
    data.F107_avg = zeros(N,1);
    data.Kp = zeros(N,1);
    data.M107 = zeros(N,1);
    data.M107_avg = zeros(N,1);
    data.S107 = zeros(N,1);
    data.S107_avg = zeros(N,1);
    data.Y107 = zeros(N,1);
    data.Y107_avg = zeros(N,1);
    data.rho = zeros(N,1);
    data.nAr = zeros(N,1);
    data.nH = zeros(N,1);
    data.nHe = zeros(N,1);
    data.nN2 = zeros(N,1);
    data.nO = zeros(N,1);
    data.nO2 = zeros(N,1);
    data.T_h = zeros(N,1);
    data.T_inf = zeros(N,1);
    data.g_eci = zeros(3,N);
    data.f_D_eci = zeros(3,N);
    data.f_srp_eci = zeros(3,N);
    data.f_moon_eci = zeros(3,N);
    data.f_sun_eci = zeros(3,N);
    data.f_rel_eci = zeros(3,N);
    data.MJD_GPS = zeros(N,1);
    data.MJD_TAI = zeros(N,1);
    data.MJD_TT = zeros(N,1);
    data.MJD_UT1 = zeros(N,1);
    data.MJD_UTC = zeros(N,1);
    data.cal_UTC = zeros(N,6);
    
    for i = 1:length(t)

        % obtains extra parameters
        [~,extra] = f(t(i),X(:,i));

        % stores extra parameters
        data.a_eci(:,i) = extra.a_eci;
        data.r_ecef(:,i) = extra.r_ecef;
        data.v_ecef(:,i) = extra.v_ecef;
        data.lat(i) = extra.lat;
        data.lon(i) = extra.lon;
        data.h(i) = extra.h;
        data.xp(i) = extra.xp;
        data.yp(i) = extra.yp;
        data.dX(i) = extra.dX;
        data.dY(i) = extra.dY;
        data.LOD(i) = extra.LOD;
        data.R_ecef2eci(:,:,i) = extra.R_ecef2eci;
        data.R_eci2ecef(:,:,i) = extra.R_eci2ecef;
        data.w_eci(:,i) = extra.w_eci;
        data.Q(:,:,i) = extra.Q;
        data.R(:,:,i) = extra.R;
        data.W(:,:,i) = extra.W;
        data.epsilon(i) = extra.epsilon;
        data.r_sun_eci(:,i) = extra.r_sun_eci;
        data.r_moon_eci(:,i) = extra.r_moon_eci;
        data.in_eclipse(i) = extra.in_eclipse;
        data.ap_array(i,:) = extra.ap_array;
        data.dTc(i) = extra.dTc;
        data.F107(i) = extra.F107;
        data.F107_avg(i) = extra.F107_avg;
        data.Kp(i) = extra.Kp;
        data.M107(i) = extra.M107;
        data.M107_avg(i) = extra.M107_avg;
        data.S107(i) = extra.S107;
        data.S107_avg(i) = extra.S107_avg;
        data.Y107(i) = extra.Y107;
        data.Y107_avg(i) = extra.Y107_avg;
        data.rho(i) = extra.rho;
        data.nAr(i) = extra.nAr;
        data.nH(i) = extra.nH;
        data.nHe(i) = extra.nHe;
        data.nN2(i) = extra.nN2;
        data.nO(i) = extra.nO;
        data.nO2(i) = extra.nO2;
        data.T_h(i) = extra.T_h;
        data.T_inf(i) = extra.T_inf;
        data.g_eci(:,i) = extra.g_eci;
        data.f_D_eci(:,i) = extra.f_D_eci;
        data.f_srp_eci(:,i) = extra.f_srp_eci;
        data.f_moon_eci(:,i) = extra.f_moon_eci;
        data.f_sun_eci(:,i) = extra.f_sun_eci;
        data.f_rel_eci(:,i) = extra.f_rel_eci;
        data.MJD_GPS(i) = extra.MJD_GPS;
        data.MJD_TAI(i) = extra.MJD_TAI;
        data.MJD_TT(i) = extra.MJD_TT;
        data.MJD_UT1(i) = extra.MJD_UT1;
        data.MJD_UTC(i) = extra.MJD_UTC;
        data.cal_UTC(i,:) = extra.cal_UTC;

    end
    
end