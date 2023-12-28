%==========================================================================
%
% load_EGM2008  Loads EGM2008 gravity model data.
%
%   EGM2008 = load_EGM2008
%   EGM2008 = load_EGM2008(N)
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-12-27
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
% TODO Update
% ------
% INPUT:
% ------
%   N       - (OPTIONAL) (1×1 double) maximum degree/order to use (defaults
%             to the maximum possible degree/order provided by data)
%
% -------
% OUTPUT:
% -------
%   EGM2008  - (1×1 struct) EGM2008 gravity model data
%       • C_norm - ((N+1)×(N+1) double) normalized gravitational coeffs.
%       • S_norm - ((N+1)×(N+1) double) normalized gravitational coeffs.
%
%==========================================================================
function EGM2008 = load_EGM2008(N)
    
    % loads full set of gravity coefficients
    EGM2008 = load_numeric_data('EGM2008.mat');

    % % TODO
    % L = (N+1)*(N+2)/2;
    % 
    % % defaults N to maximum possible value if not input
    % if (nargin == 0) || isempty(N)
    %     N = size(EGM2008.C_norm,1)-1;
    % end
    % 
    % % keeps coefficients up to degree/order N
    % EGM2008.C_norm = EGM2008.C_norm(1:(N+1),1:(N+1));
    % EGM2008.S_norm = EGM2008.S_norm(1:(N+1),1:(N+1));
    % 
end