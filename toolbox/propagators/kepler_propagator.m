%==========================================================================
%
% kepler_propagator  Simulates a Keplerian orbit.
%
%   [t,nu,M,E,r_eci,v_eci,r_ecef,v_ecef,lat,lon,h,GMST] =...
%       kepler_propagator(a,e,i,Om,w,nu0,cal_UTC0,t_length,dt,mu)
%
% Author: Tamas Kis
% Last Update: 2022-02-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   a           - (1×1 double) semi-major axis [m]
%   e           - (1×1 double) eccentricity [-]
%   i           - (1×1 double) inclination [rad]
%   Om          - (1×1 double) right ascension of the ascending node [rad]
%   w           - (1×1 double) argument of periapsis [rad]
%   nu0         - (1×1 double) true anomaly at epoch [rad]
%   UTC_start   - (1×6 double) initial UTC [y,mo,d,m,h,s]
%   duration    - (1×1 double) (OPTIONAL) simulation duration (defaults to
%                 one orbital period) [h]
%   dt          - (1×1 double) (OPTIONAL) time step (defaults to 
%                 duration/1000) [s]
%   mu          - (1×1 double) (OPTIONAL) gravitational parameter [m^3/s^2]
%
% -------
% OUTPUT:
% -------
%   t           - (N×1 double) simulation time vector [s]
%   nu          - (N×1 double) true anomaly [rad]
%   M           - (N×1 double) mean anomaly [rad]
%   E           - (N×1 double) eccentric anomaly [rad]
%   r_eci       - (N×3 double) position resolved in ECI frame [m]
%   v_eci       - (N×3 double) inertial vel. resolved in ECI frame [m/s]
%   r_ecef      - (N×3 double) position resolved in ECEF frame [m]
%   v_ecef      - (N×3 double) ECEF velocity resolved in ECEF frame [m/s]
%   lat         - (N×1 double) geodetic latitude [°]
%   lon         - (N×1 double) geodetic longitude [°]
%   h           - (N×1 double) geodetic altitude [m]
%   GMST        - (N×1 double) Greenwich mean sidereal time [rad]
%
% -----
% NOTE:
% -----
%   --> time vector (t) is measured with respect to the epoch (i.e. t = 1 s
%       means one second after epoch)
%   --> N = length of time vector
%   
%==========================================================================
function [t,nu,M,E,r_eci,v_eci,r_ecef,v_ecef,lat,lon,h,GMST] =...
    kepler_propagator(a,e,i,Om,w,nu0,UTC_start,duration,dt,mu)
    
    % ----------------------------------------------------
    % Sets unspecified parameters to their default values.
    % ----------------------------------------------------

    % sets gravitational parameter (defaults to Earth's) [m^3/s^2]
    if nargin < 10
        mu = MU_EARTH;
    end

    % sets simulation length (defaults to one orbital period) [s]
    if (nargin < 8) || isempty(duration)
        duration = a2T(a,mu);
    else
        duration = duration/3600;
    end

    % sets time step (defaults to t_length/1000) [s]
    if (nargin < 9) || isempty(dt)
        dt = round(duration/1000);
    end

    % ------------------
    % Orbit propagation.
    % ------------------
    
    % simulation time vector
    t = (0:dt:duration)';

    % modified Julian date of initial UTC [MJD]
    MJD_UTC0 = cal2mjd(UTC_start);
    
    % difference between UT1 and UTC (ΔUT1 = UT1 - UTC) [s]
    DUT1 = get_DUT1(UTC_start);
    
    % initial UT1 [MJD]
    MJD_UT10 = utc2ut1(MJD_UTC0,DUT1);
    
    % mean motion [rad/s]
    n = a2n(a,mu);
    
    % mean anomaly at epoch [rad]
    M0 = nu2M(nu0,e);
    
    % length of time vector
    N = length(t);

    % preallocates arrays
    nu = zeros(N,1);
    M = zeros(N,1);
    E = zeros(N,1);
    r_eci = zeros(3,N);
    v_eci = zeros(3,N);
    r_ecef = zeros(3,N);
    v_ecef = zeros(3,N);
    lat = zeros(N,1);
    lon = zeros(N,1);
    h = zeros(N,1);
    GMST = zeros(N,1);
    
    % orbit propagation
    for j = 1:length(t)
        
        % mean anomaly [rad]
        M(j) = t2M(t(j),t(1),M0,n);
        
        % eccentric anomaly [rad]
        E(j) = M2E(M(j),e);
        
        % true anomaly [rad]
        nu(j) = E2nu(E(j),e);
        
        % ECI position [m] and velocity [m/s]
        [r_eci(:,j),v_eci(:,j)] = oe2eci(a,e,i,Om,w,nu(j));
        
        % UT1 [MJD]
        MJD_UT1 = t(j)/(24*3600)+MJD_UT10;
        
        % Greenwich mean sidereal time [rad] TODO
        GMST(j) = UT1toGMST(MJD_UT1);
        
        % position [m] and ECEF velocity [m/s] resolved in ECEF frame
        [r_ecef(:,j),v_ecef(:,j)] = eci2ecef(r_eci(:,j),v_eci(:,j),...
            GMST(j));
        
        % geodetic latitude [°], longitude [°], and altitude [m]
        [lat(j),lon(j),h(j)] = ecef2geod(r_ecef(:,j));
        
    end

end