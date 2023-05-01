%% TEST_rotations.m
% Aerospace Simulation Toolbox
%
% Unit testing of the rot1, rot2, rot3,  rot313, and rot321 functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-04-01
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% DEPENDENCIES:
%   • Simple Unit Testing Toolbox (https://tamaskis.github.io/Simple_Unit_Testing_Toolbox-MATLAB)
%   • Aerospace Simulation Toolbox (https://tamaskis.github.io/Aerospace_Simulation_Toolbox-MATLAB/)



%% SCRIPT SETUP

% clears Workspace and closes all figures
clear; close all;

% sets random seed
rng(1);



%% INITIALIZE TEST SUITE

test_suite = TestSuite('rotation tests');



%% rot1

% θ = 0
rot1_0 = rot1(0);
rot1_0_true = [1   0   0;
               0   1   0;
               0   0   1];

% θ = π/4
rot1_pi_4 = rot1(pi/4);
rot1_pi_4_true = [1   0           0;
                  0   sqrt(2)/2   sqrt(2)/2;
                  0  -sqrt(2)/2   sqrt(2)/2];

% θ = π/2
rot1_pi_2 = rot1(pi/2);
rot1_pi_2_true = [1   0   0;
                  0   0   1;
                  0  -1   0];

% θ = 3π/4
rot1_3pi_4 = rot1(3*pi/4);
rot1_3pi_4_true = [1   0           0;
                   0  -sqrt(2)/2   sqrt(2)/2;
                   0  -sqrt(2)/2  -sqrt(2)/2];

% θ = π
rot1_pi = rot1(pi);
rot1_pi_true = [1   0   0;
                0  -1   0;
                0   0  -1];

% θ = 5π/4
rot1_5pi_4 = rot1(5*pi/4);
rot1_5pi_4_true = [1   0           0;
                   0  -sqrt(2)/2  -sqrt(2)/2;
                   0   sqrt(2)/2  -sqrt(2)/2];

% θ = 3π/2
rot1_3pi_2 = rot1(3*pi/2);
rot1_3pi_2_true = [1   0   0;
                   0   0  -1;
                   0   1   0];

% θ = 7π/4
rot1_7pi_4 = rot1(7*pi/4);
rot1_7pi_4_true = [1   0           0;
                   0   sqrt(2)/2  -sqrt(2)/2;
                   0   sqrt(2)/2   sqrt(2)/2];

% θ = 2π
rot1_2pi = rot1(2*pi);
rot1_2pi_true = [1   0   0;
                 0   1   0;
                 0   0   1];

% adds tests
test_suite.add_test(TestEqual(rot1_0,rot1_0_true,'rot1(0)'));
test_suite.add_test(TestEqual(rot1_pi_4,rot1_pi_4_true,'rot1(π/4)'));
test_suite.add_test(TestEqual(rot1_pi_2,rot1_pi_2_true,'rot1(π/2)'));
test_suite.add_test(TestEqual(rot1_3pi_4,rot1_3pi_4_true,'rot1(3π/4)'));
test_suite.add_test(TestEqual(rot1_pi,rot1_pi_true,'rot1(π)',15));
test_suite.add_test(TestEqual(rot1_5pi_4,rot1_5pi_4_true,'rot1(5π/4)'));
test_suite.add_test(TestEqual(rot1_3pi_2,rot1_3pi_2_true,'rot1(3π/2)',15));
test_suite.add_test(TestEqual(rot1_7pi_4,rot1_7pi_4_true,'rot1(7π/4)',15));
test_suite.add_test(TestEqual(rot1_2pi,rot1_2pi_true,'rot1(2π)',15));



%% rot2

% θ = 0
rot2_0 = rot2(0);
rot2_0_true = [1   0   0;
               0   1   0;
               0   0   1];

% θ = π/4
rot2_pi_4 = rot2(pi/4);
rot2_pi_4_true = [sqrt(2)/2   0  -sqrt(2)/2;
                  0           1   0;
                  sqrt(2)/2   0   sqrt(2)/2];

% θ = π/2
rot2_pi_2 = rot2(pi/2);
rot2_pi_2_true = [0   0  -1;
                  0   1   0;
                  1   0   0];

% θ = 3π/4
rot2_3pi_4 = rot2(3*pi/4);
rot2_3pi_4_true = [-sqrt(2)/2   0  -sqrt(2)/2;
                    0           1   0;
                    sqrt(2)/2   0  -sqrt(2)/2];

% θ = π
rot2_pi = rot2(pi);
rot2_pi_true = [-1   0   0;
                 0   1   0;
                 0   0  -1];

% θ = 5π/4
rot2_5pi_4 = rot2(5*pi/4);
rot2_5pi_4_true = [-sqrt(2)/2   0   sqrt(2)/2;
                    0           1   0;
                   -sqrt(2)/2   0  -sqrt(2)/2];

% θ = 3π/2
rot2_3pi_2 = rot2(3*pi/2);
rot2_3pi_2_true = [ 0   0   1;
                    0   1   0;
                   -1   0   0];

% θ = 7π/4
rot2_7pi_4 = rot2(7*pi/4);
rot2_7pi_4_true = [ sqrt(2)/2   0   sqrt(2)/2;
                    0           1   0;
                   -sqrt(2)/2   0   sqrt(2)/2];

% θ = 2π
rot2_2pi = rot2(2*pi);
rot2_2pi_true = [1   0   0;
                 0   1   0;
                 0   0   1];

% adds tests
test_suite.add_test(TestEqual(rot2_0,rot2_0_true,'rot2(0)'));
test_suite.add_test(TestEqual(rot2_pi_4,rot2_pi_4_true,'rot2(π/4)'));
test_suite.add_test(TestEqual(rot2_pi_2,rot2_pi_2_true,'rot2(π/2)'));
test_suite.add_test(TestEqual(rot2_3pi_4,rot2_3pi_4_true,'rot2(3π/4)'));
test_suite.add_test(TestEqual(rot2_pi,rot2_pi_true,'rot2(π)',15));
test_suite.add_test(TestEqual(rot2_5pi_4,rot2_5pi_4_true,'rot2(5π/4)'));
test_suite.add_test(TestEqual(rot2_3pi_2,rot2_3pi_2_true,'rot2(3π/2)',15));
test_suite.add_test(TestEqual(rot2_7pi_4,rot2_7pi_4_true,'rot2(7π/4)',15));
test_suite.add_test(TestEqual(rot2_2pi,rot2_2pi_true,'rot2(2π)',15));



%% rot3

% θ = 0
rot3_0 = rot3(0);
rot3_0_true = [1   0   0;
               0   1   0;
               0   0   1];

% θ = π/4
rot3_pi_4 = rot3(pi/4);
rot3_pi_4_true = [ sqrt(2)/2   sqrt(2)/2   0;
                  -sqrt(2)/2   sqrt(2)/2   0;
                   0           0           1];

% θ = π/2
rot3_pi_2 = rot3(pi/2);
rot3_pi_2_true = [ 0   1   0;
                  -1   0   0;
                   0   0   1];

% θ = 3π/4
rot3_3pi_4 = rot3(3*pi/4);
rot3_3pi_4_true = [-sqrt(2)/2   sqrt(2)/2   0;
                   -sqrt(2)/2  -sqrt(2)/2   0;
                    0           0           1];

% θ = π
rot3_pi = rot3(pi);
rot3_pi_true = [-1   0   0;
                 0  -1   0;
                 0   0   1];

% θ = 5π/4
rot3_5pi_4 = rot3(5*pi/4);
rot3_5pi_4_true = [-sqrt(2)/2  -sqrt(2)/2   0;
                    sqrt(2)/2  -sqrt(2)/2   0;
                    0           0           1];

% θ = 3π/2
rot3_3pi_2 = rot3(3*pi/2);
rot3_3pi_2_true = [0  -1   0;
                   1   0   0;
                   0   0   1];

% θ = 7π/4
rot3_7pi_4 = rot3(7*pi/4);
rot3_7pi_4_true = [sqrt(2)/2  -sqrt(2)/2   0;
                   sqrt(2)/2   sqrt(2)/2   0;
                   0           0           1];

% θ = 2π
rot3_2pi = rot3(2*pi);
rot3_2pi_true = [1   0   0;
                 0   1   0;
                 0   0   1];

% adds tests
test_suite.add_test(TestEqual(rot3_0,rot3_0_true,'rot3(0)'));
test_suite.add_test(TestEqual(rot3_pi_4,rot3_pi_4_true,'rot3(π/4)'));
test_suite.add_test(TestEqual(rot3_pi_2,rot3_pi_2_true,'rot3(π/2)'));
test_suite.add_test(TestEqual(rot3_3pi_4,rot3_3pi_4_true,'rot3(3π/4)'));
test_suite.add_test(TestEqual(rot3_pi,rot3_pi_true,'rot3(π)',15));
test_suite.add_test(TestEqual(rot3_5pi_4,rot3_5pi_4_true,'rot3(5π/4)'));
test_suite.add_test(TestEqual(rot3_3pi_2,rot3_3pi_2_true,'rot3(3π/2)',15));
test_suite.add_test(TestEqual(rot3_7pi_4,rot3_7pi_4_true,'rot3(7π/4)',15));
test_suite.add_test(TestEqual(rot3_2pi,rot3_2pi_true,'rot3(2π)',15));



%% rot321

% rotation angles [°]
theta1 = 30;
theta2 = -40;
theta3 = 50;

% convert to radians
theta1 = theta1*(pi/180);
theta2 = theta2*(pi/180);
theta3 = theta3*(pi/180);

% ---------------
% "Forward" test.
% ---------------

% true result
R321_true = rot1(theta3)*rot2(theta2)*rot3(theta1);

% actual result
R321_actual = rot321(theta1,theta2,theta3);

% unit test
test_suite.add_test(TestEqual(R321_actual,R321_true,'R321 forward'));

% ---------------
% "Reverse" test.
% ---------------

% true result
R321_reverse_true = rot3(-theta1)*rot2(-theta2)*rot1(-theta3);

% actual result
R321_reverse_actual = rot321(theta1,theta2,theta3).';

% unit test
test_suite.add_test(TestEqual(R321_reverse_actual,R321_reverse_true,...
    'R321 reverse'));



%% rot313

% rotation angles [°]
theta1 = 30;
theta2 = -40;
theta3 = 50;

% convert to radians
theta1 = theta1*(pi/180);
theta2 = theta2*(pi/180);
theta3 = theta3*(pi/180);

% true result
R313_true = rot3(theta3)*rot1(theta2)*rot3(theta1);

% actual result
R313_actual = rot313(theta1,theta2,theta3);

% unit test
test_suite.add_test(TestEqual(R313_actual,R313_true,'R313 forward'));

% ---------------
% "Reverse" test.
% ---------------

% true result
R313_reverse_true = rot3(-theta1)*rot1(-theta2)*rot3(-theta3);

% actual result
R313_reverse_actual = rot313(theta1,theta2,theta3).';

% unit test
test_suite.add_test(TestEqual(R313_reverse_actual,R313_reverse_true,...
    'R313 reverse',15));



%% eul2mat_321

% test against rot321
psi = 30*(pi/180);
theta = -40*(pi/180);
phi = 50*(pi/180);
R = eul2mat_321(psi,theta,phi);
R_true = rot321(psi,theta,phi);
test_suite.add_test(TestEqual(R,R_true,'eul2mat_321 test 1',4));


% numerical test
psi = 3*pi/4;
theta = -pi/6;
phi = pi/6;
R = eul2mat_321(psi,theta,phi);
R_true = [-0.6124,0.6124,0.5000;
            -0.4356,-0.7891,0.4330;
             0.6597,0.0474,0.7500];
test_suite.add_test(TestEqual(R,R_true,'eul2mat_321 test 2',4));



%% mat2eul_321

% basic test
psi_true = 3*pi/4;
theta_true = -pi/6;
phi_true = pi/6;
R = eul2mat_321(psi_true,theta_true,phi_true);
[psi,theta,phi] = mat2eul_321(R);
test_suite.add_test(TestEqual([psi,theta,phi],[psi_true,theta_true,phi_true],'mat2eul_321 basic test',15));

% pitch-up singularity test 1 (pitch = π/2)
psi_true = 0;
theta_true = pi/2;
phi_true = pi/5;
R = eul2mat_321(psi_true,theta_true,phi_true);
[psi,theta,phi] = mat2eul_321(R);
test_suite.add_test(TestEqual([psi,theta,phi],[psi_true,theta_true,phi_true],'mat2eul_321 pitch-up singularity test 1 (0 yaw)'));

% pitch-up singularity test 2
psi_true = -pi/6;
theta_true = pi/2;
phi_true = pi/5;
R = eul2mat_321(psi_true,theta_true,phi_true);
[psi,theta,phi] = mat2eul_321(R);
test_suite.add_test(TestEqual([psi,theta,phi],[0,pi/2,1.1519],'mat2eul_321 pitch-up singularity test 2 (nonzero yaw)',4));

% pitch-up singularity test 3
R(1,3) = R(1,3)-1e-14;
[psi,theta,phi] = mat2eul_321(R);
test_suite.add_test(TestEqual([psi,theta,phi],[0,pi/2,1.1519],'mat2eul_321 pitch-up singularity test 3 (nonzero yaw, numerical robustness)',4));

% pitch-down singularity test 1
psi_true = 0;
theta_true = -pi/2;
phi_true = pi/5;
R = eul2mat_321(psi_true,theta_true,phi_true);
[psi,theta,phi] = mat2eul_321(R);
test_suite.add_test(TestEqual([psi_true,theta_true,phi_true],[psi,theta,phi],'mat2eul_321 pitch-down singularity test 1 (0 yaW)'));

% pitch-down singularity test 2
psi_true = -pi/6;
theta_true = -pi/2;
phi_true = pi/5;
R = eul2mat_321(psi_true,theta_true,phi_true);
[psi,theta,phi] = mat2eul_321(R);
test_suite.add_test(TestEqual([psi,theta,phi],[0,-pi/2,0.1047],'mat2eul_321 pitch-down singularity test 2 (nonzero yaw)',4));

% pitch-down singularity test 3
R(1,3) = R(1,3)+1e-14;
[psi,theta,phi] = mat2eul_321(R);
test_suite.add_test(TestEqual([psi,theta,phi],[0,-pi/2,0.1047],'mat2eul_321 pitch-down singularity test 3 (nonzero yaw, numerical robustness)',4));

% long test
psi = linspace(-pi,pi);
psi = psi(randperm(100));
theta = linspace(-pi/2+0.001,pi/2-0.001);
theta = theta(randperm(100));
phi = linspace(pi,-pi);
phi = phi(randperm(100));
psi_recalc = zeros(1,100);
theta_recalc = zeros(1,100);
phi_recalc = zeros(1,100);
for i = 1:100
    [psi_recalc(i),theta_recalc(i),phi_recalc(i)] = mat2eul_321(...
        eul2mat_321(psi(i),theta(i),phi(i)));
end
test_suite.add_test(TestEqual(psi_recalc,psi,'mat2eul_321 long test --> psi',12));
test_suite.add_test(TestEqual(theta_recalc,theta,'mat2eul_321 long test --> theta',12));
test_suite.add_test(TestEqual(phi_recalc,phi,'mat2eul_321 long test --> phi',13));



%% quat2mat

% test 1
R = quat2mat([1;0;1;0]);
R_true = [0,0,-1;0,1,0;1,0,0];
test_suite.add_test(TestEqual(R,R_true,'quat2mat test 1',15));

% test 2
R = quat2mat([1;0.5;0.3;0.1]);
R_true = [0.8519,0.3704,-0.3704;
          0.0741,0.6148,0.7852;
          0.5185,-0.6963,0.4963];
test_suite.add_test(TestEqual(R,R_true,'quat2mat test 2',4));



%% eul2quat_321

% simple test
psi = pi/6;
theta = -pi/6;
phi = 3*pi/4;
q = eul2quat_321(psi,theta,phi);
q_true = [0.2952;0.8876;0.1353;0.3266];
test_suite.add_test(TestEqual(q,q_true,'eul2quat_321 simple test',4));

% long test
psi = linspace(-pi,pi);
psi = psi(randperm(100));
theta = linspace(-pi/2,pi/2);
theta = theta(randperm(100));
phi = linspace(pi,-pi);
phi = phi(randperm(100));
R = zeros(3,3,100);
R_true = zeros(3,3,100);
for i = 1:100
    q = eul2quat_321(psi(i),theta(i),phi(i));
    R(:,:,i) = quat2mat(q);
    R_true(:,:,i) = eul2mat_321(psi(i),theta(i),phi(i));
end
test_suite.add_test(TestEqual(R,R_true,'eul2quat_321 long test',14));



%% mat2quat

% test 1
q = mat2quat([0,0,-1;0,1,0;1,0,0]);
q_true = [sqrt(2)/2;0;sqrt(2)/2;0];
test_suite.add_test(TestEqual(q,q_true,'mat2quat test 1'));

% test 2
R = [0.8519,0.3704,-0.3704;
     0.0741,0.6148,0.7852;
     0.5185,-0.6963,0.4963];
q = mat2quat(R);
q_true = [0.8607;0.4303;0.2582;0.0861];
test_suite.add_test(TestEqual(q,q_true,'mat2quat test 2',4));

% long test
psi = linspace(-pi,pi);
psi = psi(randperm(100));
theta = linspace(-pi/2,pi/2);
theta = theta(randperm(100));
phi = linspace(pi,-pi);
phi = phi(randperm(100));
q = zeros(4,100);
q_true = zeros(4,100);
for i = 1:100
    q(:,i) = eul2quat_321(psi(i),theta(i),phi(i));
    q_true(:,i) = mat2quat(eul2mat_321(psi(i),theta(i),phi(i)));
end
test_suite.add_test(TestEqual(q,q_true,'mat2quat long test',15));



%% quat2eul_321

% simple test
[psi,theta,phi] = quat2eul_321([0.2952;0.8876;0.1353;0.3266]);
test_suite.add_test(TestEqual(psi,pi/6,'quat2eul_321 simple test --> psi',5));
test_suite.add_test(TestEqual(theta,-pi/6,'quat2eul_321 simple test --> theta',4));
test_suite.add_test(TestEqual(phi,3*pi/4,'quat2eul_321 simple test --> phi',4));

% long test
psi = linspace(-pi,pi);
psi = psi(randperm(100));
theta = linspace(-pi/2+0.001,pi/2-0.001);
theta = theta(randperm(100));
phi = linspace(pi,-pi);
phi = phi(randperm(100));
psi_recalc = zeros(1,100);
theta_recalc = zeros(1,100);
phi_recalc = zeros(1,100);
for i = 1:100
    [psi_recalc(i),theta_recalc(i),phi_recalc(i)] = quat2eul_321(...
        eul2quat_321(psi(i),theta(i),phi(i)));
end
test_suite.add_test(TestEqual(psi_recalc,psi,'quat2eul_321 long test --> psi',12));
test_suite.add_test(TestEqual(theta_recalc,theta,'quat2eul_321 long test --> theta',12));
test_suite.add_test(TestEqual(phi_recalc,phi,'quat2eul_321 long test --> phi',12));



%% axang2quat

test_suite.add_test(TestEqual(axang2quat([1;0;0],0),[1;0;0;0],'axang2quat test 1'));
test_suite.add_test(TestEqual(axang2quat([1;0;0],pi),[0;1;0;0],'axang2quat test 2'));
test_suite.add_test(TestEqual(axang2quat([-1;-1;-1],0),[1;0;0;0],'axang2quat test 3'));
test_suite.add_test(TestEqual(axang2quat([-1;-1;-1],pi),[0;-sqrt(3)/3;-sqrt(3)/3;-sqrt(3)/3],'axang2quat test 4'));
test_suite.add_test(TestEqual(axang2quat([1;0;0],pi/2),[sqrt(2)/2;sqrt(2)/2;0;0],'axang2quat test 5'));
test_suite.add_test(TestEqual(axang2quat([-1;-1;-1],pi/2),[sqrt(2)/2;-sqrt(6)/6;-sqrt(6)/6;-sqrt(6)/6],'axang2quat test 6'));
test_suite.add_test(TestEqual(axang2quat([0.1;0.5;-0.3],3*pi/4),[0.3827;0.1562;0.7808;-0.4685],'axang2quat test 7',4));



%% quat2axang

% TODO
% 
% simple test 1
[e,Phi] = quat2axang([1;0;0;0]);
test_suite.add_test(TestEqual([e;Phi],[1;0;0;0],'quat2axang test 1'));

% simple test 2
[e,Phi] = quat2axang([0;1;0;0]);
test_suite.add_test(TestEqual([e;Phi],[1;0;0;pi],'quat2axang test 2'));

% simple test 3
[e,Phi] = quat2axang([0;-sqrt(3)/3;-sqrt(3)/3;-sqrt(3)/3])
test_suite.add_test(TestEqual([e;Phi],[-sqrt(3)/3;-sqrt(3)/3;-sqrt(3)/3;pi],'quat2axang test 3'));

% simple test 4
[e,Phi] = quat2axang([sqrt(2)/2;sqrt(2)/2;0;0]);
test_suite.add_test(TestEqual([e;Phi],[1;0;0;pi/2],'quat2axang test 4'));

% simple test 5
[e,Phi] = quat2axang([sqrt(2)/2;-sqrt(6)/6;-sqrt(6)/6;-sqrt(6)/6]);
test_suite.add_test(TestEqual([e;Phi],[-sqrt(3)/3;-sqrt(3)/3;-sqrt(3)/3;pi/2],'quat2axang test 5'));

% simple test 6
[e,Phi] = quat2axang([0.3827;0.1562;0.7808;-0.4685]);
test_suite.add_test(TestEqual([e;Phi],[0.1690;0.8452;-0.5071;3*pi/4],'quat2axang test 6',4));



%% axang2mat

% simple tests
test_suite.add_test(TestEqual(axang2mat([1;0;0],0),[1,0,0;0,1,0;0,0,1],'axang2mat test 1'));
test_suite.add_test(TestEqual(axang2mat([-5;4;-2],0),[1,0,0;0,1,0;0,0,1],'axang2mat test 2'));
test_suite.add_test(TestEqual(axang2mat([0;1;0],pi/2),[0,0,-1;0,1,0;1,0,0],'axang2mat test 3'));
test_suite.add_test(TestEqual(axang2mat([0.1;0.2;-0.4],3*pi/4),[-0.6258,-0.4546,-0.6338;0.7798,-0.3819,-0.4960;-0.0166,-0.8046,0.5935],'axang2mat test 4',4));

% long test
e1 = linspace(-1,1);
e1 = e1(randperm(100));
e2 = linspace(-1,1);
e2 = e2(randperm(100));
e3 = linspace(-1,1);
e3 = e3(randperm(100));
e = [e1;e2;e3];
Phi = linspace(0,2*pi);
Phi = Phi(randperm(100));
R = zeros(3,3,100);
R_true = zeros(3,3,100);
for i = 1:100
    q = axang2quat(e(:,i),Phi(i));
    R_true(:,:,i) = quat2mat(q);
    R(:,:,i) = axang2mat(e(:,i),Phi(i));
end
test_suite.add_test(TestEqual(R,R_true,'axang2mat long test',14));



%% axang2eul_321

% simple test 1
[psi,theta,phi] = axang2eul_321([1;0;0],0);
test_suite.add_test(TestEqual([psi,theta,phi],[0,0,0],'axang2eul_321 test 1'));

% simple test 2
[psi,theta,phi] = axang2eul_321([-5;4;-2],0);
test_suite.add_test(TestEqual([psi,theta,phi],[0,0,0],'axang2eul_321 test 2'));

% simple test 3
[psi,theta,phi] = axang2eul_321([0;1;0],pi/2);
test_suite.add_test(TestEqual([psi,theta,phi],[0,pi/2,0],'axang2eul_321 test 3'));

% simple test 4
[psi,theta,phi] = axang2eul_321([0.1;0.2;-0.4],5*pi/4);
test_suite.add_test(TestEqual([psi,theta,phi],[2.2471,0.0166,-0.9352],'axang2eul_321 test 4',4));

% long test
e1 = linspace(-1,1);
e1 = e1(randperm(100));
e2 = linspace(-1,1);
e2 = e2(randperm(100));
e3 = linspace(-1,1);
e3 = e3(randperm(100));
e = [e1;e2;e3];
Phi = linspace(0,2*pi);
Phi = Phi(randperm(100));
psi = zeros(1,100);
psi_true = zeros(1,100);
theta = zeros(1,100);
theta_true = zeros(1,100);
phi = zeros(1,100);
phi_true = zeros(1,100);
for i = 1:100
    R = axang2mat(e(:,i),Phi(i));
    [psi_true(i),theta_true(i),phi_true(i)] = mat2eul_321(R);
    [psi(i),theta(i),phi(i)] = axang2eul_321(e(:,i),Phi(i));
end
test_suite.add_test(TestEqual(psi,psi_true,'axang2eul_321 long test --> yaw'));
test_suite.add_test(TestEqual(theta,theta_true,'axang2eul_321 long test --> pitch'));
test_suite.add_test(TestEqual(phi,phi_true,'axang2eul_321 long test --> roll'));



%% mat2axang

% simple test 1
[e,Phi] = mat2axang([0,0,-1;0,1,0;1,0,0]);
test_suite.add_test(TestEqual([e;Phi],[0;1;0;pi/2],'mat2axang test 1'));

% simple test 2
[e,Phi] = mat2axang([-0.6258,-0.4546,-0.6338;
                     0.7798,-0.3819,-0.4960;
                     -0.0166,-0.8046,0.5935]);
test_suite.add_test(TestEqual([e;Phi],[0.2182;0.4364;-0.8729;3*pi/4],'mat2axang test 2',4));

% edge case test: Φ = 0
e = [0.2673;0.5345;0.8018];
Phi = 0;
[e_recalc,Phi_recalc] = mat2axang(axang2mat(e,Phi));
test_suite.add_test(TestEqual([e_recalc;Phi_recalc],[1;0;0;0],'mat2axang Φ = 0 singularity'));

% edge case test: Φ = π
e = [0.2673;0.5345;0.8018];
Phi = pi;
[e_recalc,Phi_recalc] = mat2axang(axang2mat(e,Phi));
test_suite.add_test(TestEqual([e_recalc;Phi_recalc],[e;Phi],'mat2axang Φ = π singularity',4));

% long test
e1 = linspace(-1,1);
e1 = e1(randperm(100));
e2 = linspace(-1,1);
e2 = e2(randperm(100));
e3 = linspace(-1,1);
e3 = e3(randperm(100));
e = [e1;e2;e3];
for i = 1:100
    e(:,i) = e(:,i)/norm(e(:,i));
end
Phi = linspace(0.001,pi-0.001);
Phi = Phi(randperm(100));
e_recalc = zeros(3,100);
Phi_recalc = zeros(1,100);
for i = 1:100
    [e_recalc(:,i),Phi_recalc(i)] = mat2axang(axang2mat(e(:,i),Phi(i)));
end
test_suite.add_test(TestEqual(e,e_recalc,'mat2axang long test --> e',13));
test_suite.add_test(TestEqual(Phi,Phi_recalc,'mat2axang long test --> Phi',12));



%% RUNS TEST SUITE

test_suite.run;