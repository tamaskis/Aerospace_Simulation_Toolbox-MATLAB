%==========================================================================
%
% harris_priester  Modified Harris-Priester model for atmospheric mass 
% density.
%
%   rho = harris_priester(r_eci,r_ecef,r_sun_eci)
%
% See also exponential, jacchia_bowman_2008, jacchia_roberts, nrlmsise00, 
% nrlmsise00_matlab.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
% REFERENCES:
%   [1] Cappellari et al., "Mathematical Theory of the Goddard Trajectory 
%       Determination System", pp. 4-53 to 4-57 (pp. 173-177 in PDF)
%   [2] Harris and Priester, "Time-Dependent Structure of the Upper
%       Atmosphere"
%   [3] Montenbruck and Gill, "Satellite Orbits", 4th Ed., pp. 89-91
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
%
% -------
% OUTPUT:
% -------
%   rho  	    - (1×1 double) atmospheric mass density [kg/m^3]
%
%==========================================================================
function rho = harris_priester(r_eci,r_ecef,r_sun_eci)
    
    % geodetic altitude data [km]
    h_data = [100,(120:10:300),(320:20:800),(840:40:1000)];
    
    % antapex density data [g/km^3]
    rho_min_data = [4.974e+05, 2.490e+04, 8.377e+03, 3.899e+03,...
                    2.122e+03, 1.263e+03, 8.008e+02, 5.283e+02,...
                    3.617e+02, 2.557e+02, 1.839e+02, 1.341e+02,...
                    9.949e+01, 7.488e+01, 5.709e+01, 4.403e+01,...
                    3.430e+01, 2.697e+01, 2.139e+01, 1.708e+01,...
                    1.099e+01, 7.214e+00, 4.824e+00, 3.274e+00,...
                    2.249e+00, 1.558e+00, 1.091e+00, 7.701e-01,...
                    5.474e-01, 3.916e-01, 2.819e-01, 2.042e-01,...
                    1.488e-01, 1.092e-01, 8.070e-02, 6.012e-02,...
                    4.519e-02, 3.430e-02, 2.632e-02, 2.043e-02,...
                    1.607e-02, 1.281e-02, 1.036e-02, 8.496e-03,...
                    7.069e-03, 4.680e-03, 3.200e-03, 2.210e-03,...
                    1.560e-03, 1.150e-03];
        
    % apex density data [g/km^3]
    rho_max_data = [4.974e+05, 2.490e+04, 8.710e+03, 4.059e+03,...
                    2.215e+03, 1.344e+03, 8.758e+02, 6.010e+02,...
                    4.297e+02, 3.162e+02, 2.396e+02, 1.853e+02,...
                    1.455e+02, 1.157e+02, 9.308e+01, 7.555e+01,...
                    6.182e+01, 5.095e+01, 4.226e+01, 3.526e+01,...
                    2.511e+01, 1.819e+01, 1.337e+01, 9.955e+00,...
                    7.492e+00, 5.684e+00, 4.355e+00, 3.362e+00,...
                    2.612e+00, 2.042e+00, 1.605e+00, 1.267e+00,...
                    1.005e+00, 7.997e-01, 6.390e-01, 5.123e-01,...
                    4.121e-01, 3.325e-01, 2.691e-01, 2.185e-01,...
                    1.779e-01, 1.452e-01, 1.190e-01, 9.776e-02,...
                    8.059e-02, 5.741e-02, 4.210e-02, 3.130e-02,...
                    2.360e-02, 1.810e-02];
        
	% geodetic altitude [m]
    [~,~,h] = ecef2geod(r_ecef);
    
    % convert geodetic altitude to km
    h = 0.001*h;
    
    % determine index of lower bound of interval containing h
    i = interval_search(h_data,h,false);
    
    % minimum and maximum densities [g/km^3]
    rho_min = rho_min_data(i)*(rho_min_data(i+1)/rho_min_data(i))^...
        ((h_data(i)-h)/(h_data(i)-h_data(i+1)));
    rho_max = rho_max_data(i)*(rho_max_data(i+1)/rho_max_data(i))^...
        ((h_data(i)-h)/(h_data(i)-h_data(i+1)));
    
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