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
%   V       - (L₃×1 double) Legendre coefficient vector
%   W       - (L₃×1 double) Legendre coefficient vector
%
% -----
% NOTE:
% -----
%   --> TODO: L3
%   --> TODO: max order
%
%==========================================================================
function [V,W] = legendre_recursion(r_pcpf,R,N)
    
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
    
    % TODO
    L3 = (N+4)*(N+5)/2;
    
    % initialize V and W
    V = zeros(L3,1);
    W = zeros(L3,1);
    
    % gravitional model index for (n,m) = (0,0)
    l1 = grav_model_index(0,0);
    
    % first zonal term (n = m = 0)
    V(l1) = R/r;
    
    % second zonal terms (n = 1, m = 0)
    V(grav_model_index(1,0)) = z*V(l1);
    
    % remaining zonal terms (2 ≤ n ≤ N+1, m = 0)
    for n = 2:(N+2)
        V(grav_model_index(n,0)) = (z*(2*n-1)*V(grav_model_index(n-1,...
            0))-a*(n-1)*V(grav_model_index(n-2,0)))/n;
    end

    % TODO truncate order
    m_end = min(N+2,M);
    
    % tesseral and sectorial terms
    for m = 1:m_end
        
        % gravitational model indices
        l2 = grav_model_index(m-1,m-1);
        l3 = grav_model_index(m,m);
        
        % sectorial terms (n = m)
        V(l3) = (2*m-1)*(x*V(l2)-y*W(l2));
        W(l3) = (2*m-1)*(x*W(l2)+y*V(l2));
        
        % tesseral terms (n > m)
        for n = (m+1):m_end
            
            % gravitational model indices
            l4 = grav_model_index(n-1,m);
            l5 = grav_model_index(n-2,m);
            l6 = grav_model_index(n,m);
            
            % coefficients
            if (n > m+1)
                V(l6) = (z*(2*n-1)*V(l4)-a*(n+m-1)*V(l5))/(n-m);
                W(l6) = (z*(2*n-1)*W(l4)-a*(n+m-1)*W(l5))/(n-m);
            else
                V(l6) = (z*(2*n-1)*V(l4))/(n-m);
                W(l6) = (z*(2*n-1)*W(l4))/(n-m);
            end
            
        end
        
    end
    
end