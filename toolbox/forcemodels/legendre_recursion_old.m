%==========================================================================
%
% legendre_recursion  Recursive evaluation of coefficients related to the 
% Legendre polynomials required for evaluating the gravitational 
% acceleration.
%
%   [V,W] = legendre_recursion(r_ecef,R,N)
%
% Author: Tamas Kis
% Last Update: 2022-02-28
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits" (pp. 66-68, 246)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef  - (3×1 double) position resolved in ECEF frame [m]
%   R       - (1×1 double) Earth mean equatorial radius [m]
%   N       - (1×1 double) maximum order/degree of gravity model
%
% -------
% OUTPUT:
% -------
%   V       - (1×1 function_handle) function to be used as "V(n,m)" to
%             return Legendre coefficient of degree n and order m
%   W       - (1×1 function_handle) function to be used as "W(n,m)" to
%             return Legendre coefficient of degree n and order m
%
%==========================================================================
function [V,W] = legendre_recursion_old(r_ecef,R,N)
    
    % magnitude of ECEF position squared [m^2]
    r_sqr = idot(r_ecef,r_ecef);

    % distance from center of the Earth [m]
    r = sqrt(r_sqr);
    
    % auxiliary parameter
    a = R*R/r_sqr;
    
    % extract ECEF position components [m]
    rX = r_ecef(1);
    rY = r_ecef(2);
    rZ = r_ecef(3);

    % "normalized" ECEF position components
    x = R*rX/r_sqr;
    y = R*rY/r_sqr;
    z = R*rZ/r_sqr;

    % initialize V and W
    V = zeros(N+3,N+3);
    W = zeros(N+3,N+3);

    % first zonal term (n = m = 0)
    V(1,1) = R/r;
    
    % second zonal terms (n = 1, m = 0)
    V(2,1) = z*V(1,1);

    % remaining zonal terms (2 ≤ n ≤ N+1, m = 0)
    for n = 2:(N+2)

        % degree (n) for indexing
        ni = n+1;
        
        % coefficients
        V(ni,1) = (z*(2*n-1)*V(ni-1,1)-a*(n-1)*V(ni-2,1))/n;

    end

    % tesseral and sectorial terms
    for m = 1:(N+2)
        
        % order (m) for indexing
        mi = m+1;
        
        % sectorial terms (n = m)
        V(mi,mi) = (2*m-1)*(x*V(mi-1,mi-1)-y*W(mi-1,mi-1));
        W(mi,mi) = (2*m-1)*(x*W(mi-1,mi-1)+y*V(mi-1,mi-1));

        % tesseral terms (n > m)
        for n = (m+1):(N+2)

            % degree (n) for indexing
            ni = n+1;
            
            % coefficients
            V(ni,mi) = (z*(2*n-1)*V(ni-1,mi)-a*(n+m-1)*V(ni-2,mi))/(n-m);
            W(ni,mi) = (z*(2*n-1)*W(ni-1,mi)-a*(n+m-1)*W(ni-2,mi))/(n-m);

        end

    end

    % assign function handles to return coefficients of degree n + order m
    V = @(n,m) V(n+1,m+1);
    W = @(n,m) W(n+1,m+1);

end