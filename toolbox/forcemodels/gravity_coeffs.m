%==========================================================================
%
% gravity_coeffs  Un-normalized gravitational coefficients.
%
%   [C,S] = gravity_coeffs(C_norm,S_norm)
%
% See also load_GGM05S.
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% REFERENCES:
%   [1] Montenbruck and Gill, "Satellite Orbits", Eq. (3.13) (p. 58)
%   [2] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Eq. (8-22) (pp. 546)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   C_norm  - ((N+1)×(N+1) double) normalized gravitational coefficients
%   S_norm  - ((N+1)×(N+1) double) normalized gravitational coefficients
%
% -------
% OUTPUT:
% -------
%   C       - (1×1 function_handle) function to be used as "C(n,m)" to
%             return gravitational coefficient of degree n and order m
%   S       - (1×1 function_handle) function to be used as "S(n,m)" to
%             return gravitational coefficient of degree n and order m
%
% -----
% NOTE:
% -----
%   --> N = maximum degree/order of gravity model
%
%==========================================================================
function [C,S] = gravity_coeffs(C_norm,S_norm)

    % determine maximum degree/order
    N = size(C_norm,1)-1;

    % preallocate matrices for un-normalized coefficients
    C_unnorm = zeros(N+1,N+1);
    S_unnorm = zeros(N+1,N+1);

    % loop through all nonzero elements
    for n = 0:N
        for m = 0:n

            % scaling coefficient
            Pi = sqrt(factorial(n+m)/((2-eq(0,m))*(2*n+1)*factorial(n-m)));

            % elements to access (shift to account for 1-based indexing)
            i = n+1;
            j = m+1;

            % denormalize coefficients
            C_unnorm(i,j) = C_norm(i,j)/Pi;
            S_unnorm(i,j) = S_norm(i,j)/Pi;

        end
    end

    % assign function handles to return coefficients of degree n + order m
    C = @(n,m) C_unnorm(n+1,m+1);
    S = @(n,m) S_unnorm(n+1,m+1);

end