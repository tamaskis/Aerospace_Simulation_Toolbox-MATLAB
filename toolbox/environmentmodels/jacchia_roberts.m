%==========================================================================
%
% jacchia_roberts  Jacchia-Roberts model for atmospheric density.
%
%   rho = jacchia_roberts(r_ecef,r_sun_eci,R_eci2ecef,MJD_TT)
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] TODO
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef      - (3×1 double) satellite position resolved in ECEF frame
%                 [m]
%   r_sun_eci   - (3×1 double) Sun position resolved in ECI frame [m]
%   R_eci2ecef  - (3×3 double) rotation matrix (ECI --> ECEF) [-]
%   MJD_TT      - (1×1 double) TT (Terrestrial Time) [MJD]
%
% -------
% OUTPUT:
% -------
%   rho         - (1×1 double) atmospheric mass density [kg/m^3]
%
%==========================================================================
function [rho,n,T] = jacchia_roberts(r_ecef,r_sun_eci,R_eci2ecef,...
    MJD_UT1,MJD_TT,F107_avg,F107,Kp)
    
    % ----------
    % Constants.
    % ----------
    
    % Earth polar radius [km]
    Rp = 6356.766;
    
    % mean surface gravity [m/s^2]
    g0 = 9.80665;
    
    % universal gas constant [J/(K.mol)]
    Ru = 8.31432;
    
    % Avogadro's number [1/mol]
    A = 6.02257e23;

    % curve-fitting coefficients for evaluating constituent densities
    delta = [ 0.1093155e+02   0.8049405e+01   0.7646886e+01   0.9924237e+01   0.1097083e+02; 
              0.1186783e-02   0.2382822e-02  -0.4383486e-03   0.1600311e-02   0.6118742e-04;
             -0.1677341e-05  -0.3391366e-05   0.4694319e-06  -0.2274761e-05  -0.1165003e-06;
              0.1420228e-08   0.2909714e-08  -0.2894886e-09   0.1938454e-08   0.9239354e-10;
             -0.7139785e-12  -0.1481702e-11   0.9451989e-13  -0.9782183e-12  -0.3490739e-13;
              0.1969715e-15   0.4127600e-15  -0.1270838e-16   0.2698450e-15   0.5116298e-17;
             -0.2296182e-19  -0.4837461e-19   0              -0.3131808e-19   0];

    % molecular masses of the atmospheric constituents [kg/mol]
    M = [28.0134;   % 1 = N2
         39.948;    % 2 = Ar
         4.0026;    % 3 = He
         31.9988;   % 4 = O2
         15.9994;   % 5 = O
         1.00797];  % 6 - H
    
    % thermal diffusion coefficients of the atmospheric constituents
    a = [ 0;
          0;
         -0.38;
          0;
          0;
          0];
    
    % ---------------------
    % Geometric parameters.
    % ---------------------
    
    % obliquity of the ecliptic [rad]
    epsilon = obliquity(MJD_TT);
    
    % geodetic latitude [deg] and altitude [m]
    [phi,lon,h] = ecef2geod(r_ecef);
    
    % convert geodetic latitude to radians
    phi = deg2rad(phi);

    % convert altitude to kilometers
    h = 0.001*h;
    
    % Sun's geocentric declination [rad]
    [alpha,delta_sun] = r2ad(r_sun_eci);
    
    % Sun position resolved in the ECEF frame [m]
    r_sun_ecef = R_eci2ecef*r_sun_eci;
    
    % X and Y Sun ECEF position components
    sX = r_sun_ecef(1);
    sY = r_sun_ecef(2);
    
    % X and Y satellite ECEF position components
    rX = r_ecef(1);
    rY = r_ecef(2);
    
    % local hour angle of the Sun from the upper culmination [rad]
    LHA_sun = ((sX*rY-sY*rX)/abs(sX*rY-sY*rX))*acos((sX*rX+sY*rY)/...
        (sqrt(sX^2+sY^2)*sqrt(rX^2+rY^2)));
    
    %LHA_sun = deg2rad(lon)+gmst_linear(MJD_UT1)-alpha;

    % auxiliary angles [rad]
    eta = abs(phi-delta_sun)/2;
    theta = abs(phi+delta_sun)/2;
    tau = LHA_sun+(pi/180)*(6*sin(LHA_sun+(43*pi/180))-37);

    % ------------
    % Temperature.
    % ------------
    
    % nighttime global exospheric temperature (excluding geomagnetic
    % effects) [K]
    Tc = 379+3.24*F107_avg+1.3*(F107-F107_avg);
    
    % uncorrected exospheric temperature [K]
    T1 = Tc*(1+0.3*(sin(theta)^2.2+(cos(eta)^2.2-sin(theta)^2.2)*...
        cos(tau/2)^3));
    
    % correction factor for exospheric temperature [K]
    if h >= 200
        dT_inf = 28*Kp+0.03*exp(Kp);
    else
        dT_inf = 14*Kp+0.02*exp(Kp);
    end
    
    % corrected exospheric temperature [K]
    T_inf = T1+dT_inf;
    
    % inflection point temperature [K]
    Tx = 371.6678+0.0518806*T_inf-294.3505*exp(-0.00216222*T_inf);
    
    % length parameter coefficients [km]
    l0 = 0.1031445e5;
    l1 = 0.2341230e1;
    l2 = 0.1579202e-2;
    l3 = -0.1252487e-5;
    l4 = 0.2462708e-9;
    
    % length parameter [km]
    l = l0+(l1*T_inf)+(l2*T_inf^2)+(l3*T_inf^3)+(l4*T_inf^4);
    
    % base temperature [K]
    T0 = 183;
    
    % temperature [K]
    T = T_inf-(T_inf-Tx)*exp(-((Tx-T0)/(T_inf-Tx))*((h-125)/35)*(l/(Rp+...
        h)));

    % ------------------------------------
    % Standard constituent mass densities.
    % ------------------------------------

    % preallocates array to store the standard constituent mass densities
    rho = zeros(6,1);

    % evaluates standard constituent mass densities (N2, Ar, He, O2, O)
    for i = 1:5

        % exponent
        exponent = 0;
        for j = 1:7
            exponent = exponent+delta(j,i)*T_inf^(j-1);
        end
        
        % standard constituent mass density at 125 km [TODO]
        rho_125 = (M(i)/A)*10^(exponent);
        
        % TODO LABEL
        gamma = ((M(i)*g0*Rp^2)/(Ru*l*T_inf))*((T_inf-Tx)/(Tx-T0))*(35/...
            6481.766);
        
        % standard constituent mass density [TODO]
        rho(i) = rho_125*(Tx/T)^(1+a(i)+gamma)*((T_inf-Tx)/(T_inf-Tx))^...
            gamma;

    end

    % standard mass density of hydrogen
    if h >= 500
        
        % temperature at 500 km [K]
        T_500 = T_inf-(T_inf-Tx)*exp(-((Tx-T0)/(T_inf-Tx))*(375/35)*(l/...
            (Rp+500)));

        % exponent for calculating standard hydrogen mass density at 500 km
        f_H = 73.13-(39.4-5.5*log10(T_500))*log10(T_500);

        % standard hydrogen mass density at 500 km [TODO]
        rho_500 = (M(6)/A)*10^(f_H);
        
        % exponent for standard hydrogen mass density calculation
        gamma = ((M(6)*g0*Rp^2)/(Ru*l*T_inf))*((T_inf-Tx)/(Tx-T0))*(35/...
            6481.766);
        
        % standard hydrogen mass density [TODO]
        rho(6) = rho_500*(T_500/T)^(1+a(6)+gamma)*((T_inf-T)/(T_inf-...
            T_500))^gamma;

    end
    
    % ---------------------------------------
    % Corrections to standard mass densities.
    % ---------------------------------------

    % correction for geomagnetic effect below 200 km
    if h <= 200
        drho_G = 0.012*Kp+(1.2e-5)*exp(Kp);
    else
        drho_G = 0;
    end

    % Julian date of UT1 [JD]
    JD_UT1 = mjd2jd(MJD_UT1);

    % number of years since January 1, 1958 [y]
    T_1958 = (JD_UT1-2436204)/365.2422;

    % intermediate values for semi-annual density variation correction
    tau_SA = T_1958+0.09544*((0.5+0.5*sin(2*pi*T_1958+6.035))^1.65-0.5);
    f_SA = ((5.876e-7)*h^2.331+0.06328)*exp(-0.002868*h);
    g_SA = 0.02835+(0.3817+0.17829*sin(2*pi*tau_SA+4.137))*sin(4*pi*...
        tau_SA+4.259);

    % correction for semi-annual variations in density
    drho_SA = f_SA*g_SA;

    % correction for seasonal latitudinal variation of lower thermosphere
    drho_LT = 0.014*(h-90)*exp(-0.0013*(h-90)^2)*sin(2*pi*T_1958+1.72)*...
        sin(phi)*abs(sin(phi));

    % correction for seasonal latitudinal variation of helium
    drho_He = 0.65*abs(delta_sun/epsilon)*(sin((pi/4)-((phi*delta_sun)/...
        (2*abs(delta_sun))))^3-0.35355);

    % -------------------------------------
    % Corrected constituent mass densities.
    % -------------------------------------

    % apply corrections to all standard constituent densities
    rho = rho*10^(drho_G+drho_SA+drho_LT);
    
    % apply additional correction to helium
    rho(3) = rho(3)*10^(drho_He);

    % -----------------
    % Number densities.
    % -----------------

    % TODO [m^(-3)]
    nN2 = rho(1)*A/M(1)*1e6;
    nAr = rho(2)*A/M(2)*1e6;
    nHe = rho(3)*A/M(3)*1e6;
    nO2 = rho(4)*A/M(4)*1e6;
    nO = rho(5)*A/M(5)*1e6;
    nH = rho(6)*A/M(6)*1e6;

    % TODO
    n.nAr = nAr;
    n.nH = nH;
    n.nHe = nHe;
    n.nN2 = nN2;
    n.nO = nO;
    n.nO2 = nO2;

    % -----
    % Temps TODO
    % ------

    % stores temperature at altitude as "Th" [K]
    Th = T;

    % clears "T" variable so it can be redefined as a struct
    clear T;

    % temperatures [K]
    T.T = Th;
    T.T_inf = T_inf;

    % -------------------------------
    % Total atmospheric mass density.
    % -------------------------------

    % total atmospheric mass density [TODO]
    rho = sum(rho)*1e3;

end