%==========================================================================
%
% cross_product_matrix  Skew-symmetric matrix representing a cross product.
%
%   ax = cross_product_matrix(a)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-02-23
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
%   a       - (3×1 double) vector
%
% -------
% OUTPUT:
% -------
%   ax      - (3×3 double) skew-symmetrix matrix where a × b = [a]ₓb
%
%==========================================================================
function ax = cross_product_matrix(a)
    ax = [ 0     -a(3)   a(2);
           a(3)   0     -a(1);
          -a(2)   a(1)   0];
end