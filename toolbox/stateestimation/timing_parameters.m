%==========================================================================
%
% timing_parameters  Extract timing parameters needed for state estimation
% and filtering from simulation data.
%
%   [UTC_start,duration,dt,t0] = timing_parameters(simdata)
%
% Author: Tamas Kis
% Last Update: 2022-03-20
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   simdata     - (1×1 struct) simulation data (see "toolbox/propagators/
%                 simulate_orbit" for full definition)
%
% -------
% OUTPUT:
% -------
%   UTC_start   - (1×6 double) initial UTC [y,mo,d,h,m,s]
%   duration    - (1×1 double) simulation duration [h]
%   dt          - (1×1 double) time step [s]
%   t0          - (1×1 double) initial simulation time [s]
%
%==========================================================================
function [UTC_start,duration,dt,t0] = timing_parameters(simdata)
    
    % initial UTC [y,mo,d,h,m,s]
    UTC_start = simdata.cal_UTC(1,:);
    
    % simulation duration [h]
    duration = (simdata.t(end)-simdata.t(1))/3600;
    
    % time step [s]
    dt = simdata.t(2)-simdata.t(1);
    
    % simulation start time [s]
    t0 = simdata.t(1);

end