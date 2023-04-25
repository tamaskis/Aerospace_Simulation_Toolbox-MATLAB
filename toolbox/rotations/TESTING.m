clear;clc;close all;

Phi = 0:0.01:(2*pi-0.01);
twosinPhi_trig = zeros(length(Phi),1);
twosinPhi_tr = zeros(length(Phi),1);
for i = 1:length(Phi)
    R = axangle2mat([1;1;1]/norm([1;1;1]),Phi(i));
    twosinPhi_trig(i) = 2*sin(Phi(i));
    twosinPhi_tr(i) = sqrt((3-trace(R))*(1+trace(R)));
end
R = axangle2mat([1;1;1]/norm([1;1;1]),pi);

%plot(Phi,twosinPhi_tr,Phi,twosinPhi_trig);

figure;
hold on;
plot(Phi,twosinPhi_trig);
plot(Phi,twosinPhi_tr);
hold off;

%sqrt((3-trace(R))*(1+trace(R)))
%2*sin(acos((trace(R)-1)/2))


% psi = pi/3;
% theta = pi/4;
% phi = 4*pi/3;
% 
% R = rot321(psi,theta,phi);
% 
% [e,lambda] = eig(R);
% e = e(:,1)
% 
% Phi = acos(0.5*(R(1,1)+R(2,2)+R(3,3)-1));
% e = 1/(2*sin(Phi))*[R(2,3)-R(3,2);R(3,1)-R(1,3);R(1,2)-R(2,1)]