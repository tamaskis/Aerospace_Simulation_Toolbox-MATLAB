clc; clear all; close all;

addpath(genpath('toolbox'));

MJD_UTC0 = cal2mjd([2007,04,05,12,0,0]);

eop = load_eop(MJD_UTC0,1);
XYs_iau06 = load_XYs_iau06;

DUT1 = get_dut1(MJD_UTC0);
DUT1 = -0.072073685;
MJD_UT1 = utc2ut1(MJD_UTC0,DUT1);

[xp,yp,dX,dY,LOD] = eop_iau06(MJD_UT1,eop);
DAT = get_dat(MJD_UTC0);
MJD_TT = tai2tt(utc2tai(MJD_UTC0,DAT));

[R_itrf2gcrf,R_gcrf2itrf,w_gcrf,Q,R,W] = iau06(MJD_UT1,MJD_TT,xp,...
            yp,dX,dY,LOD,XYs_iau06);

era = rad2deg(era_iau06(MJD_UT1))

JD_TT = mjd2jd(MJD_TT);
JD_UT1 = mjd2jd(MJD_UT1);