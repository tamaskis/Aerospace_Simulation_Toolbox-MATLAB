%==========================================================================
%
% read_gfc  Reads a Gravity Field Coefficients (.gfc) file.
%
%   [mu,R,tide_system,N_max,C,S,C_norm,S_norm] = read_gfc(path)
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
%   path    - (char array) relative or absolute file path (including .gfc
%             extension)
%   N       - (OPTIONAL) (1×1 double) maximum degree
%
% -------
% OUTPUT:
% -------
%   TODO
%
%==========================================================================
function [mu,R,tide_system,N_max,C,S,C_norm,S_norm] = read_gfc(path,N)
    
    % reads gfc file into a cell array
    lines = readlines(path);
    
    % gets the line storing the standard gravitational parameter
    for i = 1:length(lines)
        if contains(lines{i},'earth_gravity_constant')
            idx = i;
            break;
        end
    end
    
    % extracts the standard gravitational parameter [TODO units]
    parts = strsplit(lines{idx});
    mu = str2double(parts{2});
    
    % gets the line storing the reference radius
    for i = 1:length(lines)
        if contains(lines{i},'radius')
            idx = i;
            break;
        end
    end
    
    % extracts the standard gravitational parameter [m]
    parts = strsplit(lines{idx});
    R = str2double(parts{2});
    
    % gets the line storing the maximum degree
    for i = 1:length(lines)
        if contains(lines{i},'max_degree')
            idx = i;
            break;
        end
    end
    
    % extracts the maximum degree
    parts = strsplit(lines{idx});
    N_max = str2double(parts{2});
    
    % gets the line storing the tide system
    idx = 0;
    for i = 1:length(lines)
        if contains(lines{i},'tide_system')
            idx = i;
            break;
        end
    end
    
    % extracts tide system
    if idx > 0
        parts = strsplit(lines{idx});
        tide_system = strrep(parts{2},'_','-');
    else
        tide_system = 'TODO default value';
    end
    
    % gets the line storing normalization info
    idx = 0;
    for i = 1:length(lines)
        if contains(lines{i},'norm')
            idx = i;
            break;
        end
    end
    
    % extracts normalization info
    if idx > 0
        parts = strsplit(lines{idx});
        normalized = strcmpi(parts{2},'fully_normalized');
    else
        normalized = false;
    end
    
    % gets the last line of the header
    for i = 1:length(lines)
        if contains(lines{i},'end_of_head')
            idx = i;
            break;
        end
    end
    
    % gravitation model length (i.e. truncates model) TODO
    if (nargin >= 2) && ~isempty(N)
        L = (N+1)*(N+2)/2;
    else
        L = (N_max+1)*(N_max+2)/2;
    end
    
    % preallocates arrays
    C0 = zeros(L,1);
    S0 = zeros(L,1);
    
    % iterates over lines
    for i = (idx+1):(idx+L)
        
        % splits the line
        parts = strsplit(lines{i});
        
        % handles blank line at end
        if length(parts) == 1
            break;
        end
        
        % gets degree and order
        n = str2double(parts{2});
        m = str2double(parts{3});
        
        % gets the gravitational model index
        l = grav_model_index(n,m);
        
        % stores coefficients
        C0(l) = str2double(parts{4});
        S0(l) = str2double(parts{5});
        
    end
    
    % performs normalization/denormalization
    if normalized
        C_norm = C0;
        S_norm = S0;
        [C,S] = denormalize_coeffs(C_norm,S_norm);
    else
        C = C0;
        S = S0;
        [C_norm,S_norm] = normalize_coeffs(C,S);
    end
    
    % manually sets first three rows (may be missing)
    %   --> TODO: the other rows are already 0's due to initialization
    C_norm(grav_model_index(1,0)) = 1;
    C(grav_model_index(1,0)) = 1;
    
    % TODO documentation on above step
    

    % TODO: make note that the grav coefficients do NOT have to be
    % correctly sorted, but typically are
    
end