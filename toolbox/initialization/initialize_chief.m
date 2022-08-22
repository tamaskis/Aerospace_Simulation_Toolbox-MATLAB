%==========================================================================
%
% initialize_chief  Initializes the chief satellite's parameters.
%
%   chief = initialize_chief(properties,oe)
%
% Author: Tamas Kis
% Last Update: 2022-02-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   props   - (1×1 struct) satellite properties
%       • m  	- (1×1 double) mass [kg]
%    	• AD   	- (1×1 double) atmospheric drag reference area [m^2]
%    	• CD  	- (1×1 double) drag coefficient [-]
%    	• Asrp  - (1×1 double) solar radiation pressure reference area 
%                 [m^2]
%     	• CR    - (1×1 double) coefficient of reflectivity [-]
%   OE      - (6×1 double) initial osculating orbital elements
%       • a  - (1×1 double) semi-major axis [m]
%       • e  - (1×1 double) eccentricity [-]
%       • i  - (1×1 double) inclination [rad]
%       • Om - (1×1 double) right ascension of the ascending node [rad]
%       • w  - (1×1 double) argument of periapsis [rad]
%       • nu - (1×1 double) true anomaly [rad]
%
% -------
% OUTPUT:
% -------
%   chief   - (1×1 struct) chief satellite parameters
%       • m  	- (1×1 double) mass [kg]
%    	• AD   	- (1×1 double) atmospheric drag reference area [m^2]
%    	• CD  	- (1×1 double) drag coefficient [-]
%    	• B   	- (1×1 double) ballistic coefficient [m^2/kg]
%    	• Asrp  - (1×1 double) solar radiation pressure reference area 
%                 [m^2]
%     	• CR 	- (1×1 double) coefficient of reflectivity [-]
%    	• ECI   - (6×1 double) initial ECI state
%                   1-3. r_eci - position resolved in ECI frame [m]
%                   4-6. v_eci - inertial vel. resolved in ECI frame [m/s]
%    	• OE  	- (1×1 struct) initial Keplerian orbital element state
%           ‣ a  - (1×1 double) semi-major axis [m]
%           ‣ e  - (1×1 double) eccentricity [-]
%           ‣ i  - (1×1 double) inclination [rad]
%           ‣ Om - (1×1 double) right ascension of the ascending node [rad]
%           ‣ w  - (1×1 double) argument of periapsis [rad]
%           ‣ nu - (1×1 double) true anomaly [rad]
%    	• MOE 	- (1×1 struct) initial mean Keplerian orbital element state
%           ‣ a_m  - (1×1 double) mean semi-major axis [m]
%           ‣ e_m  - (1×1 double) mean eccentricity [-]
%           ‣ i_m  - (1×1 double) mean inclination [rad]
%           ‣ Om_m - (1×1 double) mean RAAN [rad]
%           ‣ w_m  - (1×1 double) mean argument of periapsis [rad]
%           ‣ M    - (1×1 double) mean mean anomaly [rad]
%
%==========================================================================
function chief = initialize_chief(props,OE)
    
    % ballistic coefficient [m^2/kg]
    B = props.CD*props.AD/props.m;
    
    % initial ECI state [m][m/s]
    [r_eci,v_eci] = oe2eci(OE.a,OE.e,OE.i,OE.Om,OE.w,OE.nu);
    ECI = [r_eci;v_eci];
    
    % initial mean orbital element state [m][rad] % TODO
    %MOE = osc2mean(OE);
    MOE = OE;

    % stores parameters in structure
    chief.m = props.m;
    chief.AD = props.AD;
    chief.CD = props.CD;
    chief.B = B;
    chief.Asrp = props.Asrp;
    chief.CR = props.CR;
    chief.ECI = ECI;
    chief.OE = OE;
    chief.MOE = MOE;

end