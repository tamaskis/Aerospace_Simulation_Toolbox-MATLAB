%==========================================================================
%
% load_numeric_data  Loads numeric data from a .mat file.
%
%   data = load_numeric_data(path)
%
% Copyright © 2023 Tamas Kis
% Last Update: 2023-02-19
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% REFERENCES:
%   [1] https://www.mathworks.com/matlabcentral/answers/1717910-was-struct2array-removed-from-matlab
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   path    - (char array) path to .mat file storing numeric data
%
% -------
% OUTPUT:
% -------
%   data    - (double array) array storing numeric data
%
%==========================================================================
function data = load_numeric_data(path)
    
    % loads the data as a struct
    data_struct = load(path);
    
    % converts structure to cell array
    data_cell = struct2cell(data_struct);
    
    % converts cell array to numeric array
    data = [data_cell{:}];
    
end