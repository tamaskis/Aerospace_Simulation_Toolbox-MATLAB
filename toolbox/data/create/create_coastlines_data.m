%% create_coastlines_data.m
% Astrodynamics Toolbox
%
% Creates coastline data (geodetic and ECEF coordinates).
%
% Author: Tamas Kis
% Last Update: 2022-02-15
%
% ----------------------
% Generated data format.
% ----------------------
%
% This script produces "coastlines_data.mat" which stores the 1×1 struct 
% "coastlines_data" with the following fields:
%   • lat - (N×1 double) geodetic latitude [°]
%   • lon - (N×1 double) geodetic longitude [°]
%   • h   - (N×1 double) geodetic altitude [°]
%   • X   - (N×1 double) ECEF X-position [m]
%   • Y   - (N×1 double) ECEF Y-position [m]
%   • Z   - (N×1 double) ECEF Z-position [m]
%
% "N" is the number of points in each array. Depending which coastlines
% data is used (from either default MATLAB or from Mapping Toolbox), N will
% not always be the same.



%% SCRIPT SETUP

% clears Workspace and Command Window, closes all figures
clear; clc; close all;

% adds path to necessary folders
addpath('../../orbits/');

% set whether coastlines should be imported from Mapping Toolbox or from
% default MATLAB
mapping_toolbox = false;



%% GEODETIC COORDINATES

% loads coastline geodetic longitude and latitude data [deg]
if mapping_toolbox && contains(struct2array(ver),'Mapping Toolbox')
    
    % loads coastline data from Mapping Toolbox
    load coastlines;
    
    % extracts geodetic latitude and longitude [deg]
    lat = coastlat;
    lon = coastlon;
    
else
    
    % loads Earth topographic data (included with base version of MATLAB)
    load('topo.mat','topo');

    % rearranges Earth topopgrahic data so it goes from -180 to 180 
    % deg longitude
    topoplot = [topo(:,181:360),topo(:,1:180)];

    % obtains contour matrix and closes figure resulting from this
    C = contour(-180:179,-90:89,topoplot,[0,0]);
    close;

    % sets all "0" points to NaN to avoid plotting (would cause lines to
    % criss-cross)
    C(:,C(1,:)==0) = NaN;

    % extracts geodetic latitude and longitude [deg] from contour matrix
    lon = C(1,:)';
    lat = C(2,:)';
    
end

% geoedetic altitudes at coastline (0 m)
h = zeros(size(lat));



%% ECEF COORDINATES

% preallocates arrays to store coordinates
X = zeros(size(lat));
Y = zeros(size(lat));
Z = zeros(size(lat));

% converts each geodetic coordinate to an ECEF coordinate
for i = 1:length(lat)
    r = geod2ecef(lat(i),lon(i),h(i));
    X(i) = r(1);
    Y(i) = r(2);
    Z(i) = r(3);
end



%% PACKING/EXPORTING DATA

% packages geodetic and ECEF coordinates into a structure
coastlines_data.lat = lat;
coastlines_data.lon = lon;
coastlines_data.h = h;
coastlines_data.X = X;
coastlines_data.Y = Y;
coastlines_data.Z = Z;

% saves "coastlines_data" to a .mat file
save('../datafiles/coastlines_data.mat','coastlines_data');