%==========================================================================
%
% klobuchar_coeffs  Simulation of Klobuchar coefficients for calculating
% the ionospheric path delay.
%
%   [alpha,beta] = klobuchar_coeffs(MJD_GPS)
%
% Author: Tamas Kis
% Last Update: 2022-03-22
%
% REFERENCES:
%   [1] Lee et al., "Generation of Klobuchar Coefficients for Ionospheric 
%       Error Simulation"
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_GPS - (1×1 double) GPS time [MJD]
%
% -------
% OUTPUT:
% -------
%   alpha   - (4×1 double) Klobuchar amplitude coefficients
%   beta    - (4×1 double) Klobuchar period coefficients
%
%==========================================================================
function [alpha,beta] = klobuchar_coeffs(MJD_GPS)
    
    % Gregorian (calendar) date [y,mo,d,h,m,s]
    cal = mjd2cal(MJD_GPS);

    % unpacks calendar date
    YYYY = cal(1);
    MM = cal(2);
    DD = cal(3);
    hh = cal(4);
    mm = cal(5);
    ss = cal(6);

    % converts hours, minutes, and seconds into fraction of day
    f_DD = hms2f(hh,mm,ss);

    % GPS time in years (ignore leap years --> extra accuracy not needed)
    t = YYYY+(MM/12)+((DD+f_DD)/365);

    % preallocates arrays
    alpha = zeros(4,1);
    beta = zeros(4,1);

    % Klobuchar amplitude coefficients
    alpha(1) = (1.02e-10*t)-(1.965e-7)-(2.5e-9)*cos((6.13*t/0.5)+602);
    alpha(2) = (1.7215e-8)*cos(6.2323*t+105.4373);
    alpha(3) = -5.96e-8;
    alpha(4) = (1.2107e-7)*cos(6.2299*t+107.0307);

    % Klobuchar period coefficients
    beta(1) = (490.17*t)-(8.9656e5)+(0.6523e4)*cos(6.3363*t-106.8294);
    beta(2) = (9.1067e4)*cos(6.226*t+130.6530);
    beta(3) = (3760.1*t)-(7.6904e6)-(0.6325e5)*cos(6.3761*t-186.8136);
    beta(4) = (0.5457e6)*cos(6.2248*t+117.5348);
    
end