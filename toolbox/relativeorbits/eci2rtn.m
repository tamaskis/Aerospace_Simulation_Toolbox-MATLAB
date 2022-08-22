%==========================================================================
%
% eci2rtn  Deputy relative state in chief's RTN frame from absolute ECI
% states of chief and deputy.
%
%   dX = eci2rtn(Xc,Xd)
%
% Author: Tamas Kis
% Last Update: 2022-03-13
%
% REFERENCES:
%   [1] Curtis, "Orbital Mechanics for Engineering Students", 3rd Ed. 
%       (pp. 368-370)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   Xc      - (6×1 double) chief ECI state
%               --> 1-3. position resolved in ECI frame
%               --> 4-6. inertial velocity resolved in ECI frame
%   Xd      - (6×1 double) deputy ECI state
%               --> 1-3. position resolved in ECI frame
%               --> 4-6. inertial velocity resolved in ECI frame
%
% -------
% OUTPUT:
% -------
%   dX 	    - (6×1 double) deputy relative state in chief's RTN frame
%               --> 1-3. relative position resolved in chief's RTN frame
%               --> 4-6. relative RTN velocity resolved in chief's RTN 
%                        frame
%
% -----
% NOTE:
% -----
%   --> "Xc" and "Xd" can be input in any units, as long as both are input
%       with the same units.
%   --> The position and velocity components must have compatible units
%       (i.e. the length units used for the velocity components should be
%       consistent with the length units used for the position components).
%
%==========================================================================
function dX = eci2rtn(Xc,Xd)
    
    % extracts ECI positions and velocities from ECI states
    rc_eci = Xc(1:3);
    vc_eci = Xc(4:6);
    rd_eci = Xd(1:3);
    vd_eci = Xd(4:6);
    
    % angular velocity of RTN frame w.r.t. ECI frame, resolved in ECI frame
    % [rad/s]
    w_rtn_eci = rv2w(rc_eci,vc_eci);
    
    % relative position and RTN velocity resolved in ECI frame
    dr_eci = rd_eci-rc_eci;
    dv_eci = (vd_eci-vc_eci)-cross(w_rtn_eci,dr_eci);
    
    % rotation matrix from ECI frame to chief's RTN frame
    R_eci2rtn = eci2rtn_matrix(rc_eci,vc_eci);
    
    % relative position and RTN velocity of deputy resolved in chief's RTN 
    % frame
    dr_rtn = R_eci2rtn*dr_eci;
    dv_rtn = R_eci2rtn*dv_eci;
    
    % assembles deputy relative state in chief's RTN frame
    dX = [dr_rtn;
          dv_rtn];
    
end