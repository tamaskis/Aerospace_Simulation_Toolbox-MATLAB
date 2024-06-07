%==========================================================================
%
% grav_model_length  Gravitational model length for a given maximum degree.
%
%   l = grav_model_index(N)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2024-01-02
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
%   L       - (1×1 double) gravitational model length
%
%==========================================================================
function L = grav_model_length(N)
    L = (N+1)*(N+2)/2;
end