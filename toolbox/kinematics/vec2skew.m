%==========================================================================
%
% vec2skew  Converts a vector to a skew-symmetric matrix representing a 
% cross product.
%
%   ax = vec2skew(a)
%
% See also skew2vec.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-05-07
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
%   ax      - (3×3 double) skew-symmetrix matrix where a × b = aˣb
%
%==========================================================================
function ax = vec2skew(a)
    ax = [ 0     -a(3)   a(2);
           a(3)   0     -a(1);
          -a(2)   a(1)   0];
end