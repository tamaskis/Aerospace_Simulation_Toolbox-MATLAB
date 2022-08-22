%==========================================================================
%
% harris_priester_limits  Modified Harris-Priester model for atmospheric
% mass density with manually specified limits.
%
%   rho = harris_priester_limits(r_eci,r_ecef,r_sun_eci,h1,rho1_min,...
%       rho1_max,h2,rho2_min,rho2_max)
%
% See also exponential, jacchia_bowman_2008, jacchia_roberts, nrlmsise00, 
% nrlmsise00_matlab.
%
% Author: Tamas Kis
% Last Update: 2022-04-14
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_eci       - (3×1 double) satellite position resolved in ECI frame [m]
%   r_ecef      - (3×1 double) satellite position resolved in ECEF frame
%                 [m]
%   r_sun_eci   - (3×1 double) Sun position resolved in ECI frame [m]
%   h1          - (1×1 double) lower altitude [km]
%   rho1_min    - (1×1 double) minimum density at lower altitude [g/km^3]
%   rho1_max    - (1×1 double) maximum density at lower altitude [g/km^3]
%   h2          - (1×1 double) upper altitude [km]
%   rho2_min    - (1×1 double) minimum density at upper altitude [g/km^3]
%   rho2_max    - (1×1 double) maximum density at upper altitude [g/km^3]
%   
%
% -------
% OUTPUT:
% -------
%   rho  	    - (1×1 double) atmospheric mass density [kg/m^3]
%
%==========================================================================
function rho = harris_priester_limits(r_eci,r_ecef,r_sun_eci,h1,...
    rho1_min,rho1_max,h2,rho2_min,rho2_max)
    
	% geodetic altitude [m]
    [~,~,h] = ecef2geod(r_ecef);
    
    % convert geodetic altitude to km
    h = 0.001*h;
    
    % minimum and maximum densities [g/km^3]
    rho_min = rho1_min*(rho2_min/rho1_min)^((h1-h)/(h1-h2));
    rho_max = rho1_max*(rho2_max/rho1_max)^((h1-h)/(h1-h2));
    
    % satellite unit position vector resolved in ECI frame
    r_eci_unit = r_eci/norm(r_eci);
    
    % Sun's geocentric right ascension and declination [rad]
    [a_sun,d_sun] = r2ad(r_sun_eci);
    
    % lag angle of the diurnal bulge [rad]
    lag = 30*(pi/180);
    
    % direction of the diurnal bulge's apex, resolved in the ECI frame
    rb_eci_unit = [cos(d_sun)*cos(a_sun+lag);
                   cos(d_sun)*sin(a_sun+lag);
                   sin(d_sun)];
      
    % exponent for cosine variation term
    n = 2;
    
    % cosine variation term
    cosnpsi = (0.5+idot(r_eci_unit,rb_eci_unit)/2)^(n/2);
    
    % atmospheric mass density 
    rho = rho_min+(rho_max-rho_min)*cosnpsi;

    % convert density to kg/m^3
    rho = (1e-12)*rho;
    
end