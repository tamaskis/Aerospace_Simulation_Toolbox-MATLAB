clear;clc;close all;

% phi = pi/6;
% theta = pi/3;
% psi = -pi/4;

psi = pi/6;
theta = -pi/6;
phi = 3*pi/4;


% q = [0.860663;0.43033;0.25820;0.08607];
% mat = quat2mat(q)
% q2 = mat2quat(mat);
% mat2 = quat2mat(q2)




%R = eul2mat_321(psi,theta,phi)
% R = [-0.000000000000000   0.000000000000000  -1.000000000000000
%   -0.965925826289068  -0.258819045102521   0.000000000000000;
%   -0.258819045102521   0.965925826289068   0.000000000000000];
%[psi2,theta2,phi2] = mat2eul_321(R)

% 
R = eul2mat_321(psi,theta,phi);
q1 = eul2quat_321(psi,theta,phi);
q2 = mat2quat(R);
%[psi1,theta1,phi1] = mat2eul_321(R);
[psi1,theta1,phi1] = quat2eul_321(q1);
[psi2,theta2,phi2] = quat2eul_321(q2);

[psi,psi1,psi2]
[theta,theta1,theta2]
[phi,phi1,phi2]
%R = quat2mat(q);

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