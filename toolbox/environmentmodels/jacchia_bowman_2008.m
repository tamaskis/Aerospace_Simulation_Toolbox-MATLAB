%==========================================================================
%
% jacchia_bowman_2008  Jacchia-Bowman atmospheric model.
%
%   [rho,T] = jacchia_bowman_2008(r_ecef,r_sun_eci,MJD_UT1,F107,...
%       F107_avg,S107,S107_avg,M107,M107_avg,Y107,Y107_avg,dTc)
%
% See also exponential, harris_priester, jacchia_roberts, nrlmsise00, 
% nrlmsise00_matlab, space_weather.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
% REFERENCES:
%   [1] Bowman et al., "A New Empirical Thermospheric Density Model JB2008
%       Using New Solar and Geomagnetic Indices"
%   [2] https://www.mathworks.com/matlabcentral/fileexchange/56163-jacchia-bowman-atmospheric-density-model?s_tid=srchtitle
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef      - (3×1 double) position resolved in ECEF frame [m]
%   r_sun_eci   - (3×1 double) Sun position resolved in ECI frame [m]
%   MJD_UT1     - (1×1 double) UT1 (Universal Time 1) [MJD]
%   F107        - (1×1 double) 10.7 cm solar flux (1-day lag) [SFU]
%   F107_avg    - (1×1 double) centered 81-day average of F10.7 (1-day lag)
%                 [SFU]
%   S107        - (1×1 double) daily 26-34 nm EUV index (1-day lag) [SFU]
%   S107_avg    - (1×1 double) centered 81-day average of S10.7 (1-day lag)
%                 [SFU]
%   M107        - (1×1 double) daily Mg II index (2-day lag) [SFU]
%   M107_avg    - (1×1 double) centered 81-day average of M10.7 (2-day lag)
%                 [SFU]
%   Y107        - (1×1 double) daily solar X-ray and Lyman-α emission mixed
%                 index (5-day lag) [SFU]
%   Y107_avg    - (1×1 double) centered 81-day average of Y10.7 (5-day lag)
%                 [SFU]
%   dTc         - (1×1 double) temperature change derived from Dst index 
%                 for current time [K]
%
% -------
% OUTPUT:
% -------
%   rho         - (1×1 double) atmospheric mass density [kg/m^3]
%   T           - (1×1 struct) temperatures [K]
%       • T     - (1×1 double) temperature at altitude [K]
%       • T_inf - (1×1 double) exospheric temperature [K]
%
%==========================================================================
function [rho,T] = jacchia_bowman_2008(r_ecef,r_sun_eci,MJD_UT1,F107,...
    F107_avg,S107,S107_avg,M107,M107_avg,Y107,Y107_avg,dTc)

    % ---------------------------------------------------------
    % Transforming inputs to inputs of original implementation.
    % ---------------------------------------------------------

    % geodetic latitude [deg], longitude [deg], and altitude [m]
    [lat,lon,h] = ecef2geod(r_ecef);
    
    % converts geodetic latitude and longitude to radians
    lat = deg2rad(lat);
    lon = deg2rad(lon);
    
    % wrap longitude to [0,2π]
    lon = mod(lon,2*pi);

    % converts geodetic altitude to kilometers
    h = 0.001*h;
    
    % geocentric right ascension and declination of the Sun [rad]
    [alpha_sun,delta_sun] = r2ad(r_sun_eci);
    
    % inputs for original implementation
    MJD = MJD_UT1;
    SUN = [alpha_sun,delta_sun];
    SAT = [lon,lat,h];
    F10 = F107;
    F10B = F107_avg;
    S10 = S107;
    S10B = S107_avg;
    XM10 = M107;
    XM10B = M107_avg;
    Y10 = Y107;
    Y10B = Y107_avg;
    DSTDTC = dTc;

    % ----------------------------------------------------------
    % Computation of atmospheric mass densitiy and temperatures.
    % ----------------------------------------------------------

    [TEMP,RHO] = original_implementation(MJD,SUN,SAT,F10,F10B,S10,S10B,...
        XM10,XM10B,Y10,Y10B,DSTDTC);

    % --------
    % Outputs.
    % --------

    % atmospheric mass density [kg/m^3]
    rho = RHO;
    
    % temperature at altitude [K]
    T.T_h = TEMP(2);
    
    % exopsheric temperature [K]
    T.T_inf = TEMP(1);

