%==========================================================================
%
% kaula_norm_vector  Kaula normalization vector up to degree and order N.
%
%   N_vec = kaula_norm_vector(N)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-12-27
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
%   N       - (1×1 double) maximum degree
%
% -------
% OUTPUT:
% -------
%   N_vec   - (L×1 double) Kaula normalization vector
%
% -----
% NOTE:
% -----
%   • L = (N+1)(N+2)/2
%   • This algorithm may fail for very high degrees (n) and orders (m).
%
%==========================================================================
function N_vec = kaula_norm_vector(N)
    
    % normalization factors up to degree and order 4
    T = [1,0,0,0,0;
         sqrt(3),sqrt(3),0,0,0;
         sqrt(5),sqrt(5/3),0.5*sqrt(5/3),0,0;
         sqrt(7),sqrt(7/6),0.5*sqrt(7/15),(1/6)*sqrt(0.7),0;
         3,3*sqrt(0.1),0.5*sqrt(0.2),0.5*sqrt(1/70),0.125*sqrt(1/35)];
    
    % gravitational model length
    L = (N+1)*(N+2)/2;
    
    % preallocates Kaula normalization vector
    N_vec = zeros(L,1);
    
    % populates Kaula normalization vector up to degree and order 4 using
    % precomputed values in T
    for n = 0:min(4,N)
        for m = 0:n
            l = grav_model_index(n,m);
            N_vec(l) = T(n+1,m+1);
        end
    end
    
    % computes normalization factors for m = 1 from degree 5 to degree N
    for n = 4:(N-1)
        
        % gravitational model index corresponding to (n,m) = (n,1)
        a = grav_model_index(n,1);
        
        % gravitational model index corresponding to (n,m) = (n+1,1)
        b = grav_model_index(n+1,1);
        
        % computes N(n+1,1)
        N_vec(b) = N_vec(a)*sqrt((n*(2*n+3))/((n+2)*(2*n+1)));
        
    end
    
    % computes normalization factors for m = 0 from degree 5 to degree N
    for n = 5:N
        
        % gravitational model index corresponding to (n,m) = (n,1)
        a = grav_model_index(n,1);
        
        % gravitational model index corresponding to (n,m) = (n,0)
        b = grav_model_index(n,0);
        
        % computes N(n+1,1)
        N_vec(b) = N_vec(a)*sqrt((n*(n+1))/2);
        
    end
    
    % computes normalization factors for m ≥ 2 from degree 5 to degree N
    for n = 5:N
        for m = 1:(n-1)
            
            % gravitational model index corresponding to (n,m) = (n,m)
            a = grav_model_index(n,m);
            
            % gravitational model index corresponding to (n,m) = (n,m+1)
            b = grav_model_index(n,m+1);
            
            % computes N(n,m)
            N_vec(b) = N_vec(a)/sqrt((n+m+1)*(n-m));
            
        end
    end
    
end