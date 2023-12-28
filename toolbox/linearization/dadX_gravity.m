%==========================================================================
%
% dadX_gravity  Partial derivatives of gravitational acceleration with
% respect to position and inertial velocity, resolved in the ECI frame.
%
%   [dadr_g,dadv_g] = dadX_gravity(r_ecef,C,S,N,R_ecef2eci)
%
% Author: Tamas Kis
% Last Update: 2022-03-01
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits" (pp. 244-247)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef      - (3×1 double) position resolved in ECEF frame [m]
%   C           - (1×1 function_handle) "C(n,m)" returns gravitational 
%                 coefficient of degree n and order m
%   S           - (1×1 function_handle) "S(n,m)" returns gravitational 
%                 coefficient of degree n and order m
%   N           - (1×1 double) maximum degree/order of gravity model to use
%   R_ecef2eci  - (3×3 double) rotation matrix (ECEF --> ECI)
%
% -------
% OUTPUT:
% -------
%   dadr_g  - (3×3 double) partial derivative of gravitational acceleration
%             w.r.t. position, resolved in ECI frame [1/s^2]
%   dadv_g  - (3×3 double) partial derivative of gravitational acceleration
%             w.r.t. inertial velocity, resolved in ECI frame [1/s]
%
%==========================================================================
function [dadr_g,dadv_g] = dadX_gravity(r_ecef,C,S,N,R_ecef2eci)
    
    % Earth parameters
    mu = MU_EARTH;  % gravitational parameter [m^3/s^2]
    R = R_EARTH;    % mean equatorial radius [m]
    
    % recursively compute the Legendre coefficients
    [V,W] = legendre_recursion(r_ecef,R,N);
    
    % auxiliary parameter independent of n and m [1/s^2]
    a = mu/R^3;
    
    % initializes the partial derivatives w.r.t. position [1/s^2]
    dgXdX = 0;
    dgXdY = 0;
    dgXdZ = 0;
    dgYdZ = 0;
    dgZdZ = 0;
    
    % calculates the partial derivatives w.r.t. position
    for n = 0:N
        
        % auxiliary parameters independent of m
        b = n+1;
        c = (n+1)*(n+2);
        d = n*(n+1);
        k = C(n,0);
        l = V(n+2,2);
        o = V(n+2,0);
        p = C(n,1);
        q = V(n+2,3);
        r = S(n,1);
        s = W(n+2,3);
        t = V(n+2,1);
        u = W(n+2,1);
        zeta = W(n+2,2);
        eta = n*(n+1)*(n+2);
        
        % zonal terms (m = 0) [1/s^2]
        dgXdX = dgXdX+((a*(k*l-c*k*o))/2);
        dgXdY = dgXdY+(a*k*zeta/2);
        dgXdZ = dgXdZ+(a*b*k*t);
        dgYdZ = dgYdZ+(a*b*k*u);
        dgZdZ = dgZdZ+(a*c*k*o);
        
        % m = 1 terms [1/s^2]
        if n > 0
            dgXdX = dgXdX+(a*(p*q+r*s-d*(3*p*t+r*u))/4);
            dgXdY = dgXdY+(a*(p*s-r*q-d*(p*u+r*t))/4);
            dgXdZ = dgXdZ+(a*(n*(p*l+r*zeta)-eta*p*o)/2);
            dgYdZ = dgYdZ+(a*(n*(p*zeta-r*l)-eta*r*o)/2);
            dgZdZ = dgZdZ+(a*d*(p*t+r*u));
        end
        
        % remaining sectorial (m = n) and tesseral (n > m) terms
        for m = 2:n
            
            % auxiliary parameters
            e = (n-m+1)/2;
            f = (m-n-2)*(m-n-1);
            g = factorial(n-m+4)/factorial(n-m);
            h = factorial(n-m+3)/(2*factorial(n-m));
            i = C(n,m);
            j = S(n,m);
            v = V(n+2,m+2);
            w = W(n+2,m+2);
            x = V(n+2,m);
            y = W(n+2,m);
            z = V(n+2,m-2);
            alpha = W(n+2,m-2);
            beta = V(n+2,m+1);
            gamma = W(n+2,m+1);
            delta = V(n+2,m-1);
            epsilon = W(n+2,m-1);
            
            % partial derivatives [1/s^2]
            dgXdX = dgXdX+(a*(i*v+j*w-2*f*(i*x+j*y)+g*(i*z+j*alpha))/4);
            dgXdY = dgXdY+(a*(i*w-j*v+g*(j*z-i*alpha))/4);
            dgXdZ = dgXdZ+(a*(e*(i*beta+j*gamma)-h*(i*delta+j*epsilon)));
            dgYdZ = dgYdZ+(a*(e*(i*gamma-j*beta)+h*(i*epsilon-j*delta)));
            dgZdZ = dgZdZ+(a*f*(i*x+j*y));
            
        end
        
    end
    
    % remaining partial derivatives with respect to position, resolved in
    % ECEF frame [1/s^2]
    dgYdX = dgXdY;
    dgYdY = -dgZdZ-dgXdX;
    dgZdX = dgXdZ;
    dgZdY = dgYdZ;
    
    % partial derivative of gravitational acceleration with respect to
    % position, resolved in ECEF frame [1/s^2]
    dadr_g_ecef = [dgXdX   dgXdY   dgXdZ;
                   dgYdX   dgYdY   dgYdZ;
                   dgZdX   dgZdY   dgZdZ];
    
    % partial derivative of gravitational acceleration with respect to
    % position, resolved in ECI frame [1/s^2]
    dadr_g = R_ecef2eci*dadr_g_ecef*(R_ecef2eci.');
    
    % partial derivative of gravitational acceleration with respect to
    % inertial velocity, resolved in ECEF frame [1/s^2]
    dadv_g = zeros(3,3);
    
end