end





% --------------------------------------------
% Implementation of Jacchia-Bowman 2008 model.
% --------------------------------------------

function [TEMP,RHO] = original_implementation(MJD,SUN,SAT,F10,F10B,S10,...
    S10B,XM10,XM10B,Y10,Y10B,DSTDTC)
    ALPHA = [0.,0.,0.,0.,-0.38];
    AL10 = 2.3025851;
    AMW = [28.0134,31.9988,15.9994,39.9480,4.0026,1.00797];
    AVOGAD = 6.02257e26;
    TWOPI = 2*pi;
    PIOV2 = 1.5707963;
    FRAC = [0.78110,0.20955,9.3400e-3,1.2890e-5];
    RSTAR = 8314.32;
    R1 = 0.010;
    R2 = 0.025;
    R3 = 0.075;
    WT =[0.311111111111111,1.422222222222222,0.533333333333333,...
         1.422222222222222,0.311111111111111];
    CHT = [0.22,-0.20e-2,0.115e-2,-0.211e-5];
    DEGRAD = pi/180.;
    FN = (F10B/240)^(1/4);
    if (FN > 1)
        FN = 1.0;
    end
    FSB = F10B*FN+S10B*(1-FN);
    TSUBC = 392.4+3.227*FSB+0.298*(F10-F10B)+2.259*(S10-S10B)+0.312*...
        (XM10-XM10B)+0.178*(Y10-Y10B);
    ETA = 0.5*abs(SAT(2)-SUN(2));
    THETA = 0.5*abs(SAT(2)+SUN(2));
    H = SAT(1)-SUN(1);
    TAU = H-0.64577182+0.10471976*sin(H+0.75049158);
    GLAT = SAT(2);
    ZHT = SAT(3);
    GLST = H+pi;
    GLSTHR = (GLST/DEGRAD)*(24/360);
    if (GLSTHR >= 24)
        GLSTHR = GLSTHR-24;
    end
    if (GLSTHR < 0)
        GLSTHR = GLSTHR+24;
    end
    C = cos(ETA)^2.5;
    S = sin(THETA)^2.5;
    DF = S+(C-S)*abs(cos(0.5*TAU))^3;
    TSUBL = TSUBC*(1+0.31*DF);
    DTCLST = DTSUB (F10,GLSTHR,GLAT,ZHT);
    TEMP(1) = TSUBL+DSTDTC;
    TINF = TSUBL+DSTDTC+DTCLST;
    TSUBX = 444.3807+0.02385*TINF-392.8292*exp(-0.0021357*TINF);
    GSUBX = 0.054285714*(TSUBX-183);
    TC(1) = TSUBX;
    TC(2) = GSUBX;
    TC(3) = (TINF-TSUBX)/PIOV2;
    TC(4) = GSUBX/TC(3);
    Z1 = 90;
    Z2 = min(SAT(3),105);
    AL = log(Z2/Z1);
    N = floor(AL/R1)+1;
    ZR = exp(AL/N);
    AMBAR1 = XAMBAR(Z1);
    TLOC1 = XLOCAL(Z1,TC);
    ZEND = Z1;
    SUM2 = 0;
    AIN = AMBAR1*XGRAV(Z1)/TLOC1;
    for I = 1:N
        Z = ZEND;
        ZEND = ZR*Z;
        DZ = 0.25*(ZEND-Z);
        SUM1 = WT(1)*AIN;
        for J = 2:5
            Z = Z+DZ;
            AMBAR2 = XAMBAR(Z);
            TLOC2 = XLOCAL(Z,TC);
            GRAVL = XGRAV(Z);
            AIN = AMBAR2*GRAVL/TLOC2;        
            SUM1 = SUM1+WT(J)*AIN;
        end
        SUM2 = SUM2+DZ*SUM1;
    end
    FACT1 = 1000/RSTAR;
    RHO = 3.46e-6*AMBAR2*TLOC1*exp(-FACT1*SUM2)/AMBAR1/TLOC2;
    ANM = AVOGAD*RHO;
    AN = ANM/AMBAR2;
    FACT2 = ANM/28.960;
    ALN(1) = log(FRAC(1)*FACT2);
    ALN(4) = log(FRAC(3)*FACT2);
    ALN(5) = log(FRAC(4)*FACT2);
    ALN(2) = log(FACT2*(1+FRAC(2))-AN);
    ALN(3) = log(2*(AN-FACT2));
    if (SAT(3) > 105)
    else
        TEMP(2) = TLOC2;
        ALN(6) = ALN(5)-25;
        TRASH = (MJD-36204) / 365.2422;
        CAPPHI = mod(TRASH,1);
        DLRSL = 0.02*(SAT(3)-90)*exp(-0.045*(SAT(3)-90))*...
            sign_(1,SAT(2))*sin(TWOPI*CAPPHI+1.72)*sin(SAT(2))^2;
        DLRSA = 0;
        if (Z < 2000)        
            YRDAY = TMOUTD (MJD);
            [FZZ,GTZ,DLRSA] = SEMIAN08 (YRDAY,ZHT,F10B,S10B,XM10B);
            if (FZZ < 0)
                DLRSA = 0;
            end
        end
        DLR = AL10*(DLRSL+DLRSA);
        for I = 1:6
            ALN(I) = ALN(I)+DLR;
        end
        SUMN = 0;
        SUMNM = 0;
        for I = 1:6
            AN = exp(ALN(I));
            SUMN = SUMN+AN;
            SUMNM = SUMNM+AN*AMW(I);
            AL10N(I) = ALN(I)/AL10;
        end
        RHO = SUMNM/AVOGAD;
        FEX = 1;
        if ((ZHT >= 1000)&&(ZHT < 1500))
            ZETA = (ZHT-1000)*0.002;
            ZETA2 = ZETA*ZETA;
            ZETA3 = ZETA*ZETA2;
            F15C = CHT(1)+CHT(2)*F10B+CHT(3)*1500+CHT(4)*F10B*1500;
            F15C_ZETA = (CHT(3)+CHT(4)*F10B)*500;
            FEX2 = 3*F15C-F15C_ZETA-3;
            FEX3 = F15C_ZETA-2*F15C+2;
            FEX = 1+FEX2*ZETA2+FEX3*ZETA3;
        end
        if (ZHT >= 1500)
            FEX = CHT(1)+CHT(2)*F10B+CHT(3)*ZHT+CHT(4)*F10B*ZHT;
        end
        RHO = FEX*RHO;
        return
    end
    Z3 = min(SAT(3),500);
    AL = log(Z3/Z);
    N = floor(AL/R2)+1;
    ZR = exp(AL/N);
    SUM2 = 0;
    AIN = GRAVL/TLOC2;
    for I = 1:N
        Z = ZEND;
        ZEND = ZR*Z;
        DZ = 0.25*(ZEND-Z);
        SUM1 = WT(1)*AIN;
        for J = 2:5
            Z = Z+DZ;
            TLOC3 = XLOCAL(Z,TC);
            GRAVL = XGRAV(Z);
            AIN = GRAVL/TLOC3;
            SUM1 = SUM1+WT(J)*AIN;
        end
        SUM2 = SUM2+DZ*SUM1;
    end
    Z4 = max(SAT(3),500);
    AL = log(Z4/Z);
    R = R2;
    if (SAT(3) > 500)
        R = R3;
    end
    N = floor(AL/R)+1;
    ZR = exp(AL/N);
    SUM3 = 0;
    for I=1:N
        Z = ZEND;
        ZEND = ZR*Z;
        DZ = 0.25*(ZEND-Z);
        SUM1 = WT(1)*AIN;
        for J = 2:5
            Z = Z+DZ;
            TLOC4 = XLOCAL(Z,TC);
            GRAVL = XGRAV(Z);
            AIN = GRAVL/TLOC4;
            SUM1 = SUM1+WT(J)*AIN;
        end
        SUM3 = SUM3+DZ*SUM1;
    end
    if (SAT(3) > 500)
        T500 = TLOC3;
        TEMP(2) = TLOC4;
        ALTR = log(TLOC4/TLOC2);
        FACT2 = FACT1*(SUM2+SUM3);
        HSIGN = -1;
    else
        T500 = TLOC4;
        TEMP(2) = TLOC3;
        ALTR = log(TLOC3/TLOC2);
        FACT2 = FACT1*SUM2;
        HSIGN = 1;
    end
    for I = 1:5
        ALN(I) = ALN(I)-(1+ALPHA(I))*ALTR-FACT2*AMW(I);
    end
    AL10T5 = log10(TINF);
    ALNH5 = (5.5*AL10T5-39.40)*AL10T5+73.13;
    ALN(6) = AL10*(ALNH5+6)+HSIGN*(log(TLOC4/TLOC3)+FACT1*SUM3*AMW(6));
    TRASH = (MJD-36204) / 365.2422;
    CAPPHI = mod(TRASH,1);
    DLRSL = 0.02*(SAT(3)-90)*exp(-0.045*(SAT(3)-90))*sign_(1,SAT(2))*...
        sin(TWOPI*CAPPHI+1.72)*sin(SAT(2))^2;
    DLRSA = 0;
    if (Z < 2000)    
        YRDAY = TMOUTD (MJD);
        [FZZ,GTZ,DLRSA] = SEMIAN08 (YRDAY,ZHT,F10B,S10B,XM10B);
        if (FZZ < 0)
            DLRSA = 0;
        end
    end
    DLR = AL10*(DLRSL+DLRSA);
    for I = 1:6
        ALN(I) = ALN(I)+DLR;
    end
    SUMN = 0.;
    SUMNM = 0.;
    for I = 1:6
        AN = exp(ALN(I));
        SUMN = SUMN+AN;
        SUMNM = SUMNM+AN*AMW(I);
        AL10N(I) = ALN(I)/AL10;
    end
    RHO = SUMNM/AVOGAD;
    FEX = 1;
    if ((ZHT >= 1000)&&(ZHT < 1500))
        ZETA = (ZHT-1000)*0.002;
        ZETA2 = ZETA*ZETA;
        ZETA3 = ZETA*ZETA2;
        F15C = CHT(1)+CHT(2)*F10B+CHT(3)*1500+CHT(4)*F10B*1500;
        F15C_ZETA = (CHT(3)+CHT(4)*F10B)*500;
        FEX2 = 3*F15C-F15C_ZETA-3;
        FEX3 = F15C_ZETA-2*F15C+2;
        FEX = 1+FEX2*ZETA2+FEX3*ZETA3;
    end
    if (ZHT >= 1500)
        FEX = CHT(1)+CHT(2)*F10B+CHT(3)*ZHT+CHT(4)*F10B*ZHT;
    end
    RHO = FEX*RHO;
