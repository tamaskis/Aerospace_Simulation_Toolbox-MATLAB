%==========================================================================
%
% denormalize_coeffs  Denormalize gravitational model coefficients.
%
%   [C,S] = denormalize_coeffs(C_norm,S_norm)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-12-25
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
%   C_norm  - (L×1 double) normalized coefficient vector
%   S_norm  - (L×1 double) normalized coefficient vector
%
% -------
% OUTPUT:
% -------
%   C       - (L×1 double) unnormalized coefficient vector
%   S       - (L×1 double) unnormalized coefficient vector
%
% -----
% NOTE:
% -----
%   • L = (N+1)(N+2)/2 where N is the maximum degree.
%
%==========================================================================
function [C,S] = denormalize_coeffs(C_norm,S_norm)
    
    % determine maximum degree/order
    N = size(C_norm,1)-1;
    
    % preallocate matrices for un-normalized coefficients
    C_unnorm = zeros(N+1,N+1);
    S_unnorm = zeros(N+1,N+1);
    
    % loop through all nonzero elements
    for n = 0:N
        for m = 0:n
            
            % scaling coefficient
            Pi = sqrt(factorial(n+m)/((2-eq(0,m))*(2*n+1)*factorial(n-m)));
            
            % elements to access (shift to account for 1-based indexing)
            i = n+1;
            j = m+1;
            
            % denormalize coefficients
            C_unnorm(i,j) = C_norm(i,j)/Pi;
            S_unnorm(i,j) = S_norm(i,j)/Pi;
            
        end
    end
    
    % assign function handles to return coefficients of degree n + order m
    C = @(n,m) C_unnorm(n+1,m+1);
    S = @(n,m) S_unnorm(n+1,m+1);
    
end