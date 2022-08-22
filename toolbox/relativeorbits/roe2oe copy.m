%==========================================================================
%
% roe2oe  TODO
%
%   TODO
%
% Author: Tamas Kis
% Last Update: 2021-11-15
%
% REFERENCES:
%   [1] TODO
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   ada     - (1×1 double) relative semi-major axis [m]
%   adlam   - (1×1 double) relative mean longitude [m]
%   adex    - (1×1 double) x-comp of relative eccentricity vector [m]
%   adey    - (1×1 double) y-comp of relative eccentricity vector [m]
%   adix    - (1×1 double) x-comp of relative inclination vector [m]
%   adiy    - (1×1 double) y-comp of relative inclination vector [m]
%
% -------
% OUTPUT:
% -------
%   a       - (1×1 double) semi-major axis [m]
%   e       - (1×1 double) eccentricity [-]
%   i       - (1×1 double) inclination [rad]
%   Om      - (1×1 double) right ascension of the ascending node [rad]
%   w       - (1×1 double) argument of periapsis [rad]
%   M       - (1×1 double) mean anomaly [rad]
%
%==========================================================================
function OE = roe2oe(OE_chief,ada,adlam,adex,adey,adix,adiy)
    
    
    ac     = OE_chief(1);
    ec     = OE_chief(2);
    ic     = OE_chief(3);
    OMEGAc = OE_chief(4);
    omegac = OE_chief(5);
    Mc     = OE_chief(6);

    % Eccentricity vector of deputy
    evecd = zeros(2,1);
    evecd(1) = adex/ac + ec*cos(omegac);
    evecd(2) = adey/ac + ec*sin(omegac);

    % Lucas modified form for wrapping issues
    ad = ada+ac;
    id = adix/ac+ic;
    OMEGAd = adiy/ac/sin(ic)+OMEGAc;
    omegad = atan2(evecd(2),evecd(1));
    ed = norm(evecd);
    
    dOMEGA = OMEGAd - OMEGAc;
    if (dOMEGA < 0)
        dOMEGA = mod(dOMEGA-pi,2*pi)+pi;
    elseif (dOMEGA>0)
        dOMEGA = mod(dOMEGA+pi,2*pi)-pi;
    end
    
    du = adlam/ac-dOMEGA*cos(ic);
    Md = du-omegad+omegac+Mc;
    
    Md = Md-2*pi*floor(Md/(2*pi));

    OE(1) = ad;
    OE(2) = ed;
    OE(3) = id;
    OE(4) = OMEGAd;
    OE(5) = omegad;
    OE(6) = Md;
    
end