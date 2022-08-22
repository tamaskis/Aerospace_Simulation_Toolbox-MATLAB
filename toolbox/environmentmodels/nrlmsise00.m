%==========================================================================
%
% nrlmsise00  NRLMSISE-00 atmospheric model.
%
%   [rho,n,T] = nrlmsise00(r_ecef,MJD_UT1,F107_avg,F107,ap_array,nrlm_data)
%
% See also exponential, harris_priester, jacchia_bowman_2008, 
% jacchia_roberts, load_nrlm_data, nrlmsise00_matlab, space_weather.
%
% Author: Tamas Kis
% Last Update: 2022-02-19
%
% REFERENCES:
%   [1] Picone et al., "NRLMSISE-00 empirical model of the atmosphere: 
%       Statistical comparisons and scientific issues"
%   [2] https://www.mathworks.com/matlabcentral/fileexchange/56253-nrlmsise-00-atmosphere-model?s_tid=srchtitle
%   [3] nrlmsise-00.h, nrlmsise-00.c, nrlmsise-00_data.c
%       (https://git.linta.de/?p=~brodo/nrlmsise-00.git;a=summary)
%
%--------------------------------------------------------------------------
%
% ------
% INPUT:
% ------
%   r_ecef      - (3×1 double) position resolved in ECEF frame [m]
%   MJD_UT1     - (1×1 double) UT1 (Universal Time 1) [MJD]
%   F107_avg    - (1×1 double) centered 81-day average of F10.7 (1-day lag)
%                 [SFU]
%   F107        - (1×1 double) daily 10.7 cm solar flux (1-day lag) [SFU]
%   ap_array    - (1×1 double) array of planetary amplitude values [γ]
%                   1. daily planetary amplitude (current day - no lag) [γ]
%                   2. planetary amplitude (current time) [γ]
%                   3. planetary amplitude (3 hours before) [γ]
%                   4. planetary amplitude (6 hours before) [γ]
%                   5. planetary amplitude (9 hours before) [γ]
%                   6. planetary amplitude (avg. of 12-33 hours before) [γ]
%                   7. planetary amplitude (avg. of 36-57 hours before) [γ]
%   nrlm_data   - (1×1 struct) data for NRLMSISE-00 atmospheric model
%       • pt    (1×150 double)
%       • pd    (9×150 double)
%       • ps    (1×150 double)
%       • pdl   (2×25 double)
%       • ptm   (1×10 double)
%       • pdm   (8×10 double)
%       • ptl   (4×100 double)
%       • pma   (10×100 double)
%       • sam   (1×100 double)
%       • pavgm (1×10 double)
%
% -------
% OUTPUT:
% -------
%   rho         - (1×1 double) atmospheric mass density [kg/m^3]
%   n           - (1×1 struct) number densities [m^-3]
%       • nAr   - (1×1 double) atomic argon number density [m^-3]
%       • nH    - (1×1 double) atomic hydrogen number density [m^-3]
%       • nHe   - (1×1 double) atomic helium number density [m^-3]
%       • nN2   - (1×1 double) diatomic nitrogen number density [m^-3]
%       • nO    - (1×1 double) atomic oxygen number density [m^-3]
%       • nO2   - (1×1 double) diatomic oxygen number density [m^-3]
%   T           - (1×1 struct) temperatures [K]
%       • T_h   - (1×1 double) temperature at altitude [K]
%       • T_inf - (1×1 double) exospheric temperature [K]
%
%==========================================================================
function [rho,n,T] = nrlmsise00(r_ecef,MJD_UT1,F107_avg,F107,ap_array,...
    nrlm_data)
    
    % ----------------------------------------------------
    % Calculates inputs for NRLMSISE-00 atmospheric model.
    % ----------------------------------------------------
    
    % Gregorian date of UT1 [y,mo,d,h,m,s]
    cal_UT1 = mjd2cal(MJD_UT1);

    % year [y]
    YYYY = MJD_UT1(1);
    
    % day of year [d]
    DOY = cal2doy(cal_UT1);

    % seconds of day [s]
    ss = cal_UT1(4)*3600+cal_UT1(5)*60+cal_UT1(6);

    % geodetic latitude [rad], longitude [rad], and altitude [m]
    [lat,lon,h] = ecef2geod(r_ecef);

    % converts altitude to meters
    h = 0.001*h;

    % (approximate) local apparent solar time [h]
    LAST = ss/3600+lon/15;

    % daily planetary amplitude (current day - no lag) [γ]
    Ap = ap_array(1);

    % ------------------------
    % Default switch settings.
    % ------------------------
    
    flags = struct('switches',zeros(24,1),'sw',zeros(24,1),'swc',...
        zeros(24,1));
    flags.switches(1)=0;
    for i=2:24
        flags.switches(i)=1;
    end

    % ---------------
    % Parsing inputs.
    % ---------------

    input.year = YYYY;
    input.doy = DOY;
    input.sec = ss;
    input.alt = h;
    input.g_lat = lat;
    input.g_long = lon;
    input.lst = LAST;
    input.F107A = F107_avg;
    input.F107 = F107;
    input.ap = Ap;
    input.ap_a.a = ap_array;

    % ------------------------------------------------------
    % Computation of atmospheric densities and temperatures.
    % ------------------------------------------------------

    % computation using NRLMSISE-00 model
    output = gtd7(input,flags,nrlm_data);
    
    % number densities [cm^-3]
    nHe = output.d(1);
    nO = output.d(2);
    nN2 = output.d(3);
    nO2 = output.d(4);
    nAr = output.d(5);
    nH = output.d(7);
    
    % total mass density [gm/cm^3]
    rho = output.d(6);
    
    % exospheric temperature [K]
    T_inf = output.t(1,1);

    % temperature at altitude [K]
    T_h = output.t(2,1);

    % converts number densities to m^-3
    nHe = (1e6)*nHe;
    nO = (1e6)*nO;
    nN2 = (1e6)*nN2;
    nO2 = (1e6)*nO2;
    nAr = (1e6)*nAr;
    nH = (1e6)*nH;

    % converts total mass density to [kg/m^3]
    rho = 1000*rho;

    % ----------------
    % Parsing outputs.
    % ----------------

    % temperatures [K]
    T.T_h = T_h;
    T.T_inf = T_inf;

    % number densities [m^-3]
    n.nAr = nAr;
    n.nH = nH;
    n.nHe = nHe;
    n.nN2 = nN2;
    n.nO = nO;
    n.nO2 = nO2;

end





% ------------------------------------
% Implementation of NRLMSISE-00 model.
% ------------------------------------

function flags = tselec(flags)
    for i=1:24
        if (i~=10)
            if (flags.switches(i)==1)
                flags.sw(i)=1;
            else
                flags.sw(i)=0;
            end        
            if (flags.switches(i)>0)
                flags.swc(i)=1;
            else
                flags.swc(i)=0;
            end
        else
            flags.sw(i)=flags.switches(i);
            flags.swc(i)=flags.switches(i);
        end
    end
end

function [gv,reff] = glatf(lat)
    dgtr = 1.74533E-2;
    c2 = cos(2.0*dgtr*lat);
    gv = 980.616*(1.0-0.0026373*c2);
    reff = 2.0*(gv)/(3.085462E-6+2.27E-9*c2)*1.0E-5;
end

function out = ccor(alt,r,h1,zh)
    e = (alt-zh)/h1;
    if (e>70)
        out = exp(0);
        return
    end
    if (e<-70)
        out = exp(r);
        return
    end
    ex = exp(e);
    e = r/(1.0+ex);
    out = exp(e);
end

function out = ccor2(alt,r,h1,zh,h2)
    e1 = (alt-zh)/h1;
    e2 = (alt-zh)/h2;
    if ((e1 > 70) || (e2 > 70))
        out = exp(0);
        return
    end
    if ((e1 <-70) && (e2 <-70))
        out = exp(r);
        return
    end
    ex1 = exp(e1);
    ex2 = exp(e2);
    ccor2v = r/(1.0+0.5*(ex1+ex2));
    out = exp(ccor2v);
end

function g = scalh(alt,xm,temp)
    global gsurf re
    rgas = 831.4;
    g = gsurf/((1.0+alt/re)^2.0);
    g = rgas*temp/(g*xm);
end

function out = dnet (dd,dm,zhm,xmm,xm)
    a  = zhm/(xmm-xm);
    if (~((dm>0) && (dd>0)))
        fprintf('dnet log error %e %e %e\n',dm,dd,xm);
        if ((dd==0) && (dm==0))
            dd=1;
        end
        if (dm==0)
            out = dd;
            return
        end
        if (dd==0)
            out = dm;
            return
        end
    end
    ylog = a*log(dm/dd);
    if (ylog<-10)
        out = dd;
        return
    end
    if (ylog>10)
        out = dm;
        return
    end
    a = dd*(1.0+exp(ylog))^(1.0/a);
    out = a;
end

function y = splini(xa,ya,y2a,n,x)
    yi=0;
    klo=0;
    khi=1;
    while ((x>xa(klo+1)) && (khi<n))
        xx=x;
        if (khi<(n-1))
            if (x<xa(khi+1))
                xx=x;
            else
                xx=xa(khi+1);
            end
        end
        h = xa(khi+1)-xa(klo+1);
        a = (xa(khi+1)-xx)/h;
        b = (xx-xa(klo+1))/h;
        a2 = a*a;
        b2 = b*b;
        yi = yi+((1.0-a2)*ya(klo+1)/2.0+b2*ya(khi+1)/2.0+((-(1.0+a2*a2)/...
            4.0+a2/2.0)*y2a(klo+1)+(b2*b2/4.0-b2/2.0)*y2a(khi+1))*h*h/...
            6.0)*h;
        klo= klo+1;
        khi= khi+1;
    end
    y = yi;
end

function y = splint (xa,ya,y2a,n,x)
    klo=0;
    khi=n-1;
    while ((khi-klo)>1)
        k=int8((khi+klo)/2);
        if (xa(k+1)>x)
            khi=k;
        else
            klo=k;
        end
    end
    h = xa(khi+1)-xa(klo+1);
    if (h==0.0)
        fprintf('bad XA input to splint');
    end
    a = (xa(khi+1)-x)/h;
    b = (x-xa(klo+1))/h;
    yi = a*ya(klo+1)+b*ya(khi+1)+((a*a*a-a)*y2a(klo+1)+(b*b*b-b)*...
        y2a(khi+1))*h*h/6.0;
    y = yi;
end

function y2 = spline (x,y,n,yp1,ypn)
    u = zeros(5,1);
    y2 = zeros(5,1);
    if (yp1>0.99E30)
        y2(1)=0;
        u(1)=0;
    else
        y2(1)=-0.5;
        u(1) = (3.0/(x(2)-x(1)))*((y(2)-y(1))/(x(2)-x(1))-yp1);
    end
    for i=2:n-1
	    sig = (x(i)-x(i-1))/(x(i+1)-x(i-1));
	    p = sig*y2(i-1)+2.0;
	    y2(i) = (sig-1.0)/p;
	    u(i) = (6.0*((y(i+1)-y(i))/(x(i+1)-x(i))-(y(i)-y(i-1))/(x(i)-...
            x(i-1)))/(x(i+1)-x(i-1))-sig*u(i-1))/p;
    end
    if (ypn>0.99E30)
        qn = 0;
        un = 0;
    else
        qn = 0.5;
        un = (3.0/(x(n)-x(n-1)))*(ypn-(y(n)-y(n-1))/(x(n)-x(n-1)));
    end
    y2(n) = (un-qn*u(n-1))/(qn*y2(n-1)+1.0);
    for k=n-1:-1:1
        y2(k) = y2(k)*y2(k+1)+u(k);
    end
end

function [densm_tmp,tz] = densm(alt,d0,xm,tz,mn3,zn3,tn3,tgn3,mn2,zn2,...
    tn2,tgn2)
    global gsurf re
    zeta = @(zz,zl) (zz-zl)*(6367.088132098377173+zl)/...
        (6367.088132098377173+zz);
    xs = zeros(10,1);
    ys = zeros(10,1);
    y2out = zeros(10,1);
    rgas = 831.4;
    densm_tmp = d0;
    if (alt>zn2(1))
        if (xm==0.0)
            densm_tmp = tz;
            return            
        else
            densm_tmp = d0;
            return
        end
    end
    if (alt>zn2(mn2))
        z = alt;
    else
        z = zn2(mn2);
    end
    mn=mn2;
    z1=zn2(1);
    z2=zn2(mn);
    t1=tn2(1);
    t2=tn2(mn);
    zg = zeta(z,z1);
    zgdif = zeta(z2,z1);
    for k=1:mn
        xs(k)=zeta(zn2(k),z1)/zgdif;
        ys(k)=1.0/tn2(k);
    end
    yd1 =-tgn2(1)/(t1*t1)*zgdif;
    yd2 =-tgn2(2)/(t2*t2)*zgdif*(((re+z2)/(re+z1))^2.0);
    y2out = spline (xs,ys,mn,yd1,yd2);
    x = zg/zgdif;
    y = splint (xs,ys,y2out,mn,x);
    tz = 1.0/y;
    if (xm~=0.0)
        glb = gsurf/((1.0+z1/re)^2.0);
        gamm = xm*glb*zgdif/rgas;
        yi = splini(xs,ys,y2out,mn,x);
        expl = gamm*yi;
        if (expl>50.0)
            expl = 50.0;
        end
        densm_tmp = densm_tmp*(t1/tz)*exp(-expl);
    end
    
    if (alt>zn3(1))
        if (xm==0.0)
            densm_tmp = tz;
            return        
        else
            return
        end
    end
    z = alt;
    mn = mn3;
    z1 = zn3(1);
    z2 = zn3(mn);
    t1 = tn3(1);
    t2 = tn3(mn);
    zg = zeta(z,z1);
    zgdif = zeta(z2,z1);
    for k=1:mn
        xs(k) = zeta(zn3(k),z1)/zgdif;
        ys(k) = 1.0/tn3(k);
    end
    yd1 =-tgn3(1)/(t1*t1)*zgdif;
    yd2 =-tgn3(2)/(t2*t2)*zgdif*(((re+z2)/(re+z1))^2.0);
    y2out =	spline (xs,ys,mn,yd1,yd2);
    x = zg/zgdif;
    y =	splint (xs,ys,y2out,mn,x);
    tz = 1.0/y;
    if (xm~=0.0)
        glb = gsurf/((1.0+z1/re)^2.0);
        gamm = xm*glb*zgdif/rgas;
        yi = splini(xs,ys,y2out,mn,x);
        expl = gamm*yi;
        if (expl>50.0)
            expl = 50.0;
        end
        densm_tmp = densm_tmp*(t1/tz)*exp(-expl);
    end
    if (xm==0.0)
        densm_tmp = tz;
        return
    else
        return
    end
end

function [densu_temp,tz] = densu (alt,dlb,tinf,tlb,xm,alpha,tz,zlb,s2,...
    mn1,zn1,tn1,tgn1)
    global gsurf re
    rgas = 831.4;
    densu_temp=1.0;
    xs = zeros(5,1);
    ys = zeros(5,1);
    y2out = zeros(5,1);
    za=zn1(1);
    if (alt>za)
        z=alt;
    else
        z=za;
    end
    zg2 = zeta(z,zlb);
    tt = tinf-(tinf-tlb)*exp(-s2*zg2);
    ta = tt;
    tz = tt;
    densu_temp = tz;
    if (alt<za)
	    dta = (tinf-ta)*s2*((re+zlb)/(re+za))^2.0;
	    tgn1(1)=dta;
	    tn1(1)=ta;
	    if (alt>zn1(mn1))
            z=alt;
        else
            z=zn1(mn1);
        end
	    mn=mn1;
	    z1=zn1(1);
	    z2=zn1(mn);
	    t1=tn1(1);
	    t2=tn1(mn);
	    zg = zeta (z,z1);
	    zgdif = zeta(z2,z1);
	    for k=1:mn
		    xs(k) = zeta(zn1(k),z1)/zgdif;
		    ys(k) = 1.0/tn1(k);
        end
	    yd1 =-tgn1(1)/(t1*t1)*zgdif;
	    yd2 =-tgn1(2)/(t2*t2)*zgdif*((re+z2)/(re+z1))^2.0;
	    y2out = spline (xs,ys,mn,yd1,yd2);
        x = zg/zgdif;
	    y = splint (xs,ys,y2out,mn,x);
	    tz = 1.0/y;
	    densu_temp = tz;
    end
    if (xm==0)
	    return
    end
    glb = gsurf/(1.0+zlb/re)^2.0;
    gamma = xm*glb/(s2*rgas*tinf);
    expl = exp(-s2*gamma*zg2);
    if (expl>50.0)
	    expl=50.0;
    end
    if (tt<=0)
	    expl=50.0;
    end
    densa = dlb*(tlb/tt)^(1.0+alpha+gamma)*expl;
    densu_temp=densa;
    if (alt>=za)
	    return
    end
    glb = gsurf/(1.0+z1/re)^2.0;
    gamm = xm*glb*zgdif/rgas;
    yi = splini (xs,ys,y2out,mn,x);
    expl = gamm*yi;
    if (expl>50.0)
	    expl=50.0;
    end
    if (tz<=0)
	    expl=50.0;
    end
    densu_temp = densu_temp*(t1/tz)^(1.0+alpha)*exp(-expl);
end

function tinf = globe7(p,input,flags)
    global dfa plg ctloc stloc c2tloc s2tloc s3tloc c3tloc apdf apt
    t = zeros(15,1);
    sr = 7.2722E-5;
    dgtr = 1.74533E-2;
    dr = 1.72142E-2;
    hr = 0.2618;
    tloc = input.lst;
    for j=1:14
        t(j) = 0;
    end
    c = sin(input.g_lat*dgtr);
    s = cos(input.g_lat*dgtr);
    c2 = c*c;
    c4 = c2*c2;
    s2 = s*s;
    plg(1,2) = c;
    plg(1,3) = 0.5*(3.0*c2-1.0);
    plg(1,4) = 0.5*(5.0*c*c2-3.0*c);
    plg(1,5) = (35.0*c4-30.0*c2+3.0)/8.0;
    plg(1,6) = (63.0*c2*c2*c-70.0*c2*c+15.0*c)/8.0;
    plg(1,7) = (11.0*c*plg(1,6)-5.0*plg(1,5))/6.0;
    plg(2,2) = s;
    plg(2,3) = 3.0*c*s;
    plg(2,4) = 1.5*(5.0*c2-1.0)*s;
    plg(2,5) = 2.5*(7.0*c2*c-3.0*c)*s;
    plg(2,6) = 1.875*(21.0*c4-14.0*c2+1.0)*s;
    plg(2,7) = (11.0*c*plg(2,6)-6.0*plg(2,5))/5.0;
    plg(3,3) = 3.0*s2;
    plg(3,4) = 15.0*s2*c;
    plg(3,5) = 7.5*(7.0*c2-1.0)*s2;
    plg(3,6) = 3.0*c*plg(3,5)-2.0*plg(3,4);
    plg(3,7) = (11.0*c*plg(3,6)-7.0*plg(3,5))/4.0;
    plg(3,8) = (13.0*c*plg(3,7)-8.0*plg(3,6))/5.0;
    plg(4,4) = 15.0*s2*s;
    plg(4,5) = 105.0*s2*s*c; 
    plg(4,6) = (9.0*c*plg(4,5)-7.*plg(4,4))/2.0;
    plg(4,7) = (11.0*c*plg(4,6)-8.*plg(4,5))/3.0;
    if (~(((flags.sw(8)==0)&&(flags.sw(9)==0))&&(flags.sw(15)==0)))
        stloc = sin(hr*tloc);
        ctloc = cos(hr*tloc);
        s2tloc = sin(2.0*hr*tloc);
        c2tloc = cos(2.0*hr*tloc);
        s3tloc = sin(3.0*hr*tloc);
        c3tloc = cos(3.0*hr*tloc);
    end
    cd32 = cos(dr*(input.doy-p(32)));
    cd18 = cos(2.0*dr*(input.doy-p(18)));
    cd14 = cos(dr*(input.doy-p(14)));
    cd39 = cos(2.0*dr*(input.doy-p(39)));
    df = input.F107-input.F107A;
    dfa = input.F107A-150.0;
    t(1) =  p(20)*df*(1.0+p(60)*dfa)+p(21)*df*df+p(22)*dfa+p(30)*(dfa^2.0);
    f1 = 1.0+(p(48)*dfa+p(20)*df+p(21)*df*df)*flags.swc(2);
    f2 = 1.0+(p(50)*dfa+p(20)*df+p(21)*df*df)*flags.swc(2);
    t(2) = (p(2)*plg(1,3)+ p(3)*plg(1,5)+p(23)*plg(1,7))+...
           (p(15)*plg(1,3))*dfa*flags.swc(2)+p(27)*plg(1,2);
    t(3) = p(19)*cd32;
    t(4) = (p(16)+p(17)*plg(1,3))*cd18;
    t(5) = f1*(p(10)*plg(1,2)+p(11)*plg(1,4))*cd14;
    t(6) = p(38)*plg(1,2)*cd39;
    if (flags.sw(8))
        t71 = (p(12)*plg(2,3))*cd14*flags.swc(6);
        t72 = (p(13)*plg(2,3))*cd14*flags.swc(6);
        t(7) = f2*((p(4)*plg(2,2)+p(5)*plg(2,4)+p(28)*plg(2,6)+t71)*...
        ctloc+(p(7)*plg(2,2)+p(8)*plg(2,4)+p(29)*plg(2,6) ...
       +t72)*stloc);
    end
    if (flags.sw(9))
        t81 = (p(24)*plg(3,4)+p(36)*plg(3,6))*cd14*flags.swc(6);
        t82 = (p(34)*plg(3,4)+p(37)*plg(3,6))*cd14*flags.swc(6);
        t(8) = f2*((p(6)*plg(3,3)+ p(42)*plg(3,5)+t81)*c2tloc+(p(9)*...
            plg(3,3)+p(43)*plg(3,5)+t82)*s2tloc);
    end
    if (flags.sw(15))
        t(14) = f2*((p(40)*plg(4,4)+(p(94)*plg(4,5)+p(47)*plg(4,7))*...
            cd14*flags.swc(6))* s3tloc+(p(41)*plg(4,4)+(p(95)*plg(4,5)+...
            p(49)*plg(4,7))*cd14*flags.swc(6))* c3tloc);
    end
    if (flags.sw(10)==-1)
        ap = input.ap_a;
        if (p(52)~=0)
            exp1 = exp(-10800.0*sqrt(p(52)*p(52))/(1.0+p(139)*(45.0-...
                sqrt(input.g_lat*input.g_lat))));
            if (exp1>0.99999)
                exp1=0.99999;
            end
            if (p(25)<1.0E-4)
                p(25)=1.0E-4;
            end
            apt(1)=sg0(exp1,p,ap.a);
            if (flags.sw(10))
                t(9) = apt(1)*(p(51)+p(97)*plg(1,3)+p(55)*plg(1,5)+...
                    (p(126)*plg(1,2)+p(127)*plg(1,4)+p(128)*plg(1,6))*...
                    cd14*flags.swc(6)+(p(129)*plg(2,2)+p(130)*plg(2,4)+...
                    p(131)*plg(2,6))*flags.swc(8)*cos(hr*(tloc-p(132))));
            end
        end
    else
        apd = input.ap-4.0;
        p44 = p(44);
        p45 = p(45);
        if (p44<0)
            p44 = 1.0E-5;
        end
        apdf = apd+(p45-1.0)*(apd+(exp(-p44*apd)-1.0)/p44);
        if (flags.sw(10))
            t(9)=apdf*(p(33)+p(46)*plg(1,3)+p(35)*plg(1,5)+(p(101)*...
                plg(1,2)+p(102)*plg(1,4)+p(103)*plg(1,6))*cd14*...
                flags.swc(6)+(p(122)*plg(2,2)+p(123)*plg(2,4)+p(124)*...
                plg(2,6))*flags.swc(8)*cos(hr*(tloc-p(125))));
        end
    end
    if ((flags.sw(11))&&(input.g_long>-1000.0))
        if (flags.sw(12))
            t(11) = (1.0+p(81)*dfa*flags.swc(2))* ...
                ((p(65)*plg(2,3)+p(66)*plg(2,5)+p(67)*plg(2,7)+p(104)*...
                plg(2,2)+p(105)*plg(2,4)+p(106)*plg(2,6)+flags.swc(6)*...
                (p(110)*plg(2,2)+p(111)*plg(2,4)+p(112)*plg(2,6))*cd14)*...
                cos(dgtr*input.g_long)+(p(91)*plg(2,3)+p(92)*plg(2,5)+...
                p(93)*plg(2,7)+p(107)*plg(2,2)+p(108)*plg(2,4)+p(109)*...
                plg(2,6)+flags.swc(6)*(p(113)*plg(2,2)+p(114)*plg(2,4)+...
                p(115)*plg(2,6))*cd14)*sin(dgtr*input.g_long));
        end
        if (flags.sw(13))
            t(12) = (1.0+p(96)*plg(1,2))*(1.0+p(82)*dfa*flags.swc(2))*...
                (1.0+p(120)*plg(1,2)*flags.swc(6)*cd14)*((p(69)*...
                plg(1,2)+p(70)*plg(1,4)+p(71)*plg(1,6))*cos(sr*...
                (input.sec-p(72))));
            t(12)= t(12)+flags.swc(12)*(p(77)*plg(3,4)+p(78)*plg(3,6)+...
                p(79)*plg(3,8))*cos(sr*(input.sec-p(80))+2.0*dgtr*...
                input.g_long)*(1.0+p(138)*dfa*flags.swc(2));
        end
        if (flags.sw(14))
            if (flags.sw(10)==-1)
                if (p(52))
                    t(13)=apt(1)*flags.swc(12)*(1.+p(133)*plg(1,2))*...
                        ((p(53)*plg(2,3)+p(99)*plg(2,5)+p(68)*plg(2,7))*...
                        cos(dgtr*(input.g_long-p(98))))+apt(1)*...
                        flags.swc(12)*flags.swc(6)*(p(134)*plg(2,2)+...
                        p(135)*plg(2,4)+p(136)*plg(2,6))*cd14*cos(dgtr*...
                        (input.g_long-p(137)))+apt(1)*flags.swc(13)*...
                        (p(56)*plg(1,2)+p(57)*plg(1,4)+p(58)*plg(1,6))*...
                        cos(sr*(input.sec-p(59)));
                end
            else
                t(13) = apdf*flags.swc(12)*(1.0+p(121)*plg(1,2))*...
                    ((p(61)*plg(2,3)+p(62)*plg(2,5)+p(63)*plg(2,7))*...
                    cos(dgtr*(input.g_long-p(64))))+apdf*flags.swc(12)*...
                    flags.swc(6)*(p(116)*plg(2,2)+p(117)*plg(2,4)+...
                    p(118)*plg(2,6))*cd14*cos(dgtr*(input.g_long-...
                    p(119)))+apdf*flags.swc(13)*(p(84)*plg(1,2)+p(85)*...
                    plg(1,4)+p(86)*plg(1,6))*cos(sr*(input.sec-p(76)));
            end
        end
    end
    tinf = p(31);
    for i=1:14
        tinf = tinf+abs(flags.sw(i+1))*t(i);
    end
end

function tt = glob7s(p,input,flags)
    global dfa plg ctloc stloc c2tloc s2tloc s3tloc c3tloc apdf apt
    pset = 2.0;
    t = zeros(14,1);
    dr = 1.72142E-2;
    dgtr = 1.74533E-2;
    if (p(100)==0)
        p(100) = pset;
    end
    if (p(100)~=pset)
        fprintf('Wrong parameter set for glob7s\n');
        tt =-1;
        return
    end
    for j=1:14
        t(j)=0.0;
    end
    cd32 = cos(dr*(input.doy-p(32)));
    cd18 = cos(2.0*dr*(input.doy-p(18)));
    cd14 = cos(dr*(input.doy-p(14)));
    cd39 = cos(2.0*dr*(input.doy-p(39)));
    t(1) = p(22)*dfa;
    t(2) = p(2)*plg(1,3)+p(3)*plg(1,5)+p(23)*plg(1,7)+p(27)*plg(1,2)+...
        p(15)*plg(1,4)+p(60)*plg(1,6);
    t(3) = (p(19)+p(48)*plg(1,3)+p(30)*plg(1,5))*cd32;
    t(4) = (p(16)+p(17)*plg(1,3)+p(31)*plg(1,5))*cd18;
    t(5) = (p(10)*plg(1,2)+p(11)*plg(1,4)+p(21)*plg(1,6))*cd14;
    t(6) = (p(38)*plg(1,2))*cd39;
    if (flags.sw(8))
        t71 = p(12)*plg(2,3)*cd14*flags.swc(6);
        t72 = p(13)*plg(2,3)*cd14*flags.swc(6);
        t(7) = ((p(4)*plg(2,2)+p(5)*plg(2,4)+t71)*ctloc+(p(7)*plg(2,2)+...
            p(8)*plg(2,4)+t72)*stloc) ;
    end
    if (flags.sw(9))
        t81 = (p(24)*plg(3,4)+p(36)*plg(3,6))*cd14*flags.swc(6);
        t82 = (p(34)*plg(3,4)+p(37)*plg(3,6))*cd14*flags.swc(6);
        t(8) = ((p(6)*plg(3,3)+p(42)*plg(3,5)+t81)*c2tloc+(p(9)*...
            plg(3,3)+p(43)*plg(3,5)+t82)*s2tloc);
    end
    if (flags.sw(15))
        t(14) = p(40)*plg(4,4)*s3tloc+p(41)*plg(4,4)*c3tloc;
    end
    if (flags.sw(10))
        if (flags.sw(10)==1)
            t(9) = apdf*(p(33)+p(46)*plg(1,3)*flags.swc(3));
        end
        if (flags.sw(10)==-1)
            t(9) = (p(51)*apt(1)+p(97)*plg(1,3)*apt(1)*flags.swc(3));
        end
    end
    if (~((flags.sw(11)==0) || (flags.sw(12)==0) ||...
            (input.g_long<=-1000.0)))
        t(11) = (1.0+plg(1,2)*(p(81)*flags.swc(6)*cos(dr*(input.doy-...
            p(82)))+p(86)*flags.swc(7)*cos(2.0*dr*(input.doy-p(87))))+...
            p(84)*flags.swc(4)*cos(dr*(input.doy-p(85)))+p(88)*...
            flags.swc(5)*cos(2.0*dr*(input.doy-p(89))))*((p(65)*...
            plg(2,3)+p(66)*plg(2,5)+p(67)*plg(2,7)+p(75)*plg(2,2)+p(76)*...
            plg(2,4)+p(77)*plg(2,6))*cos(dgtr*input.g_long)+(p(91)*...
            plg(2,3)+p(92)*plg(2,5)+p(93)*plg(2,7)+p(78)*plg(2,2)+p(79)*...
            plg(2,4)+p(80)*plg(2,6))*sin(dgtr*input.g_long));
    end
    tt=0;
    for i=1:14
        tt = tt+abs(flags.sw(i+1))*t(i);   
    end
end

function output = gtd7(input,flags,nrlmsise00_data)
    global pt pd ps pdl ptl pma sam ptm pdm pavgm
    global gsurf re dd dm04 dm16 dm28 dm32 dm40 dm01 dm14
    global meso_tn1 meso_tn2 meso_tn3 meso_tgn1 meso_tgn2 meso_tgn3
    global dfa plg ctloc stloc c2tloc s2tloc s3tloc c3tloc apdf apt
    gsurf = 0;
    re = 6367.088132098377173;
    dd = 0;
    dm04 = 0;
    dm16 = 0;
    dm28 = 0;
    dm32 = 0;
    dm40 = 0;
    dm01 = 0;
    dm14 = 0;
    meso_tn1 = zeros(5,1);
    meso_tn2 = zeros(4,1);
    meso_tn3 = zeros(5,1);
    meso_tgn1 = zeros(2,1);
    meso_tgn2 = zeros(2,1);
    meso_tgn3 = zeros(2,1);
    dfa = 0;
    plg = zeros(4,9);
    ctloc = 0;
    stloc = 0;
    c2tloc = 0;
    s2tloc = 0;
    s3tloc = 0;
    c3tloc = 0;
    apdf = 0;
    apt = zeros(4,1);
    pt = nrlmsise00_data.pt;
    pd = nrlmsise00_data.pd;
    ps = nrlmsise00_data.ps;
    pdl = nrlmsise00_data.pdl;
    ptm = nrlmsise00_data.ptm;
    pdm = nrlmsise00_data.pdm;
    ptl = nrlmsise00_data.ptl;
    pma = nrlmsise00_data.pma;
    sam = nrlmsise00_data.sam;
    pavgm = nrlmsise00_data.pavgm;
    tz = 0;
    output = struct('d',zeros(9,1),'t',zeros(2));
    soutput = struct('d',zeros(9,1),'t',zeros(2));
    mn3 = 5;
    zn3 = [32.5,20.0,15.0,10.0,0.0];
    mn2 = 4;
    zn2 = [72.5,55.0,45.0,32.5];
    zmix= 62.5;
    flags = tselec(flags);
    xlat=input.g_lat;
    if (flags.sw(3)==0)
        xlat=45.0;
    end
    [gsurf,re] = glatf(xlat);
    xmm = pdm(3,5);
    if (input.alt>zn2(1))
        altt = input.alt;
    else
        altt = zn2(1);
    end
    tmp=input.alt;
    input.alt = altt;
    soutput = gts7(input,flags);
    altt = input.alt;
    input.alt = tmp;
    if (flags.sw(1))
        dm28m=dm28*1.0E6;
    else
        dm28m=dm28;
    end
    output.t(1)=soutput.t(1);
    output.t(2)=soutput.t(2);
    if (input.alt>=zn2(1))
        for i=1:9
            output.d(i)=soutput.d(i);
        end
        return
    end
    meso_tgn2(1) = meso_tgn1(2);
    meso_tn2(1) = meso_tn1(5);
    meso_tn2(2) = pma(1,1)*pavgm(1)/(1.0-flags.sw(21)*glob7s(pma(1,:),...
        input,flags));
    meso_tn2(3) = pma(2,1)*pavgm(2)/(1.0-flags.sw(21)*glob7s(pma(2,:),...
        input,flags));
    meso_tn2(4) = pma(3,1)*pavgm(3)/(1.0-flags.sw(21)*flags.sw(23)*...
        glob7s(pma(3,:),input,flags));
    meso_tgn2(2) = pavgm(9)*pma(10,1)*(1.0+flags.sw(21)*flags.sw(23)*...
        glob7s(pma(10,:),input,flags))*meso_tn2(4)*meso_tn2(4)/...
        ((pma(3,1)*pavgm(3))^2.0);
    meso_tn3(1) = meso_tn2(4);
    if (input.alt<zn3(1))
	    meso_tgn3(1) = meso_tgn2(2);
	    meso_tn3(2) = pma(4,1)*pavgm(4)/(1.0-flags.sw(23)*glob7s(pma(4,...
            :),input,flags));
	    meso_tn3(3) = pma(5,1)*pavgm(5)/(1.0-flags.sw(23)*glob7s(pma(5,...
            :),input,flags));
	    meso_tn3(4) = pma(6,1)*pavgm(6)/(1.0-flags.sw(23)*glob7s(pma(6,...
            :),input,flags));
	    meso_tn3(5) = pma(7,1)*pavgm(7)/(1.0-flags.sw(23)*glob7s(pma(7,...
            :),input,flags));
	    meso_tgn3(2) = pma(8,1)*pavgm(8)*(1.0+flags.sw(23)*glob7s(pma(8,...
            :),input,flags))*meso_tn3(5)*meso_tn3(5)/((pma(7,1)*...
            pavgm(7))^2.0);
    end
    dmc = 0;
    if (input.alt>zmix)
        dmc = 1.0-(zn2(1)-input.alt)/(zn2(1)-zmix);
    end
    dz28 = soutput.d(3);
    dmr=soutput.d(3)/dm28m-1.0;
    [output.d(3),tz] = densm(input.alt,dm28m,xmm,tz,mn3,zn3,meso_tn3,...
        meso_tgn3,mn2,zn2,meso_tn2,meso_tgn2);
    output.d(3) = output.d(3)*(1.0+dmr*dmc);
    dmr = soutput.d(1)/(dz28*pdm(1,2))-1.0;
    output.d(1) = output.d(3)*pdm(1,2)*(1.0+dmr*dmc);
    output.d(2) = 0;
    output.d(9) = 0;
    dmr = soutput.d(4)/(dz28*pdm(4,2))-1.0;
    output.d(4) = output.d(3)*pdm(4,2)*(1.0+dmr*dmc);
    dmr = soutput.d(5)/(dz28*pdm(5,2))-1.0;
    output.d(5) = output.d(3)*pdm(5,2)*(1.0+dmr*dmc);
    output.d(7) = 0;
    output.d(8) = 0;
    output.d(6) = 1.66E-24*(4.0*output.d(1)+16.0*output.d(2)+28.0*...
        output.d(3)+32.0*output.d(4)+40.0*output.d(5)+output.d(7)+14.0*...
        output.d(8));
    if (flags.sw(1))
        output.d(6)=output.d(6)/1000;
    end
    [dd,tz] = densm(input.alt,1.0,0,tz,mn3,zn3,meso_tn3,meso_tgn3,mn2,...
        zn2,meso_tn2,meso_tgn2);
    output.t(2)=tz;
end

function output = gts7(input,flags)
    global pt pd ps pdl ptl pma sam ptm pdm pavgm
    global gsurf re dd dm04 dm16 dm28 dm32 dm40 dm01 dm14
    global meso_tn1 meso_tn2 meso_tn3 meso_tgn1 meso_tgn2 meso_tgn3
    tz = 0;
    output = struct('d',zeros(9,1),'t',zeros(2));
    zn1 = [120.0,110.0,100.0,90.0,72.5];
    mn1 = 5;
    dgtr = 1.74533E-2;
    dr = 1.72142E-2;
    alpha = [-0.38,0.0,0.0,0.0,0.17,0.0,-0.38,0.0,0.0];
    altl = [200.0,300.0,160.0,250.0,240.0,450.0,320.0,450.0];
    za = pdl(2,16);
    zn1(1) = za;
    for j=1:9 
        output.d(j)=0;
    end
    if (input.alt>zn1(1))
        tinf = ptm(1)*pt(1)*...
            (1.0+flags.sw(17)*globe7(pt,input,flags));
    else
        tinf = ptm(1)*pt(1);
    end
    output.t(1)=tinf;
    if (input.alt>zn1(5))
        g0 = ptm(4)*ps(1)*...
            (1.0+flags.sw(20)*globe7(ps,input,flags));
    else
        g0 = ptm(4)*ps(1);
    end
    tlb = ptm(2)*(1.0+flags.sw(18)*globe7(pd(4,:),input,flags))*pd(4,1);
    s = g0/(tinf-tlb);
    if (input.alt<300.0)
        meso_tn1(2) = ptm(7)*ptl(1,1)/(1.0-flags.sw(19)*glob7s(ptl(1,:),...
            input,flags));
        meso_tn1(3) = ptm(3)*ptl(2,1)/(1.0-flags.sw(19)*glob7s(ptl(2,:),...
            input,flags));
        meso_tn1(4) = ptm(8)*ptl(3,1)/(1.0-flags.sw(19)*glob7s(ptl(3,:),...
            input,flags));
        meso_tn1(5) = ptm(5)*ptl(4,1)/(1.0-flags.sw(19)*flags.sw(21)*...
            glob7s(ptl(4,:),input,flags));
        meso_tgn1(2) = ptm(9)*pma(9,1)*(1.0+flags.sw(19)*flags.sw(21)*...
            glob7s(pma(9,:),input,flags))*meso_tn1(5)*meso_tn1(5)/...
            ((ptm(5)*ptl(4,1))^2.0);
    else
        meso_tn1(2) = ptm(7)*ptl(1,1);
        meso_tn1(3) = ptm(3)*ptl(2,1);
        meso_tn1(4) = ptm(8)*ptl(3,1);
        meso_tn1(5) = ptm(5)*ptl(4,1);
        meso_tgn1(2) = ptm(9)*pma(9,1)*meso_tn1(5)*meso_tn1(5)/((ptm(5)*...
            ptl(4,1))^2.0);
    end
    g28 = flags.sw(22)*globe7(pd(3,:),input,flags);
    zhf = pdl(2,25)*(1.0+flags.sw(6)*pdl(1,25)*sin(dgtr*input.g_lat)*...
        cos(dr*(input.doy-pt(14))));
    output.t(1) = tinf;
    xmm = pdm(3,5);
    z = input.alt;
    db28 = pdm(3,1)*exp(g28)*pd(3,1);
    [output.d(3),output.t(2)] = densu(z,db28,tinf,tlb,28.0,alpha(3),...
        output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
    dd = output.d(3);
    zh28 = pdm(3,3)*zhf;
    zhm28 = pdm(3,4)*pdl(2,6); 
    xmd = 28.0-xmm;
    [b28,tz] = densu(zh28,db28,tinf,tlb,xmd,(alpha(3)-1.0),tz,ptm(6),s,...
        mn1,zn1,meso_tn1,meso_tgn1);
    if ((flags.sw(16))&&(z<=altl(3)))
        [dm28,tz] = densu(z,b28,tinf,tlb,xmm,alpha(3),tz,ptm(6),s,mn1,...
            zn1,meso_tn1,meso_tgn1);
        output.d(3) = dnet(output.d(3),dm28,zhm28,xmm,28.0);
    end
    g4 = flags.sw(22)*globe7(pd(1,:),input,flags);
    db04 = pdm(1,1)*exp(g4)*pd(1,1);
    [output.d(1),output.t(2)] = densu(z,db04,tinf,tlb,4.,alpha(1),...
        output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
    dd = output.d(1);
    if ((flags.sw(16)) && (z<altl(1)))
        zh04 = pdm(1,3);
        [b04,output.t(2)] = densu(zh04,db04,tinf,tlb,4.-xmm,alpha(1)-1.,...
            output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        [dm04,output.t(2)] = densu(z,b04,tinf,tlb,xmm,0.,output.t(2),...
            ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        zhm04 = zhm28;
        output.d(1) = dnet(output.d(1),dm04,zhm04,xmm,4.);
        rl = log(b28*pdm(1,2)/b04);
        zc04 = pdm(1,5)*pdl(2,1);
        hc04 = pdm(1,6)*pdl(2,2);
        output.d(1) = output.d(1)*ccor(z,rl,hc04,zc04);
    end
    g16 = flags.sw(22)*globe7(pd(2,:),input,flags);
    db16 = pdm(2,1)*exp(g16)*pd(2,1);
    [output.d(2),output.t(2)] = densu(z,db16,tinf,tlb,16.,alpha(2),...
        output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
    dd = output.d(2);
    if ((flags.sw(16)) && (z<=altl(2)))
        zh16 = pdm(2,3);
        [b16,output.t(2)] = densu(zh16,db16,tinf,tlb,16.0-xmm,(alpha(2)-...
            1.0),output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        [dm16,output.t(2)] = densu(z,b16,tinf,tlb,xmm,0.,output.t(2),...
            ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        zhm16 = zhm28;
        output.d(2) = dnet(output.d(2),dm16,zhm16,xmm,16.);
        rl = pdm(2,2)*pdl(2,17)*(1.0+flags.sw(2)*pdl(1,24)*(input.F107A-...
            150.0));
        hc16 = pdm(2,6)*pdl(2,4);
        zc16 = pdm(2,5)*pdl(2,3);
        hc216 = pdm(2,6)*pdl(2,5);
        output.d(2) = output.d(2)*ccor2(z,rl,hc16,zc16,hc216);
        hcc16 = pdm(2,8)*pdl(2,14);
        zcc16 = pdm(2,7)*pdl(2,13);
        rc16 = pdm(2,4)*pdl(2,15);
        output.d(2) = output.d(2)*ccor(z,rc16,hcc16,zcc16);
    end
    g32= flags.sw(22)*globe7(pd(5,:),input,flags);
    db32 = pdm(4,1)*exp(g32)*pd(5,1);
    [output.d(4),output.t(2)] = densu(z,db32,tinf,tlb,32.,alpha(4),...
        output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
    dd = output.d(4);
    if (flags.sw(16))
        if (z<=altl(4))
            zh32 = pdm(4,3);
            [b32,output.t(2)] = densu(zh32,db32,tinf,tlb,32.-xmm,...
                alpha(4)-1.,output.t(2),ptm(6),s,mn1,zn1,meso_tn1,...
                meso_tgn1);
            [dm32,output.t(2)] = densu(z,b32,tinf,tlb,xmm,0.,...
                output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
            zhm32 = zhm28;
            output.d(4) = dnet(output.d(4),dm32,zhm32,xmm,32.);
            rl = log(b28*pdm(4,2)/b32);
            hc32 = pdm(4,6)*pdl(2,8);
            zc32 = pdm(4,5)*pdl(2,7);
            output.d(4) = output.d(4)*ccor(z,rl,hc32,zc32);
        end
        hcc32 = pdm(4,8)*pdl(2,23);
        hcc232 = pdm(4,8)*pdl(1,23);
        zcc32 = pdm(4,7)*pdl(2,22);
        rc32 = pdm(4,4)*pdl(2,24)*(1.+flags.sw(2)*pdl(1,24)*...
            (input.F107A-150.));
        output.d(4) = output.d(4)*ccor2(z,rc32,hcc32,zcc32,hcc232);
    end
    g40 = flags.sw(22)*globe7(pd(6,:),input,flags);
    db40 = pdm(5,1)*exp(g40)*pd(6,1);
    [output.d(5),output.t(2)] = densu(z,db40,tinf,tlb,40.,alpha(5),...
        output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
    dd = output.d(5);
    if ((flags.sw(16)) && (z<=altl(5)))
        zh40 = pdm(5,3);
        [b40,output.t(2)] = densu(zh40,db40,tinf,tlb,40.-xmm,alpha(5)-...
            1.,output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        [dm40,output.t(2)] = densu(z,b40,tinf,tlb,xmm,0.,output.t(2),...
            ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        zhm40 = zhm28;
        output.d(5) = dnet(output.d(5),dm40,zhm40,xmm,40.);
        rl = log(b28*pdm(5,2)/b40);
        hc40 = pdm(5,6)*pdl(2,10);
        zc40 = pdm(5,5)*pdl(2,9);
        output.d(5) = output.d(5)*ccor(z,rl,hc40,zc40);
    end
    g1 = flags.sw(22)*globe7(pd(7,:),input,flags);
    db01 = pdm(6,1)*exp(g1)*pd(7,1);
    [output.d(7),output.t(2)] = densu(z,db01,tinf,tlb,1.,alpha(7),...
        output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
    dd = output.d(7);
    if ((flags.sw(16)) && (z<=altl(7)))
        zh01 = pdm(6,3);
        [b01,output.t(2)] = densu(zh01,db01,tinf,tlb,1.-xmm,alpha(7)-1.,...
            output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        [dm01,output.t(2)] = densu(z,b01,tinf,tlb,xmm,0.,output.t(2),...
            ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        zhm01 = zhm28;
        output.d(7) = dnet(output.d(7),dm01,zhm01,xmm,1.);
        rl = log(b28*pdm(6,2)*sqrt(pdl(2,18)*pdl(2,18))/b01);
        hc01 = pdm(6,6)*pdl(2,12);
        zc01 = pdm(6,5)*pdl(2,11);
        output.d(7) = output.d(7)*ccor(z,rl,hc01,zc01);
        hcc01 = pdm(6,8)*pdl(2,20);
        zcc01 = pdm(6,7)*pdl(2,19);
        rc01 = pdm(6,4)*pdl(2,21);
        output.d(7) = output.d(7)*ccor(z,rc01,hcc01,zcc01);
    end
    g14 = flags.sw(22)*globe7(pd(8,:),input,flags);
    db14 = pdm(7,1)*exp(g14)*pd(8,1);
    [output.d(8),output.t(2)] = densu(z,db14,tinf,tlb,14.,alpha(8),...
        output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
    dd = output.d(8);
    if ((flags.sw(16)) && (z<=altl(8)))
        zh14 = pdm(7,3);
        [b14,output.t(2)] = densu(zh14,db14,tinf,tlb,14.-xmm,alpha(8)-...
            1.,output.t(2),ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        [dm14,output.t(2)] = densu(z,b14,tinf,tlb,xmm,0.,output.t(2),...
            ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
        zhm14 = zhm28;
        output.d(8) = dnet(output.d(8),dm14,zhm14,xmm,14.);
        rl = log(b28*pdm(7,2)*sqrt(pdl(1,3)*pdl(1,3))/b14);
        hc14 = pdm(7,6)*pdl(1,2);
        zc14 = pdm(7,5)*pdl(1,1);
        output.d(8) = output.d(8)*ccor(z,rl,hc14,zc14);
        hcc14 = pdm(7,8)*pdl(1,5);
        zcc14 = pdm(7,7)*pdl(1,4);
        rc14 = pdm(7,4)*pdl(1,6);
        output.d(8) = output.d(8)*ccor(z,rc14,hcc14,zcc14);
    end
    g16h = flags.sw(22)*globe7(pd(9,:),input,flags);
    db16h = pdm(8,1)*exp(g16h)*pd(9,1);
    tho = pdm(8,10)*pdl(1,7);
    [dd,output.t(2)] = densu(z,db16h,tho,tho,16.,alpha(9),output.t(2),...
        ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
    zsht = pdm(8,6);
    zmho = pdm(8,5);
    zsho = scalh(zmho,16.0,tho);
    output.d(9) = dd*exp(-zsht/zsho*(exp(-(z-zmho)/zsht)-1.));
    output.d(6) = 1.66E-24*(4.0*output.d(1)+16.0*output.d(2)+28.0*...
        output.d(3)+32.0*output.d(4)+40.0*output.d(5)+ output.d(7)+14.0*...
        output.d(8));
    z = sqrt(input.alt*input.alt);
    [ddum,output.t(2)] = densu(z,1.0,tinf,tlb,0.0,0.0,output.t(2),...
        ptm(6),s,mn1,zn1,meso_tn1,meso_tgn1);
    if (flags.sw(1))
        for i=1:9
            output.d(i)=output.d(i)*1.0E6;
        end
        output.d(6)=output.d(6)/1000;
    end
end

function out = zeta(zz,zl)
    global re
    out = ((zz-zl)*(re+zl)/(re+zz));
end

function out = g0(a,p)
    out = (a-4.0+(p(26)-1.0)*(a-4.0+(exp(-sqrt(p(25)*p(25))*(a-4.0))-...
        1.0)/sqrt(p(25)*p(25))));
end

function out = sumex(ex)
    out = (1.0+(1.0-(ex^19.0))/(1.0-ex)*(ex^0.5));
end

function out = sg0(ex,p,ap)
    out = (g0(ap(2),p)+(g0(ap(3),p)*ex+g0(ap(4),p)*ex*ex+g0(ap(5),p)*...
        (ex^3.0)+(g0(ap(6),p)*(ex^4.0)+g0(ap(7),p)*(ex^12.0))*(1.0-(ex^...
        8.0))/(1.0-ex)))/sumex(ex);
end