%==========================================================================
%
% initialize_deputy  Initializes a deputy satellite's parameters.
%
%   deputy = initialize_deputy(chief,props,ROE)
%
% Author: Tamas Kis
% Last Update: 2022-02-21
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   chief   - (1×1 struct) chief satellite parameters (see 
%             "initialize_chief" for full definition)
%   props   - (1×1 struct) satellite properties
%       • m  	- (1×1 double) mass [kg]
%    	• AD   	- (1×1 double) atmospheric drag reference area [m^2]
%    	• CD  	- (1×1 double) drag coefficient [-]
%    	• Asrp  - (1×1 double) solar radiation pressure reference area 
%                 [m^2]
%     	• CR    - (1×1 double) coefficient of reflectivity [-]
%   ROE     - (1×1 struct) initial relative orbital elements
%       • ada   - (1×1 double) relative semi-major axis [m]
%       • adlam - (1×1 double) relative mean longitude [m]
%       • adex  - (1×1 double) x-comp. of relative eccentricity vector [m]
%       • adey  - (1×1 double) y-comp. of relative eccentricity vector [m]
%       • adix  - (1×1 double) x-comp. of relative inclination vector [m]
%       • adiy  - (1×1 double) y-comp. of relative inclination vector [m]
%
% -------
% OUTPUT:
% -------
%   deputy - (1×1 struct) deputy satellite parameters
%       • m  	- (1×1 double) mass [kg]
%    	• AD   	- (1×1 double) atmospheric drag reference area [m^2]
%    	• CD  	- (1×1 double) drag coefficient [-]
%    	• B   	- (1×1 double) ballistic coefficient [m^2/kg]
%    	• dB  	- (1×1 double) differential ballistic coefficient [-]
%      	• Asrp 	- (1×1 double) solar radiation pressure ref. area [m^2]
%    	• CR 	- (1×1 double) coefficient of reflectivity [-]
%       • ECI  	- (6×1 double) initial ECI state
%                	1-3. r_eci - position resolved in ECI frame [m]
%                	4-6. v_eci - inertial vel. resolved in ECI frame [m/s]
%       • RTN	- (6×1 double) initial relative RTN state
%                	1-3. dr - rel. position resolved in chief RTN frame [m]
%                	4-6. dv - rel. vel. resolved in chief RTN frame [m/s]
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
%     	• ROE     - (1×1 struct) initial relative orbital elements
%           ‣ ada   - (1×1 double) relative semi-major axis [m]
%           ‣ adlam - (1×1 double) relative mean longitude [m]
%           ‣ adex  - (1×1 double) x-comp. of rel. eccentricity vector [m]
%           ‣ adey  - (1×1 double) y-comp. of rel. eccentricity vector [m]
%           ‣ adix  - (1×1 double) x-comp. of rel. inclination vector [m]
%           ‣ adiy  - (1×1 double) y-comp. of rel. inclination vector [m]
%
%==========================================================================
function deputy = initialize_deputy(chief,props,ROE)
    
    % deputy's ballistic coefficient [m^2/kg]
    B = props.CD*props.AD/props.m;
    
    % chief's ballistic coefficient [m^2/kg]
    Bc = chief.B;
    
    % differential ballistic coefficient
    dB = (B-Bc)/Bc;
    
    % extracts chief orbital elements
    ac = chief.OE.a;
    ec = chief.OE.e;
    ic = chief.OE.i;
    Omc = chief.OE.Om;
    wc = chief.OE.w;
    nuc = chief.OE.nu;

    % extracts deputy relative orbital elements
    ada = ROE.ada;
    adlam = ROE.adlam;
    adex = ROE.adex;
    adey = ROE.adey;
    adix = ROE.adix;
    adiy = ROE.adiy;

    % initial osculating orbital elements [m][rad]
    [ad,ed,id,Omd,wd,nud] = roe2oe([ac,ec,ic,Omc,wc,nuc],[ada,adlam,...
        adex,adey,adix,adiy]);
    
    % packages initial osculating orbital elements into structure
    OE.a = ad;
    OE.e = ed;
    OE.i = id;
    OE.Om = Omd;
    OE.w = wd;
    OE.nu = nud;

    % initial mean orbital elements [m][rad] TODO
    %MOE = osc2mean(OE);
    MOE = OE;

    % initial ECI state [m][m/s]
    [r_eci,v_eci] = oe2eci(OE.a,OE.e,OE.i,OE.Om,OE.w,OE.nu);
    ECI = [r_eci;v_eci];

    % initial relative RTN state
    RTN = eci2rtn(chief.ECI,ECI);
    
    % stores parameters in structure
    deputy.m = props.m;
    deputy.AD = props.AD;
    deputy.CD = props.CD;
    deputy.B = B;
    deputy.dB = dB;
    deputy.Asrp = props.Asrp;
    deputy.CR = props.CR;
    deputy.ECI = ECI;
    deputy.RTN = RTN;
    deputy.OE = OE;
    deputy.MOE = MOE;
    deputy.ROE = ROE;
    
end