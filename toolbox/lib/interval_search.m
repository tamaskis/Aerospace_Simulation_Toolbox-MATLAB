%==========================================================================
%
% interval_search  Finds the interval containing a query point.
%
%   [left,right] = interval_search(x,xq)
%   [left,right] = interval_search(x,xq,warnings)
%
% See also find.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2022-04-16
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% REFERENCES:
%   [1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Procedure_for_finding_the_leftmost_element
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   x           - (n×1 or 1×n double) independent variable data (i.e. 
%                 search space)
%   xq          - (1×1 double) query point
%   warnings    - (1×1 logical) prints warnings if "true", otherwise does
%                 not print warnings (defaults to "true")
%
% -------
% OUTPUT:
% -------
%   left        - (1×1 double) index referring to the element of "x" that
%                 defines the lower bound of the interval containing "xq"
%   right       - (1×1 double) index referring to the element of "x" that
%                 defines the upper bound of the interval containing "xq"
%
% -----
% NOTE:
% -----
%   --> Uses the binary search algorithm.
%   --> "x" must be a monotonically increasing vector.
%   --> If "xq" appears in "x", then "left" and "right" will be returned as
%       that index of "x" storing "xq".
%   --> If "xq" is less than every point in the search space "x", then 
%       "left" and "right" are returned as "1" and "2", respectively, and a
%       warning message is printed (if "warnings" is set to true).
%   --> If "xq" is greater than every point in the search space "x", then 
%       "left" and "right" are returned as "n-1" and "n", respectively,
%       where "n" is the number of points in "x", and a warning message is 
%       printed (if "warnings" is set to true).
%
%--------------------------------------------------------------------------
function [left,right] = interval_search(x,xq,warnings)

    % defaults "warnings" to true if not input
    if (nargin == 2) || isempty(warnings)
        warnings = true;
    end

    % "xq" below "x"
    if xq < x(1)
        left = 1;
        right = 2;
        if warnings
            warning(strcat('Query point "xq" out of bounds -- less',...
                ' than smallest data in search space "x".'));
        end
        return;
    end

     % "xq" above "x"
    if xq > x(end)
        left = length(x)-1;
        right = length(x);
        if warnings
            warning(strcat('Query point "xq" out of bounds -- greater',...
                ' than largest data in search space "x".'));
        end
        return;
    end
    
    % initializes "left" and "right"
    left = 1;
    right = length(x);
    
    % binary search procedure
    while left < right
        
        % new midpoint
        mid = floor((left+right)/2);
            
        % right half of search space is discarded
        if x(mid) < xq
            left = mid+1;
            
        % left half of search space is discarded
        else
            right = mid;
            
        end
        
    end
    
    % "left" needs to be decremented by 1 unless it is equal to "xq"
    if x(left) ~= xq
        left = left-1;
    end

end