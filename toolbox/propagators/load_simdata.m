%==========================================================================
%
% load_simdata  Loads simulation data.
%
%   simdata = load_simdata
%
% Author: Tamas Kis
% Last Update: 2022-03-19
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   file_path   - (char) file path for file storing simulation data
%
% -------
% OUTPUT:
% -------
%   simdata     - (1×1 struct) simulation data (see "simulate_orbit" for
%                 full definition)
%
%==========================================================================
function simdata = load_simdata(file_path)
    simdata = load_numeric_data(file_path);
end