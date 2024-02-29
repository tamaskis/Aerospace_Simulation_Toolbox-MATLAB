%==========================================================================
%
% legendre_recursion  Recursive evaluation of coefficients related to the 
% Legendre polynomials required for evaluating the gravitational 
% acceleration.
%
%   [V,W] = legendre_recursion(r_pcpf,R,N)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-12-28
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TOOLBOX DOCUMENTATION:
% https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/files/Aerospace_Simulation.pdf
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_pcpf  - (3×1 double) position expressed in planet-centered
%             planet-fixed (PCPF) frame [m]
%   R       - (1×1 double) reference radius [m]
%   N       - (1×1 double) maximum degree
%   M       - (1×1 double) maximum order
%
% -------
% OUTPUT:
% -------
%   V       - (L₁×1 double) Legendre polynomial vector
%   W       - (L₁×1 double) Legendre polynomial vector
%
% -----
% NOTE:
% -----
%   • L₁ = (N+2)(N+3)/2
%
%==========================================================================
function [V,W] = legendre_recursion(r_pcpf,R,N,M)
    
    % magnitude of PCPF position squared [m²]
    r_sqr = idot(r_pcpf,r_pcpf);
    
    % distance from center of the Earth [m]
    r = sqrt(r_sqr);
    
    % auxiliary parameter
    a = R*R/r_sqr;
    
    % extract PCPF position components [m]
    rX = r_pcpf(1);
    rY = r_pcpf(2);
    rZ = r_pcpf(3);
    
    % normalized PCPF position components
    x = R*rX/r_sqr;
    y = R*rY/r_sqr;
    z = R*rZ/r_sqr;
    
    % gravitational model length corresponding to a maximum degree of N+1
    L1 = (N+2)*(N+3)/2;
    
    % initialize V and W
    V = zeros(L1,1);
    W = zeros(L1,1);
    
    % gravitional model index for (n,m) = (0,0)
    l1 = grav_model_index(0,0);
    
    % first zonal term (n = m = 0)
    V(l1) = R/r;
    
    % gravitional model index for (n,m) = (1,0)
    l2 = grav_model_index(1,0);
    
    % second zonal term (n = 1, m = 0)
    V(l2) = z*V(l1);
    
    % remaining zonal terms (2 ≤ n ≤ N+1, m = 0)
    for n = 2:(N+1)
        l1 = grav_model_index(n-2,0);
        l2 = grav_model_index(n-1,0);
        l3 = grav_model_index(n,0);
        V(l3) = (z*(2*n-1)*V(l2)-a*(n-1)*V(l1))/n;
    end
    
    % truncation corresponding to the specified maximum order
    m_end = min(N+1,M+1);
    
    % tesseral and sectorial terms
    for m = 1:m_end
        
        % gravitational model indices
        l1 = grav_model_index(m-1,m-1);
        l2 = grav_model_index(m,m);
        
        % sectorial terms (n = m)
        V(l2) = (2*m-1)*(x*V(l1)-y*W(l1));
        W(l2) = (2*m-1)*(x*W(l1)+y*V(l1));
        
        % tesseral terms (n > m)
        for n = (m+1):(N+1)
            
            % gravitational model indices
            l3 = grav_model_index(n-2,m);
            l4 = grav_model_index(n-1,m);
            l5 = grav_model_index(n,m);
            
            % coefficients
            if (n > m+1)
                V(l5) = (z*(2*n-1)*V(l4)-a*(n+m-1)*V(l3))/(n-m);
                W(l5) = (z*(2*n-1)*W(l4)-a*(n+m-1)*W(l3))/(n-m);
            else
                V(l5) = (z*(2*n-1)*V(l4))/(n-m);
                W(l5) = (z*(2*n-1)*W(l4))/(n-m);
            end
            
        end
        
    end
    
end