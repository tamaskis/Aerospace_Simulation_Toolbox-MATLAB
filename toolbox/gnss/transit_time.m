%==========================================================================
%
% transit_time  GPS signal transit time from GPS satellite to receiver.
%
%   tau = transit_time(r_rcv_ecef,t,subframe1,subframe23)
%
% Author: Tamas Kis
% Last Update: 2022-03-19
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_rcv_ecef  - (3×1 double) receiver position resolved in ECEF frame [m]
%   t           - (1×1 double) GPS time (seconds of week) [s]
%   subframe1   - subframe 1 parameters for GPS satellite k
%   subframe23  - (1×1 struct) subframe 2 and 3 parameters for GPS 
%                 satellite k
%
% -------
% OUTPUT:
% -------
%   tau         - (1×1 double) transit time [s]
%
%==========================================================================
function tau = transit_time(r_rcv_ecef,t,subframe1,subframe23)
    
    % oonly considers real portion of "r_rcv_ecef" (for compatibility with
    % Numerical Differentiation Toolbox)
    r_rcv_ecef = real(r_rcv_ecef);
    
    % Earth's rotation rate (WGS84) [rad/s]
    w_earth = 7.2921151467e-5;
    
    % speed of light [m/s]
    c = 299792458;
    
    % initial guess for transit time [s]
    tau0 = 0.0653;
    
    % function for ECEF position of GPS satellite k
    rk = @(tau) ephem2state(t-tau,subframe1,subframe23);
    
    % function whose root is the transit time
    f = @(tau) tau-inorm(r_rcv_ecef-rot3(w_earth*tau)*rk(tau))/c;
    
    % sets maximum number of iterations to 10
    opts.imax = 10;
    
    % transit time [s]
    tau = secant_method(f,tau0,opts);
    
end