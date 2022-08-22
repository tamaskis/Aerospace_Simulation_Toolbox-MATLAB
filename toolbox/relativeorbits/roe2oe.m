%==========================================================================
%
% roe2oe  TODO
%
%   [ad,ed,id,Omd,wd,nud] = roe2oe(OEc,ROE)
%   [ad,ed,id,Omd,wd,nud] = roe2oe([ac,ec,ic,Omc,wc,nuc],[ada,adlam,...
%       adex,adey,adix,adiy])
%
% Author: Tamas Kis
% Last Update: 2022-02-21
%
% REFERENCES:
%   [1] TODO
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   OE      - (1×6 double) chief orbital elements [m]
%               1. ac    - chief semi-major axis [m]
%               2. ec    - chief eccentricity [-]
%               3. ic    - chief inclination [rad]
%               4. Omc   - chief RAAN [rad]
%               5. wc    - chief argument of periapsis [rad]
%               6. nuc   - chief true anomaly [rad]
%   ROE     - (1×6 double) deputy relative orbital elements [m]
%               1. ada   - relative semi-major axis [m]
%               2. adlam - relative mean longitude [m]
%               3. adex  - x-comp of relative eccentricity vector [m]
%               4. adey  - y-comp of relative eccentricity vector [m]
%               5. adix  - x-comp of relative inclination vector [m]
%               6. adiy  - y-comp of relative inclination vector [m]
%
% -------
% OUTPUT:
% -------
%   ad      - (1×1 double) deputy semi-major axis [m]
%   ed      - (1×1 double) deputy eccentricity [-]
%   id      - (1×1 double) deputy inclination [rad]
%   Omd     - (1×1 double) deputy RAAN [rad]
%   wd      - (1×1 double) deputy argument of periapsis [rad]
%   Md      - (1×1 double) deputy mean anomaly [rad]
%
%==========================================================================
function [ad,ed,id,Omd,wd,nud] = roe2oe(OEc,ROE)
    
    % extract chief orbital elements
    ac = OEc(1);
    ec = OEc(2);
    ic = OEc(3);
    Omc = OEc(4);
    wc = OEc(5);
    nuc = OEc(6);

    % chief mean anomaly [rad]
    Mc = nu2M(nuc,ec);

    % extract deputy relative orbital elements
    ada = ROE(1);
    adlam = ROE(2);
    adex = ROE(3);
    adey = ROE(4);
    adix = ROE(5);
    adiy = ROE(6);

    % deputy eccentricity vector
    evecd = zeros(2,1);
    evecd(1) = adex/ac+ec*cos(wc);
    evecd(2) = adey/ac+ec*sin(wc);

    % Lucas modified form for wrapping issues
    ad = ada+ac;
    id = adix/ac+ic;
    Omd = adiy/ac/sin(ic)+Omc;
    wd = atan2(evecd(2),evecd(1));
    ed = norm(evecd);
    
    dOm = Omd - Omc;
    if (dOm < 0)
        dOm = mod(dOm-pi,2*pi)+pi;
    elseif (dOm>0)
        dOm = mod(dOm+pi,2*pi)-pi;
    end
    
    du = adlam/ac-dOm*cos(ic);
    Md = du-wd+wc+Mc;
    
    Md = Md-2*pi*floor(Md/(2*pi));



    % deputy true anomaly
    nud = M2nu(Md,ed);
    
end