end

function XAMBAR2 = XAMBAR(Z)
    C = [28.15204,-8.5586e-2,+1.2840e-4,-1.0056e-5,-1.0210e-5,...
        +1.5044e-6,+9.9826e-8];
    DZ = Z-100;
    AMB = C(7);
    for I = 1:6
        J = 7-I;
        AMB = DZ*AMB+C(J);
    end
    XAMBAR2 = AMB;
end

function XGRAV2 = XGRAV(Z)
    XGRAV2 = 9.80665/(1+Z/6356.766)^2;
end

function XLOCAL2 = XLOCAL(Z,TC)
    DZ = Z-125;
    if (DZ > 0)
        XLOCAL2 = TC(1)+TC(3)*atan(TC(4)*DZ*(1+4.5e-6*DZ^2.5));
        return
    end
    XLOCAL2 = ((-9.8204695e-6*DZ-7.3039742e-4)*DZ^2+1)*DZ*TC(2)+TC(1);
end

function DTC = DTSUB (F10,XLST,XLAT,ZHT)
    B = [-0.457512297e1, -0.512114909e1, -0.693003609e2,  0.203716701e3,...
          0.703316291e3, -0.194349234e4,  0.110651308e4, -0.174378996e3,...
          0.188594601e4, -0.709371517e4,  0.922454523e4, -0.384508073e4,...
         -0.645841789e1,  0.409703319e2, -0.482006560e3,  0.181870931e4,...
         -0.237389204e4,  0.996703815e3, 0.361416936e2];
    C = [-0.155986211e2, -0.512114909e1, -0.693003609e2,  0.203716701e3,...
          0.703316291e3, -0.194349234e4,  0.110651308e4, -0.220835117e3,...
          0.143256989e4, -0.318481844e4,  0.328981513e4, -0.135332119e4,...
          0.199956489e2, -0.127093998e2,  0.212825156e2, -0.275555432e1,...
          0.110234982e2,  0.148881951e3, -0.751640284e3,  0.637876542e3,...
          0.127093998e2, -0.212825156e2,  0.275555432e1];
    DTC = 0;
    tx = XLST/24;
    ycs = cos(XLAT);
    F = (F10-100)/100;
    if (ZHT >= 120 && ZHT <= 200)
        H = (ZHT-200)/50;
        DTC200 = C(17)+C(18)*tx*ycs+C(19)*tx^2*ycs+C(20)*tx^3*ycs+C(21)*...
            F*ycs+C(22)*tx*F*ycs+C(23)*tx^2*F*ycs;
        sum = C(1)+B(2)*F+C(3)*tx*F+C(4)*tx^2*F+C(5)*tx^3*F+C(6)*tx^4*F+...
            C(7)*tx^5*F+C(8)*tx*ycs+C(9)*tx^2*ycs+C(10)*tx^3*ycs+C(11)*...
            tx^4*ycs+C(12)*tx^5*ycs+C(13)*ycs+C(14)*F*ycs+C(15)*tx*F*...
            ycs+C(16)*tx^2*F*ycs;
        DTC200DZ = sum;
        CC = 3*DTC200-DTC200DZ;
        DD = DTC200-CC;
        ZP = (ZHT-120)/80;
        DTC = CC*ZP*ZP+DD*ZP*ZP*ZP;
    end
    if (ZHT > 200 && ZHT <= 240)
        H = (ZHT-200)/50;
        sum = C(1)*H+B(2)*F*H+C(3)*tx*F*H+C(4)*tx^2*F*H+C(5)*tx^3*F*H+...
            C(6)*tx^4*F*H+C(7)*tx^5*F*H+C(8)*tx*ycs*H+C(9)*tx^2*ycs*H+...
            C(10)*tx^3*ycs*H+C(11)*tx^4*ycs*H+C(12)*tx^5*ycs*H+C(13)*...
            ycs*H+C(14)*F*ycs*H+C(15)*tx*F*ycs*H+C(16)*tx^2*F*ycs*H+...
            C(17)+C(18)*tx*ycs+C(19)*tx^2*ycs+C(20)*tx^3*ycs+C(21)*F*...
            ycs+C(22)*tx*F*ycs+C(23)*tx^2*F*ycs;
        DTC = sum;
    end
    if (ZHT > 240 && ZHT <= 300)
        H = 40/50;
        sum = C(1)*H+B(2)*F*H+C(3)*tx*F*H+C(4)*tx^2*F*H+C(5)*tx^3*F*H+...
            C(6)*tx^4*F*H+C(7)*tx^5*F*H+C(8)*tx*ycs*H+C(9)*tx^2*ycs*H+...
            C(10)*tx^3*ycs*H+C(11)*tx^4*ycs*H+C(12)*tx^5*ycs*H+C(13)*...
            ycs*H+C(14)*F*ycs*H+C(15)*tx*F*ycs*H+C(16)*tx^2*F*ycs*H+...
            C(17)+C(18)*tx*ycs+C(19)*tx^2*ycs+C(20)*tx^3*ycs+C(21)*F*...
            ycs+C(22)*tx*F*ycs+C(23)*tx^2*F*ycs;
        AA = sum;
        BB = C(1)+B(2)*F+C(3)*tx*F+C(4)*tx^2*F+C(5)*tx^3*F+C(6)*tx^4*F+...
            C(7)*tx^5*F+C(8)*tx*ycs+C(9)*tx^2*ycs+C(10)*tx^3*ycs+C(11)*...
            tx^4*ycs+C(12)*tx^5*ycs+C(13)*ycs+C(14)*F*ycs+C(15)*tx*F*...
            ycs+C(16)*tx^2*F*ycs;
        H = 300/100;
        sum = B(1)+B(2)*F+B(3)*tx*F+B(4)*tx^2*F+B(5)*tx^3*F+B(6)*tx^4*F+...
            B(7)*tx^5*F+B(8)*tx*ycs+B(9)*tx^2*ycs+B(10)*tx^3*ycs+B(11)*...
            tx^4*ycs+B(12)*tx^5*ycs+B(13)*H*ycs+B(14)*tx*H*ycs+B(15)*tx^...
            2*H*ycs+B(16)*tx^3*H*ycs+B(17)*tx^4*H*ycs+B(18)*tx^5*H*ycs+...
            B(19)*ycs;
        DTC300 = sum;
        sum = B(13)*ycs+B(14)*tx*ycs+B(15)*tx^2*ycs+B(16)*tx^3*ycs+...
            B(17)*tx^4*ycs+B(18)*tx^5*ycs;
        DTC300DZ = sum;
        CC = 3.*DTC300-DTC300DZ-3.*AA-2.*BB;
        DD = DTC300-AA-BB-CC;
        ZP = (ZHT-240)/60;
        DTC = AA+BB*ZP+CC*ZP*ZP+DD*ZP*ZP*ZP;
    end
    if (ZHT > 300 && ZHT <= 600)
        H = ZHT/100;
        sum = B(1)+B(2)*F+B(3)*tx*F+B(4)*tx^2*F+B(5)*tx^3*F+B(6)*tx^4*F+...
            B(7)*tx^5*F+B(8)*tx*ycs+B(9)*tx^2*ycs+B(10)*tx^3*ycs+B(11)*...
            tx^4*ycs+B(12)*tx^5*ycs+B(13)*H*ycs+B(14)*tx*H*ycs+B(15)*...
            tx^2*H*ycs+B(16)*tx^3*H*ycs+B(17)*tx^4*H*ycs+B(18)*tx^5*H*...
            ycs+B(19)*ycs;
        DTC = sum;
    end
    if (ZHT > 600 && ZHT <= 800)
        ZP = (ZHT-600)/100;
        HP = 600./100.;
        AA = B(1)+B(2)*F+B(3)*tx*F+B(4)*tx^2*F+B(5)*tx^3*F+B(6)*tx^4*F+...
            B(7)*tx^5*F+B(8)*tx*ycs+B(9)*tx^2*ycs+B(10)*tx^3*ycs+B(11)*...
            tx^4*ycs+B(12)*tx^5*ycs+B(13)*HP*ycs+B(14)*tx*HP*ycs+B(15)*...
            tx^2*HP*ycs+B(16)*tx^3*HP*ycs+B(17)*tx^4*HP*ycs+B(18)*tx^5*...
            HP*ycs+B(19)*ycs;
        BB = B(13)*ycs+B(14)*tx*ycs+B(15)*tx^2*ycs+B(16)*tx^3*ycs+B(17)*...
            tx^4*ycs+B(18)*tx^5*ycs;
        CC = -(3*AA+4*BB)/4;
        DD = (AA+BB)/4;
        DTC = AA+BB*ZP+CC*ZP*ZP+DD*ZP*ZP*ZP;
    end
