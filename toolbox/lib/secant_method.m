%==========================================================================
%
% secant_method  Calculates the root of a univariate, scalar-valued 
% function using the secant method.
%
%   root = secant_method(f,x0)
%   root = secant_method(f,x0,opts)
%
% See also fzero, bisection_method, newtons_method, fixed_point_iteration.
%
% Copyright © 2021 Tamas Kis
% Last Update: 2021-12-27
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% TECHNICAL DOCUMENTATION:
% https://tamaskis.github.io/documentation/Secant_Method.pdf
%
% REFERENCES:
%   [1] Burden and Faires, "Numerical Analysis", 9th Ed. (pp. 67-78)
%   [2] https://en.wikipedia.org/wiki/Newton%27s_method
%   [3] https://en.wikipedia.org/wiki/Secant_method
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   f       - (1×1 function_handle) univariate, scalar-valued function f(x)
%             (f:R->R)
%   x0      - (1×1 double) initial guess for root
%   opts    - (OPTIONAL) (1×1 struct) solver options
%       • imax       - (1×1 double) maximimum number of iterations 
%                      (defaults to 1e6)
%       • return_all - (1×1 logical) all intermediate root estimates are
%                      returned if set to "true"; otherwise, a faster 
%                      algorithm is used to return only the converged root
%                      (defaults to false)
%       • TOL        - (1×1 double) tolerance (defaults to 1e-12)
%       • warnings   - (1×1 logical) true if any warnings should be 
%                      displayed, false if not (defaults to true)
%
% -------
% OUTPUT:
% -------
%   root    - (1×1 double or 1D double array) root of f(x)
%           	--> If "return_all" is specified as "true", then "root" 
%                   will be a vector, where the first element is the 
%                   initial guess, the last element is the converged root, 
%                   and the other elements are intermediate estimates of 
%                   the root.
%               --> Otherwise, "root" is a single number storing the
%                   converged root.
%
%==========================================================================
function root = secant_method(f,x0,opts)
    
    % ----------------------------------
    % Sets (or defaults) solver options.
    % ----------------------------------
    
    % sets maximum number of iterations (defaults to 1e6)
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'imax')
        imax = 1e6;
    else
        imax = opts.imax;
    end
    
    % determines return value (defaults to only return converged root)
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'return_all')
        return_all = false;
    else
        return_all = opts.return_all;
    end
    
    % sets tolerance (defaults to 1e-12)
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'TOL')
        TOL = 1e-12;
    else
        TOL = opts.TOL;
    end
    
    % determines if warnings should be displayed (defaults to true)
    if (nargin < 3) || isempty(opts) || ~isfield(opts,'warnings')
        warnings = true;
    else
        warnings = opts.warnings;
    end
    
    % -------------------------------------------------
    % "Return all" implementation of the secant method.
    % -------------------------------------------------
    
    if return_all
        
        % preallocates x
        x = zeros(imax,1);
    
        % inputs 1st and 2nd guesses for root into x vector
        x(1) = x0;
        x(2) = x0+0.001;
        
        % initializes the error so the loop will be entered
        err = 2*TOL;

        % secant method
        i = 2;
        while (err > TOL) && (i < imax)

            % updates estimate of root
            x(i+1) = (x(i-1)*f(x(i))-x(i)*f(x(i-1)))/(f(x(i))-f(x(i-1)));

            % calculates error
            err = abs(x(i+1)-x(i));

            % increments loop index
            i = i+1;

        end

        % returns converged root along with intermediate root estimates
        root = x(1:i);
    
    % -------------------------------------------
    % "Fast" implementation of the secant method.
    % -------------------------------------------
    
    else
        
        % sets 1st and 2nd guesses for root
        x_old = x0;
        x_int = x0+0.001;
        
        % initializes x_new so its scope isn't limited to the while loop
        x_new = 0;
        
        % initializes the error so the loop will be entered
        err = 2*TOL;

        % secant method
        i = 2;
        while (err > TOL) && (i < imax)

            % updates estimate of root
            x_new = (x_old*f(x_int)-x_int*f(x_old))/(f(x_int)-f(x_old));

            % calculates error
            err = abs(x_new-x_int);
            
            % stores current and previous root estimates for next iteration
            x_old = x_int;
            x_int = x_new;

            % increments loop index
            i = i+1;

        end

        % returns converged root
        root = x_new;
        
    end

    % ---------------------------------------------------------
    % Displays warning if maximum number of iterations reached.
    % ---------------------------------------------------------

    if (i == imax) && warnings
        warning(strcat('The method failed after i=',num2str(imax),...
            ' iterations.'));
    end
      
end