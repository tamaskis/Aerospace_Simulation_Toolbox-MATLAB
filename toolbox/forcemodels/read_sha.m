%==========================================================================
%
% read_sha  Reads Spherical Harmonic ASCII files.
%
%   [mu,R,tide_system,N_max,C,S,C_norm,S_norm] = read_sha(table_path,...
%       label_path)
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
%   table_path  - (char array) relative or absolute file path to table file
%                 (usually with a .sha or .tab file extension)
%   label_path  - (char array) relative or absolute file path to label file
%                 (usually with a .lbl file extension)
%
% -------
% OUTPUT:
% -------
%   TODO
%
%==========================================================================
function [mu,R,tide_system,N_max,C,S,C_norm,S_norm] = read_sha(...
    table_path,label_path)
    
    % -----------------
    % Reads label file.
    % -----------------

    % reads label file into a cell array
    lines = readlines(label_path);
    
end