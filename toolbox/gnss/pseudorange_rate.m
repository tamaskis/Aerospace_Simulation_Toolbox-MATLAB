%==========================================================================
%
% pseudorange_rate  GNSS pseudorange rate measurement.
%
%   rho_dot = pseudorange_rate(r_rcv,r_sat,v_rcv,v_sat,b_dot_rcv,b_dot_sat)
%   rho_dot = pseudorange_rate(r_rcv,r_sat,v_rcv,v_sat,b_dot_rcv,...
%       b_dot_sat,noise)
%
% Author: Tamas Kis
% Last Update: 2022-03-16
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_rcv       - (3×1 double) receiver position [m]
%   r_sat       - (3×1 double) GPS satellite position [m]
%   v_rcv       - (3×1 double) receiver velocity [m/s]
%   v_sat       - (3×1 double) GPS satellite velocity [m/s]
%   b_dot_rcv   - (1×1 double) receiver clock bias drift rate [m/s]
%   b_dot_sat   - (1×1 double) satellite clock bias drift rate [m/s]
%   noise       - (1×1 logical) "true" if random noise should be included,
%                 "false" otherwise (defaults to false)
%
% -------
% OUTPUT:
% -------
%   rho_dot     - (1×1 double) pseudorange rate measurement [m/s]
%
% -----
% NOTE:
% -----
%   --> "r_rcv", "r_sat", "v_rcv", and "v_sat" must all be resolved in the 
%       same geocentric coordinate frame. Additionally, "v_rcv" and "v_sat"
%       must also be measured relative to that same geocentric coordinate
%       frame.
%
%==========================================================================
function rho_dot = pseudorange_rate(r_rcv,r_sat,v_rcv,v_sat,b_dot_rcv,...
    b_dot_sat,noise)
    
    % defaults "noise" to "false" if not input
    if (nargin < 7) || isempty(noise)
        noise = false;
    end
    
    % receiver-to-satellite line-of-site unit vector
    LOS = (r_sat-r_rcv)/inorm(r_sat-r_rcv);

    % measurement noise (0 mean, 0.5 m/s std. dev.) [m/s]
    if noise
        epsilon_rho_dot = normrnd(0,0.5);
    else
        epsilon_rho_dot = 0;
    end
    
    % pseudorange rate measurement [m/s]
    rho_dot = idot((v_sat-v_rcv),LOS)+(b_dot_rcv-b_dot_sat)+...
        epsilon_rho_dot;
    
end