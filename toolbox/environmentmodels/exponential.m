%==========================================================================
%
% exponential  Exponential model for atmospheric mass density.
%
%   rho = exponential(r_ecef)
%
% See also harris_priester, jacchia_bowman_2008, jacchia_roberts,
% nrlmsise00, nrlmsise00_matlab.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 565-567)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef  - (3×1 double) position resolved in ECEF frame [m]
%
% -------
% OUTPUT:
% -------
%   rho     - (1×1 double) atmospheric mass density [kg/m^3]
%
%==========================================================================
function rho = exponential(r_ecef)
    
    % base altitude data [km]
    ho = [0,25,(30:10:150),180,(200:50:500),(500:100:1000)];
    
    % nominal density data [kg/m^3]
    rhoo = [1.255e+00, 3.899e-02, 1.774e-02, 3.972e-03, 1.057e-3,...
            3.206e-04, 8.770e-05, 1.905e-05, 3.396e-06, 5.297e-07,...
            9.661e-08, 2.438e-08, 8.484e-09, 3.845e-09, 2.070e-09,...
            5.464e-10, 2.789e-10, 7.248e-11, 2.418e-11, 9.518e-12,...
            3.725e-12, 1.585e-12, 6.967e-13, 1.454e-13, 3.614e-14,...
            1.170e-14, 5.245e-15, 3.019e-15];
        
    % scale height data [km]
    H = [ 7.249,  6.349,  6.682,  7.554,  8.382,  7.714,  6.549,  5.799,...
          5.382,  5.877,  7.263,  9.473, 12.636, 16.149, 22.523, 29.740,...
         37.105, 45.546, 53.628, 53.298, 58.515, 60.828, 63.822, 71.835,...
         88.667, 124.64, 181.05, 268.00];
        
	% geodetic altitude [m]
    [~,~,h] = ecef2geod(r_ecef);
    
    % convert geodetic altitude to km
    h = 0.001*h;
    
    % determine index of lower bound of interval containing h
    i = interval_search(ho,h,false);
    
    % atmospheric mass density [kg/m^3]
    rho = rhoo(i)*exp((h-ho(i))/H(i));
    
end