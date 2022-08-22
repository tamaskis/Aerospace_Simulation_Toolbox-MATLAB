%==========================================================================
%
% load_nrlm_data  Loads data for NRLMSISE-00 atmospheric model.
%
%   nrlm_data = load_nrlm_data
%
% Author: Tamas Kis
% Last Update: 2022-02-17
%
%--------------------------------------------------------------------------
%
% -------
% OUTPUT:
% -------
%   nrlm_data   - (1×1 struct) structure storing data needed for
%                 NRLMSISE-00 atmospheric model
%
%==========================================================================
function nrlm_data = load_nrlm_data
    nrlm_data = struct2array(load('nrlm_data.mat'));
end