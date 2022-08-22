%==========================================================================
%
% initialize_data  Initializes the data needed for orbit
% propagation and determination.
%
%   data = initialize_data
%   data = initialize_data(MJD_UTC0,duration,N,density)
%
% Author: Tamas Kis
% Last Update: 2022-02-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   MJD_UTC0    - (1×1 double) (OPTIONAL) initial UTC [MJD]
%   duration    - (1×1 double) (OPTIONAL) simulation duration [h]
%   N           - (1×1 double) (OPTIONAL) maximum degree/order of gravity 
%                 model to use
% -------
% OUTPUT:
% -------
%   data        - (1×1 struct) data for orbit propagation/determination
%       • C         - (1×1 function_handle) gravitational coefficients
%       • S         - (1×1 function_handle) gravitational coefficients
%       • eop       - (1×1 struct) Earth orientation parameters
%       • XYs_iau06 - (1×1 struct) additional data for calculating Earth
%                     orientation
%       • sw1       - (1×1 struct) 1st half of space weather data
%       • sw2       - (1×1 struct) 2nd half of space weather data
%       • nrlm_data - (1×1 struct) data needed for NRLMSISE-00 atmospheric
%                     model
%==========================================================================
function data = initialize_data(MJD_UTC0,duration,N)
    
    % -------------------------------------------------------
    % Defaults optional inputs to empty vectors if not input.
    % -------------------------------------------------------

    if (nargin < 1), MJD_UTC0 = []; end
    if (nargin < 2), duration = []; end
    if (nargin < 3), N = []; end
    
    % ---------------------
    % Load/initialize data.
    % ---------------------

    % gravity coefficients
    GGM05S = load_GGM05S(N);

    % function handles for returning gravitational coefficients
    [data.C,data.S] = gravity_coeffs(GGM05S.C_norm,GGM05S.S_norm);

    % Earth orientation parameters
    data.eop = load_eop(MJD_UTC0,duration);

    % additional data for calculating Earth orientation
    data.XYs_iau06 = load_XYs_iau06;
    
    % space weather data
    [data.sw1,data.sw2] = load_sw(MJD_UTC0,duration);

    % data for NRLMSISE-00 model
    data.nrlm_data = load_nrlm_data;

end