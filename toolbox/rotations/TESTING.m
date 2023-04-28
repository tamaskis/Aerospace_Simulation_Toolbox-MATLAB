clear;clc;close all;

phi = pi/6;
theta = pi/2;
psi = 3*pi/4;

R = eul2mat_321(psi,theta,phi)
R = [-0.000000000000000   0.000000000000000  -1.000000000000000
  -0.965925826289068  -0.258819045102521   0.000000000000000;
  -0.258819045102521   0.965925826289068   0.000000000000000];
[psi2,theta2,phi2] = mat2eul_321(R)
% 
% function R = eul2mat_test(psi,theta,phi)
%     R = [cos(theta)*cos(psi),cos(theta)*sin(psi),-sin(theta);
%     sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi),sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi),sin(phi)*cos(theta);
%     cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi),cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi),cos(phi)*cos(theta)];
% end
% 
% function [psi,theta,phi] = mat2eul_test(R)
%     
%     % yaw angle [rad]
%     psi = iatan2(R(2,1),R(1,1));
%     
%     % pitch angle [rad]
%     if abs(R(1,3)) < 1
%         theta = -asin(R(3,1));
%     else
%         theta = -pi*sign(R(3,1));
%     end
%     
%     % roll angle [rad]
%     phi = iatan2(R(3,2),R(3,3));
%     
% end