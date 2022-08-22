%==========================================================================
%
% M2E  Eccentric anomaly from mean anomaly.
%
%   E = M2E(M,e)
%
% See also E2M, E2nu, M2nu, nu2E, nu2M.
%
% Author: Tamas Kis
% Last Update: 2022-03-19
%
% REFERENCES:
%   [1] Vallado, "Fundamentals of Astrodynamics and Applications", 4th Ed.,
%       Algorithm 2 (p. 65)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   M       - (1×1 double) mean anomaly [rad]
%   e       - (1×1 double) eccentricity [-]
%
% -------
% OUTPUT:
% -------
%   E       - (1×1 double) eccentric anomaly [rad]
%
% -----
% NOTE:
% -----
%   --> M,E ∈ [0,2π)
%   --> This function is only valid for circular (e = 0) and elliptical
%       (0 < e < 1) orbits.
%
%==========================================================================
function E = M2E(M,e)
    
    % tolerance and maximum number of iterations
    TOL = 1e-12;
    imax = 200;
    
    % return known solutions
    if (M == 0) || (M == pi)
        E = M;
        return;
    end
    
    % wrap M to the interval [0,2π)
    if (M < 0) || (M >= 2*pi)
        M = imod(M,2*pi);
    end
    
    % set initial guess for the eccentric anomaly based on value of M
    if (M < pi)
        E_old = M+e;
    else
        E_old = M-e;
    end
    
    % initializes E_new so its scope isn't limited to the while loop
    E_new = 0;
    
    % initializes the error so the loop will be entered
    err = 2*TOL;
    
    % Newton's method
    i = 1;
    while (err > TOL) && (i < imax)
        
        % updates estimate of eccentric anomaly
        E_new = E_old-(E_old-e*sin(E_old)-M)/(1-e*cos(E_old));
        
        % calculates error
        err = abs(E_new-E_old);
        
        % stores current eccentric anomaly estimate for next iteration
        E_old = E_new;
        
        % increments loop index
        i = i+1;
        
    end
    
    % returns converged eccentric anomaly
    E = E_new;
    
end