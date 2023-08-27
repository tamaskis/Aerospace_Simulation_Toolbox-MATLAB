%==========================================================================
%
% gravity  Gravitational acceleration.
%
%   g_ecef = gravity(r_ecef,C,S,N)
%
% See also gravity_coeffs, J2_ecef, J2_rtn, two_body.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits" (p. 68)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef  - (3×1 double) position resolved in ECEF frame [m]
%   C       - (1×1 function_handle) "C(n,m)" returns gravitational 
%             coefficient of degree n and order m
%   S       - (1×1 function_handle) "S(n,m)" returns gravitational 
%             coefficient of degree n and order m
%   N       - (1×1 double) maximum degree/order of gravity model to use
%
% -------
% OUTPUT:
% -------
%   g_ecef  - (3×1 double) inertial acceleration due to gravity resolved in
%             ECEF frame [m/s^2]
%
%==========================================================================
function g_ecef = gravity(r_ecef,C,S,N)
    
    % Earth parameters
    mu = MU_EARTH;  % gravitational parameter [m^3/s^2]
    R = R_EARTH;    % mean equatorial radius [m]
    
    % recursively compute the Legendre coefficients
    [V,W] = legendre_recursion(r_ecef,R,N);
    
    % auxiliary parameter [m/s^2]
    a = mu/(2*R^2);
    
    % initializes the accelerations [m/s^2]
    gX = 0;
    gY = 0;
    gZ = 0;
    
    % calculates the accelerations
    for n = 0:N
        
        % zonal potential coefficient
        Cn0 = C(n,0);
        
        % zonal terms (m = 0)
        gX = gX-2*a*Cn0*V(n+1,1);
        gY = gY-2*a*Cn0*W(n+1,1);
        gZ = gZ-2*a*(n+1)*Cn0*V(n+1,0);
        
        % sectorial (m = n) and tesseral (n > m) terms
        for m = 1:n
            
            % auxiliary parameter
            b = (m-n-2)*(m-n-1);
            
            % gravitational coefficients
            Cnm = C(n,m);
            Snm = S(n,m);
            
            % accelerations due to gravity [m/s^2]
            gX = gX-a*(Cnm*V(n+1,m+1)+Snm*W(n+1,m+1))+a*b*(Cnm*V(n+1,m-...
                1)+Snm*W(n+1,m-1));
            gY = gY+a*(Snm*V(n+1,m+1)-Cnm*W(n+1,m+1))+a*b*(Snm*V(n+1,m-...
                1)-Cnm*W(n+1,m-1));
            gZ = gZ-2*a*(n-m+1)*(C(n,m)*V(n+1,m)+S(n,m)*W(n+1,m));
            
        end
        
    end
    
    % gravitational acceleration resolved in ECEF frame [m/s^2]
    g_ecef = [gX;
              gY;
              gZ];
    
end