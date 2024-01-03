%==========================================================================
%
% load_GEM10  Loads GEM10 data.
%
%   GEM10 = load_GEM10
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
% -------
% OUTPUT:
% -------
%   GEM10  - (1×1 struct) GEM10 data
%       • mu          - (1×1 double) standard gravitational parameter
%                       [m³/s²]
%       • R           - (1×1 double) reference radius [m]
%       • tide_system - (char array) tide system ('tide-free' or
%                       'zero-tide')
%       • N_max       - (1×1 double) maximum possible degree
%       • C           - (L×1 double) unnormalized coefficient vector
%       • S           - (L×1 double) unnormalized coefficient vector
%       • C_norm      - (L×1 double) normalized coefficient vector
%       • S_norm      - (L×1 double) normalized coefficient vector
%
%==========================================================================
function GEM10 = load_GEM10
    GEM10 = load_numeric_data('GEM10.mat');
end