%==========================================================================
%
% cross_matrix  Skew-symmetric matrix representing a cross product.
%
%   ax = cross_matrix(a)
%
% Author: Tamas Kis
% Last Update: 2022-02-27
%
% REFERENCES:
%   [1] https://en.wikipedia.org/wiki/Cross_product
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   a       - (3×1 double) vector
%
% -------
% OUTPUT:
% -------
%   ax      - (3×3 double) skew-symmetrix matrix where a×b = [ax][a]
%
%==========================================================================
function ax = cross_matrix(a)
    ax = [ 0     -a(3)   a(2);
           a(3)   0     -a(1);
          -a(2)   a(1)   0];
end