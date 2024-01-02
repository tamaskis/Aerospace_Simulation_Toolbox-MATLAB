%==========================================================================
%
% normalize_coeffs  Normalize gravitational model coefficients.
%
%   [C_norm,S_norm] = normalize_coeffs(C,S)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2024-01-01
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
%   C       - (L×1 double) unnormalized coefficient vector
%   S       - (L×1 double) unnormalized coefficient vector
%
% -------
% OUTPUT:
% -------
%   C_norm  - (L×1 double) normalized coefficient vector
%   S_norm  - (L×1 double) normalized coefficient vector
%
% -----
% NOTE:
% -----
%   • L = (N+1)(N+2)/2 where N is the maximum degree.
%
%==========================================================================
function [C_norm,S_norm] = normalize_coeffs(C,S)
    
    % gravitational model length
    L = length(C);
    
    % maximum degree
    N = (-3+sqrt(8*L+1))/2;
    
    % Kaula normalization vector
    N_kaula = kaula_norm_vector(N);
    
    % preallocates unnormalized coefficient vectors
    C_norm = zeros(L,1);
    S_norm = zeros(L,1);
    
    % loop through all nonzero elements
    for n = 0:N
        for m = 0:n
            
            % gravitational model index
            l = grav_model_index(n,m);
            
            % denormalize the normalized gravitational coefficients
            C_norm(l) = N_kaula(l)/C(l);
            S_norm(l) = N_kaula(l)/S(l);
            
        end
    end
    
end