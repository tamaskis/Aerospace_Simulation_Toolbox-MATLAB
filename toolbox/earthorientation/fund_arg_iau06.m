%==========================================================================
%
% fund_arg_iau06  Fundamental arguments of nutation theory (IAU2006/2000, 
% CIO based).
%
%   F = fund_arg_iau06(T_TT)
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] IERS Technical Note No. 36 (pp. 67-68)
%       https://www.iers.org/SharedDocs/Publikationen/EN/IERS/Publications/tn/TechnNote36/tn36.pdf?__blob=publicationFile&v=1
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.
%       (pp. 210-211)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   T_TT    - (1×1 double) terrestrial time [Julian centuries]
%
% -------
% OUTPUT:
% -------
%   F       - (14×1 double) fundamental arguments for nutation theory [rad]
%
%==========================================================================
function F = fund_arg_iau06(T_TT)
    
    % preallocate F
    F = zeros(14,1);
    
    % Delaunay variables [deg]
    F(1) = 134.96340251+(1717915923.2178*T_TT+31.8792*T_TT^2+0.051635*...
        T_TT^3-0.00024470*T_TT^4)/3600;
    F(2) = 357.52910918+(129596581.0481*T_TT-0.5532*T_TT^2-0.000136*...
        T_TT^3-0.00001149*T_TT^4)/3600;
    F(3) = 93.27209062+(1739527262.8478*T_TT-12.7512*T_TT^2+0.001037*...
        T_TT^3+0.00000417*T_TT^4)/3600;
    F(4) = 297.85019547+(1602961601.2090*T_TT-6.3706*T_TT^2+0.006593*...
        T_TT^3-0.00003169*T_TT^4)/3600;
    F(5) = 125.04455501+(-6962890.5431*T_TT+7.4722*T_TT^2+0.007702*...
        T_TT^3-0.00005939*T_TT^4)/3600;
    
    % convert Delaunay variables to radians
    for i = 1:5
        F(i) = deg2rad(F(i));
    end
    
    % mean heliocentric longitudes of the planets [rad]
    F(6) = 4.402608842+2608.7903141574*T_TT;
    F(7) = 3.176146697+1021.3285546211*T_TT;
    F(8) = 1.753470314+628.3075849991*T_TT;
    F(9) = 6.203480913+334.0612426700*T_TT;
    F(10) = 0.599546497+52.9690962641*T_TT;
    F(11) = 0.874016757+21.3299104960*T_TT;
    F(12) = 5.481293872+7.4781598567*T_TT;
    F(13) = 5.311886287+3.8133035638*T_TT;
    
    % general precession in longitude [rad]
    F(14) =  0.024381750*T_TT+0.00000538691*T_TT^2;
    
    % wrap all parameters to the interval [0,2π)
    for i = 1:14
        F(i) = mod(F(i),2*pi);
    end
    
end