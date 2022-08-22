%==========================================================================
%
% A_var_eqns  "A" matrix for the variational equations (Jacobian of ECI 
% accelerations with respect to ECI state).
%
%   A = A_var_eqns(X,t,prop,sat)
%
% See also initialize_propagator.
%
% Author: Tamas Kis
% Last Update: 2022-03-05
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   X       - (6×1 double) orbital state vector
%               --> 1-3. r_eci - position resolved in ECI frame [m]
%               --> 4-6. v_eci - inertial velocity resolved in ECI frame 
%                                [m/s]
%   t       - (1×1 double) simulation time [s]
%   prop    - (1×1 struct) propagator settings (see initialize_propagator
%             function for full definition)
%   sat     - (1×1 struct) satellite parameters
%       • m  	- (1×1 double) mass [kg]
%    	• AD   	- (1×1 double) atmospheric drag reference area [m^2]
%    	• CD  	- (1×1 double) drag coefficient [-]
%    	• Asrp  - (1×1 double) solar radiation pressure reference area 
%                 [m^2]
%     	• CR    - (1×1 double) coefficient of reflectivity [-]
%
% -------
% OUTPUT:
% -------
%   A       - (6×6 double) "A" matrix for the variational equations
%
%==========================================================================
function A = A_var_eqns(X,t,prop,sat)

    % extracts ECI position [m] and inertial velocity [m/s] 
    r_eci = X(1:3);
    v_eci = X(4:6);

    % -------
    % Timing.
    % -------
    
    % TODO: need to update time scales/offsets when going to new day

    % time scales [MJD]
    [~,~,MJD_TT,MJD_UT1] = time_scales(t,prop.t0);
    
    % ------------------
    % Earth orientation.
    % ------------------

    if strcmpi(prop.models.orientation,'IAU2006/2000')

        % Earth orientation parameters for IAU2006/2000 CIO based theory
        [xp,yp,dX,dY,LOD] = eop_iau06(MJD_UT1,prop.data.eop);
        
        % rotation matrices and Earth angular velocity [rad/s] from 
        % IAU2006/2000  CIO based theory
        [R_ecef2eci,R_eci2ecef,w_eci] = iau06(MJD_UT1,MJD_TT,xp,yp,dX,...
            dY,LOD,prop.data.XYs_iau06);

    else

        % rotation matrix from ECI frame to ECEF frame
        R_eci2ecef = eci2ecef_matrix_approx(MJD_UT1,prop.models.gmst);

        % rotation matrix from ECEF frame to ECI frame
        R_ecef2eci = R_eci2ecef.';

        % Earth angular velocity [rad/s]
        w_eci = w_earth_approx;

    end
    
    % ----------------------------
    % Other state representations.
    % ----------------------------

    % position resolved in ECEF frame [m]
    r_ecef = eci2ecef(r_eci,v_eci,w_eci,R_eci2ecef);

    % ------------
    % Environment.
    % ------------

    % obliquity of the ecliptic [rad]
    epsilon = obliquity(MJD_TT);

    % Moon position resolved in ECI frame [m]
    r_moon_eci = moon_position(MJD_UT1,epsilon);

    % Sun position resolved in ECI frame [m]
    r_sun_eci = sun_position(MJD_UT1,epsilon);

    % space weather parameters
    sw = space_weather(MJD_UT1,prop.data.sw1,prop.data.sw2,...
        prop.models.density);

    % atmospheric density [kg/m^3], number densities [m^-3], and
    % temperatures [K]
    if strcmpi(prop.models.density,'Exponential')
        rho = exponential(r_ecef);
    elseif strcmpi(prop.models.density,'Harris-Priester')
        rho = harris_priester(r_eci,r_ecef,r_sun_eci);
    elseif strcmpi(prop.models.density,'Jacchia-Bowman 2008')
        rho = jacchia_bowman_2008(r_ecef,r_sun_eci,MJD_UT1,sw.F107,...
            sw.F107_avg,sw.S107,sw.S107_avg,sw.M107,sw.M107_avg,sw.Y107,...
            sw.Y107_avg,sw.dTc);
    elseif strcmpi(prop.models.density,'Jacchia-Roberts')
        rho = jacchia_roberts(r_eci,r_ecef,r_sun_eci,R_eci2ecef,MJD_TT);
    elseif strcmpi(prop.models.density,'NRLMSISE-00')
        rho = nrlmsise00(r_ecef,MJD_UT1,sw.F107_avg,sw.F107,sw.ap_array,...
            prop.data.nrlm_data);
    elseif strcmpi(prop.models.density,'NRLMSISE-00 (MATLAB)')
        rho = nrlmsise00_matlab(r_ecef,MJD_UT1,sw.F107_avg,sw.F107,...
            sw.ap_array);
    end

    % --------------------------------------------------------------------
    % Partial derivatives of the acceleration (all resolved in ECI frame).
    % --------------------------------------------------------------------

    % 3×3 zero matrix
    zero_3_by_3 = zeros(3,3);

    % partial derivatives of gravitational acceleration w.r.t. position 
    % [1/s^2] and velocity [1/s]
    [dadr_g,dadv_g] = dadX_gravity(r_ecef,prop.data.C,prop.data.S,...
        prop.models.grav_N,R_ecef2eci);

    % partial derivatives of drag acceleration w.r.t. position [1/s^2] and
    % velocity [1/s]
    if prop.perturb.drag
        drhodr = drhodr_nrlmsise00(r_ecef,MJD_UT1,sw.F107_avg,sw.F107,...
            sw.ap_array,prop.data.nrlm_data,R_eci2ecef);
        [dadr_D,dadv_D] = dadX_drag(r_eci,v_eci,w_eci,sat.B,rho,drhodr,...
            R_ecef2eci);
    else
        dadr_D = zero_3_by_3;
        dadv_D = zero_3_by_3;
    end
    
    % partial derivatives of solar radiation pressure acceleration w.r.t. 
    % position [1/s^2] and velocity [1/s]
    if prop.perturb.srp
        [dadr_srp,dadv_srp] = dadX_srp(r,r_sun,sat.CR,sat.Asrp,sat.m);
    else
        dadr_srp = zero_3_by_3;
        dadv_srp = zero_3_by_3;
    end
    
    % perturbing acceleration due to 3rd-body gravity from the Moon [m/s^2]
    if prop.perturb.moon
        [dadr_moon,dadv_moon] = dadX_third_body(r_eci,r_moon_eci,MU_MOON);
    else
        dadr_moon = zero_3_by_3;
        dadv_moon = zero_3_by_3;
    end

    % perturbing acceleration due to 3rd-body gravity from the Sun [m/s^2]
    if prop.perturb.sun
        [dadr_sun,dadv_sun] = dadX_third_body(r_eci,r_sun_eci,MU_SUN);
    else
        dadr_sun = zero_3_by_3;
        dadv_sun = zero_3_by_3;
    end

    % partial derivative of ECI acceleration w.r.t. ECI position [1/s^2]
    dadr_eci = dadr_g+dadr_D+dadr_srp+dadr_moon+dadr_sun;
    
    % partial derivative of ECI acceleration w.r.t. ECI velocity [1/s^2]
    dadv_eci = dadv_g+dadv_D+dadv_srp+dadv_moon+dadv_sun;
    
    % -----------------------------------------
    % "A" matrix for the variational equations.
    % -----------------------------------------
    
    A = [zeros(3,3)   eye(3,3);
         dadr_eci     dadv_eci];
    
end