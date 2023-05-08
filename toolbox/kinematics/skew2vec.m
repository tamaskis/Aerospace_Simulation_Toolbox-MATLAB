%==========================================================================
%
% skew2vec  onverts a skew-symmetric matrix representing a cross product to
% a vector
%
%   a = skew2vec(ax)
%
% See also vec2skew.
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
%   ax      - (3×3 double) skew-symmetrix matrix where a × b = aˣb
%
% -------
% OUTPUT:
% -------
%   a       - (3×1 double) vector
%
%==========================================================================
function a = skew2vec(ax)
    a = [ax(3,2);
         ax(1,3);
         ax(2,1)];
end