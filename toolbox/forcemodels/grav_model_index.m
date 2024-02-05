%==========================================================================
%
% grav_model_index  Gravitational model index for a given degree and order.
%
%   l = grav_model_index(n,m)
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
%   n       - (1×1 double) degree
%   m       - (1×1 double) order
%
% -------
% OUTPUT:
% -------
%   l       - (1×1 double) gravitational model index
%
%==========================================================================
function l = grav_model_index(n,m)
    l = (n*(n+1)/2)+m+1;
end