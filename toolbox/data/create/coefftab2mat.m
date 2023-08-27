%==========================================================================
%
% process_gravity_data  Process a gravity data file.
%
%   [C_norm,S_norm] = process_gravity_data(path,N,r_start,r_miss,n_col,...
%       m_col,C_col,S_col)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-06-26
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
%   path    - (char array) relative or absolute file path to gravity data
%             file
%   N       - (1×1 double) maximum degree/order to include
%   r_start - (1×1 double) row index where coefficient data starts
%   r_miss  - (1×1 double) number of missing rows from beginning of
%             coefficient table
%   n_col   - (1×1 double) column index for degree data
%   m_col   - (1×1 double) column index for order data
%   C_col   - (1×1 double) column index for normalized C data
%   S_col   - (1×1 double) column index for normalized S data
%
% -------
% OUTPUT:
% -------
%   C_norm  - ((N+1)×(N+1) double) normalized gravitational coefficients
%   S_norm  - ((N+1)×(N+1) double) normalized gravitational coefficients
%
%==========================================================================
function [C_norm,S_norm] = coefftab2mat(T,N)
    
    % ensures first two columns are integers
    T(:,1:2) = round(T(:,1:2));
    
    % preallocates matrices to store normalized C and S coefficients
    C_norm = zeros(N+1,N+1);
    S_norm = zeros(N+1,N+1);
    
    % coefficient table length
    L = size(T,1);
    
    % populates coefficient matrices
    for i = 1:L
        
        % degree and order
        n = T(i,1);
        m = T(i,2);
        
        % terminates if maximum degree/order has been reached
        if (n > N)
            break
        end
        
        % stores the normalized gravitational coefficients
        C_norm(n+1,m+1) = T(i,3);
        S_norm(n+1,m+1) = T(i,4);
        
    end
    
end