end

function [FZZ,GTZ,DRLOG] = SEMIAN08(DAY,HT,F10B,S10B,XM10B)
    TWOPI = 2*pi;
    FZM = [0.2689,-0.1176e-1,0.2782e-1,-0.2782e-1,0.3470e-3];
    GTM = [-0.3633,0.8506e-1,0.2401,-0.1897,-0.2554,-0.1790e-1,...
        0.5650e-3,-0.6407e-3,-0.3418e-2,-0.1252e-2];
    FSMB = F10B-0.70*S10B-0.04*XM10B;
    HTZ = HT/1000;
    FZZ = FZM(1)+FZM(2)*FSMB+FZM(3)*FSMB*HTZ+FZM(4)*FSMB*HTZ^2+FZM(5)*...
        FSMB^2*HTZ;
    FSMB = F10B-0.75*S10B-0.37*XM10B;
    TAU = (DAY-1)/365;
    SIN1P = sin(TWOPI*TAU);
    COS1P = cos(TWOPI*TAU);
    SIN2P = sin(2*TWOPI*TAU);
    COS2P = cos(2*TWOPI*TAU);
    GTZ = GTM(1)+GTM(2)*SIN1P+GTM(3)*COS1P+GTM(4)*SIN2P+GTM(5)*COS2P+...
        GTM(6)*FSMB+GTM(7)*FSMB*SIN1P+GTM(8)*FSMB*COS1P+GTM(9)*FSMB*...
        SIN2P+GTM(10)*FSMB*COS2P;
    if (FZZ < 1e-6)
        FZZ = 1e-6;
    end
    DRLOG = FZZ*GTZ;
end

function doy = TMOUTD(MJD)
    cal = mjd2cal(MJD);
    doy = cal2doy(cal)+mjd2f(MJD);
end

function result = sign_(a,b)
    if (b >= 0)
        result = abs(a);
    else
        result = -abs(a);
    end
end