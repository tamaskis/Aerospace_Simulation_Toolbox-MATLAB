%==========================================================================
%
% load_GGM05S  Loads GGM05S gravity model data.
%
%   GGM05S = load_GGM05S
%   GGM05S = load_GGM05S(N)
%
% Author: Tamas Kis
% Last Update: 2022-02-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   N       - (1×1 double) (OPTIONAL) maximum degree/order to use (defaults
%             to the maximum possible degree/order provided by data)
%
% -------
% OUTPUT:
% -------
%   GGM05S  - (1×1 struct) GGM05S gravity model data
%       • C_norm - ((N+1)×(N+1) double) normalized gravitational coeffs.
%       • S_norm - ((N+1)×(N+1) double) normalized gravitational coeffs.
%
%==========================================================================
function GGM05S = load_GGM05S(N)

    % loads full set of gravity coefficients
    GGM05S = struct2array(load('GGM05S.mat'));

    % defaults N to maximum possible value if not input
    if (nargin == 0) || isempty(N)
        N = size(GGM05S.C_norm,1)-1;
    end

    % keeps coefficients up to degree/order N
    GGM05S.C_norm = GGM05S.C_norm(1:(N+1),1:(N+1));
    GGM05S.S_norm = GGM05S.S_norm(1:(N+1),1:(N+1));

end