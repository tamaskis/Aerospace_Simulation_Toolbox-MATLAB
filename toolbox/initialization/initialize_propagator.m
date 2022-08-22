%==========================================================================
%
% initialize_propagator  Propagator initialization.
%
%   prop = initialize_propagator(models,perturb,UTC_start,duration,...
%       time_step,integrator,sim_start)
%
% Author: Tamas Kis
% Last Update: 2022-02-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   models      - (1×1 struct) environmental models for propagator
%       • density     - (char) specifies density model ('Exponential', 
%                       'Harris-Priester', 'Jacchia-Bowman 2008', 
%                       'Jacchia-Roberts', 'NRLMSISE-00', or 
%                       'NRLMSISE-00 (MATLAB)')
%       • grav_N      - (1×1 double) maximum degree/order of gravity model
%                       to use
%       • orientation - (char) specifies Earth orientation model
%                       ('IAU2006/2000' or 'Simple Rotation')
%       • gmst        - (char) (OPTIONAL) specifies which model to use for
%                       GMST ('Linear', 'Vallado', or 'IAU2006/2000') -->
%                       only needed if "orientation" is set to 'Simple
%                       Rotation'
%   perturb     - (1×1 struct) turns perturbations on (1) or off (0)
%       • drag  	 - (1×1 double or logical) atmospheric drag
%       • emp_accel	 - (1×1 double or logical) empirical acceleration
%       • moon  	 - (1×1 double or logical) 3rd body gravity of Moon
%       • relativity - (1×1 double or logical) relativistic effects
%       • srp    	 - (1×1 double or logical) solar radiation pressure
%       • sun   	 - (1×1 double or logical) 3rd body gravity of Sun
%   UTC_start   - (1×6 double) initial UTC [y,mo,d,h,m,s]
%   duration    - (1×1 double) simulation duration [h]
%   time_step   - (1×1 double) time step [s]
%   integrator  - (char) integrator ('RK4' or 'ABM8')
%   sim_start   - (1×1 double) (OPTIONAL) initial simulation time [s]
%
% -------
% OUTPUT:
% -------
%   prop        - (1×1 struct) structure to store all propagator settings
%       • data - (1×1 struct) data for orbit propagation/determination
%           ‣ C         - (1×1 function_handle) gravitational coefficients
%           ‣ S         - (1×1 function_handle) gravitational coefficients
%           ‣ eop       - (1×1 struct) Earth orientation parameters
%           ‣ XYs_iau06 - (1×1 struct) additional data for calculating
%                         Earth orientation
%           ‣ sw1       - (1×1 struct) 1st half of space weather data
%           ‣ sw2       - (1×1 struct) 2nd half of space weather data
%           ‣ nrlm_data - (1×1 struct) data needed for NRLMSISE-00
%                         atmospheric model; this is only included if using
%                         the NRLMSISE-00 model
%     	• models - (1×1 struct) environmental models for propagator (same
%                  as input)
%     	• solver - (1×1 struct) ODE solver settings
%           ‣ dt       - (1×1 double) time step [s]
%           ‣ method   - (char) integration method
%           ‣ t0       - (1×1 double) simulation start time [s]
%           ‣ tf       - (1×1 double) simulation end time [s]
%      	• perturb - (1×1 struct) turns perturbations on (1) or off (0)
%      	            (same as input)
%     	• t0 - (1×1 struct) initial times
%           ‣ t0       - (1×1 double) simulation time [s]
%           ‣ MJD_GPS0 - (1×1 double) GPS time [MJD]
%           ‣ MJD_TAI0 - (1×1 double) TAI (International Atomic Time) [MJD]
%           ‣ MJD_TT0  - (1×1 double) TT (Terrestrial Time) [MJD]
%           ‣ MJD_UT10 - (1×1 double) UT1 (Universal Time 1) [MJD]
%           ‣ MJD_UTC0 - (1×1 double) UTC (Universal Coordinated Time) 
%                        [MJD]
%
%==========================================================================
function prop = initialize_propagator(models,perturb,UTC_start,duration,...
    time_step,integrator,sim_start)
    
    % --------------
    % Initial times.
    % --------------

    % defaults initial simulation time to empty vector if not input
    if (nargin < 6), sim_start = []; end
    
    % initialize structure of initial times
    t0 = initialize_time(UTC_start,sim_start);

    % --------------------
    % ODE solver settings.
    % --------------------

    % time step [s]
    solver.dt = time_step;

    % integration method
    solver.method = integrator;

    % simulation start time [s]
    solver.t0 = t0.t0;

    % simulation end time [s]
    solver.tf = solver.t0+(duration*3600);

    % -----
    % Data.
    % -----

    data = initialize_data(t0.MJD_UTC0,duration,models.grav_N);
    
    % -------------------------------------
    % Package overall propagator structure.
    % -------------------------------------

    prop.data = data;
    prop.models = models;
    prop.solver = solver;
    prop.perturb = perturb;
    prop.t0 = t0;

end