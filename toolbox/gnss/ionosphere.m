%==========================================================================
%
% ionosphere  Klobuchar model for the ionospheric path delay.
%
%   I = ionosphere(r_rcv_ecef,r_sat_ecef,K_alpha,K_beta,t)
%
% Author: Tamas Kis
% Last Update: 2022-03-22
%
% REFERENCES:
%   [1] Klobuchar, "Ionospheric Time-Delay Algorithm for Single-Frequency 
%       GPS Users"
%   [2] https://gssc.esa.int/navipedia/index.php/Klobuchar_Ionospheric_Model
%   [3] IS-GPS-200M, https://www.gps.gov/technical/icwg/IS-GPS-200M.pdf 
%       (pp. 130-134)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_rcv_ecef  - (3×1 double) receiver position resolved in ECEF frame [m]
%   r_sat_ecef  - (3×1 double) GNSS satellite position resolved in ECEF 
%                 frame [m]
%   alpha       - (1×4 double) Klobuchar amplitude coefficients
%   beta        - (1×4 double) Klobuchar period coefficients
%   t           - (1×1 double) GPS time (seconds of week) [s]
%
% -------
% OUTPUT:
% -------
%   I       - (1×1 double) ionospheric path delay [m]
%
%==========================================================================
function I = ionosphere(r_rcv_ecef,r_sat_ecef,alpha,beta,t)
    %I = 0; return;
    % speed of light [m/s]
    c = C_LIGHT;

    % extract Klobuchar amplitude coefficients from "alpha"
    alpha0 = alpha(1);
    alpha1 = alpha(2);
    alpha2 = alpha(3);
    alpha3 = alpha(4);

    % extract Klobuchar period coefficients from "beta"
    beta0 = beta(1);
    beta1 = beta(2);
    beta2 = beta(3);
    beta3 = beta(4);
    
    % position of GNSS satellite relative to receiver in receiver's ENU
    % frame [m]
    r_rel_enu = ecef2enu(r_sat_ecef,r_rcv_ecef);
    
    % azimuth and elevation of GNSS satellite with respect to receiver [°]
    [Az,El] = enu2aer(r_rel_enu);
    
    % receiver geodetic latitude and longitude [°]
    [phi,lambda] = ecef2geod(r_rcv_ecef);
    
    % converts all angles calculated thus far to radians
    Az = deg2rad(Az);
    El = deg2rad(El);
    phi = deg2rad(phi);
    lambda = deg2rad(lambda);
    
    % Earth-centered angle [rad]
    psi = pi*(0.0137/((El/pi)+0.11)-0.022);

    % latitude of the ionospheric pierce point (IPP) [rad]
    phi_ipp = phi+psi*cos(Az);
    if (phi_ipp > 0.416*pi)
        phi_ipp = 0.416*pi;
    elseif (phi_ipp < -0.416*pi)
        phi_ipp = -0.416*pi;
    end
    
    % longitude of the IPP [rad]
    lambda_ipp = lambda+((psi*sin(Az))/cos(phi_ipp));

    % geomagnetic latitude of the IPP [rad]
    phi_m = phi_ipp+0.064*pi*cos(lambda_ipp-1.617*pi);

    % convert geomagnetic latitude of the IPP to semicircles
    phi_m = phi_m/pi;

    % local time at the IPP [s]
    t_ipp = (43200*lambda_ipp/pi)+t;

    % wrap tᵢ to the interval [0,86400)
    t_ipp = imod(t_ipp,86400);
    
    % amplitude of the ionospheric delay [s]
    A = (alpha0)+(alpha1*phi_m)+(alpha2*phi_m^2)+(alpha3*phi_m^3);
    if A < 0
        A = 0;
    end

    % period of the ionospheric delay [s]
    P = (beta0)+(beta1*phi_m)+(beta2*phi_m^2)+(beta3*phi_m^3);
    if P < 72000
        P = 72000;
    end

    % phase of the ionospheric delay [rad]
    X = (2*pi*(t_ipp-50400))/P;
    
    % obliquity factor
    F = 1+16*(0.53-(El/pi))^3;

    % phase factor
    G = 1-(X^2/2)+(X^4/24);
    
    % ionospheric delay [m]
    if (iabs(X) <= 1.57)
        I = ((5e-9)+G*A)*c*F;
    else
        I = (5e-9)*c*F;
    end
    
end