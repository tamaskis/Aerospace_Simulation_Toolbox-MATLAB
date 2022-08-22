%==========================================================================
%
% nrlmsise00_matlab  NRLMSISE-00 atmospheric model using the MATLAB
% Aerospace Toolbox's "atmosnrlmsise00" function.
%
%   [rho,n,T] = nrlmsise00_matlab(r_ecef,MJD_UT1,F107_avg,F107,ap_array)
%
% See also exponential, harris_priester, jacchia_bowman_2008, 
% jacchia_roberts, nrlmsise00, space_weather.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
% REFERENCES:
%   [1] Picone et al., "NRLMSISE-00 empirical model of the atmosphere: 
%       Statistical comparisons and scientific issues"
%   [2] https://www.mathworks.com/help/aerotbx/ug/atmosnrlmsise00.html
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef      - (3×1 double) position resolved in ECEF frame [m]
%   MJD_UT1     - (1×1 double) UT1 (Universal Time 1) [MJD]
%   F107_avg    - (1×1 double) centered 81-day average of F10.7 (1-day lag)
%                 [SFU]
%   F107        - (1×1 double) 10.7 cm solar flux (1-day lag) [SFU]
%   ap_array    - (1×1 double) array of planetary amplitude values [γ]
%                   1. daily planetary amplitude [γ]
%                   2. planetary amplitude (current time) [γ]
%                   3. planetary amplitude (3 hours before) [γ]
%                   4. planetary amplitude (6 hours before) [γ]
%                   5. planetary amplitude (9 hours before) [γ]
%                   6. planetary amplitude (avg. of 12-33 hours before) [γ]
%                   7. planetary amplitude (avg. of 36-57 hours before) [γ]
%
% -------
% OUTPUT:
% -------
%   rho         - (1×1 double) atmospheric mass density [kg/m^3]
%   n           - (1×1 struct) number densities [m^-3]
%       • nAr   - (1×1 double) atomic argon number density [m^-3]
%       • nH    - (1×1 double) atomic hydrogen number density [m^-3]
%       • nHe   - (1×1 double) atomic helium number density [m^-3]
%       • nN2   - (1×1 double) diatomic nitrogen number density [m^-3]
%       • nO    - (1×1 double) atomic oxygen number density [m^-3]
%       • nO2   - (1×1 double) diatomic oxygen number density [m^-3]
%   T           - (1×1 struct) temperatures [K]
%       • T_h   - (1×1 double) temperature at altitude [K]
%       • T_inf - (1×1 double) exospheric temperature [K]
%
%==========================================================================
function [rho,n,T] = nrlmsise00_matlab(r_ecef,MJD_UT1,F107_avg,F107,...
    ap_array)
    
    % ----------------------------------------------------
    % Calculates inputs for NRLMSISE-00 atmospheric model.
    % ----------------------------------------------------

    % Gregorian date of UT1 [y,mo,d,h,m,s]
    cal_UT1 = mjd2cal(MJD_UT1);

    % year [y]
    YYYY = MJD_UT1(1);
    
    % day of year [d]
    DOY = cal2doy(cal_UT1);

    % seconds of day [s]
    ss = cal_UT1(4)*3600+cal_UT1(5)*60+cal_UT1(6);

    % geodetic latitude [rad], longitude [rad], and altitude [m]
    [lat,lon,h] = ecef2geod(r_ecef);

    % (approximate) local apparent solar time [h]
    LAST = ss/3600+lon/15;

    % ------------------------------------------------------
    % Computation of atmospheric densities and temperatures.
    % ------------------------------------------------------

    % computation using NRLMSISE-00 model
    [T,rho] = atmosnrlmsise00(h,lat,lon,YYYY,DOY,ss,LAST,F107_avg,F107,...
        ap_array);

    % number densities [m^-3]
    nHe = rho(1);
    nO = rho(2);
    nN2 = rho(3);
    nO2 = rho(4);
    nAr = rho(5);
    nH = rho(7);

    % total mass density [kg/m^3]
    rho = rho(6);

    % exospheric temperature [K]
    T_inf = T(1);

    % temperature at altitude [K]
    T_h = T(2);

    % ----------------
    % Parsing outputs.
    % ----------------

    % clears "T" variable so it can be redefined as a struct
    clear T;
    
    % temperatures [K]
    T.T_h = T_h;
    T.T_inf = T_inf;

    % number densities [m^-3]
    n.nAr = nAr;
    n.nH = nH;
    n.nHe = nHe;
    n.nN2 = nN2;
    n.nO = nO;
    n.nO2 = nO2;
    
end