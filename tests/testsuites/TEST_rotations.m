%% TEST_rotations.m
% Aerospace Simulation Toolbox
%
% Unit testing of the rot1, rot2, rot3,  rot313, and rot321 functions.
%
% Copyright © 2022 Tamas Kis
% Last Update: 2023-02-18
% Website: https://tamaskis.github.io
% Contact: tamas.a.kis@outlook.com
%
% DEPENDENCIES:
%   • Simple Unit Testing Toolbox (https://tamaskis.github.io/Simple_Unit_Testing_Toolbox-MATLAB)
%   • Aerospace Dynamics Toolbox (https://tamaskis.github.io/Aerospace_Dynamics_Toolbox-MATLAB/)




%% INITIALIZE TEST SUITE

test_suite = TestSuite('rotation tests',false);



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
test_suite.add_test(TestEqual(rot1_0,rot1_0_true,'rot1(0)',15));
test_suite.add_test(TestEqual(rot1_pi_4,rot1_pi_4_true,'rot1(π/4)',15));
test_suite.add_test(TestEqual(rot1_pi_2,rot1_pi_2_true,'rot1(π/2)',15));
test_suite.add_test(TestEqual(rot1_3pi_4,rot1_3pi_4_true,'rot1(3π/4)',15));
test_suite.add_test(TestEqual(rot1_pi,rot1_pi_true,'rot1(π)',15));
test_suite.add_test(TestEqual(rot1_5pi_4,rot1_5pi_4_true,'rot1(5π/4)',15));
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
test_suite.add_test(TestEqual(rot2_0,rot2_0_true,'rot2(0)',15));
test_suite.add_test(TestEqual(rot2_pi_4,rot2_pi_4_true,'rot2(π/4)',15));
test_suite.add_test(TestEqual(rot2_pi_2,rot2_pi_2_true,'rot2(π/2)',15));
test_suite.add_test(TestEqual(rot2_3pi_4,rot2_3pi_4_true,'rot2(3π/4)',15));
test_suite.add_test(TestEqual(rot2_pi,rot2_pi_true,'rot2(π)',15));
test_suite.add_test(TestEqual(rot2_5pi_4,rot2_5pi_4_true,'rot2(5π/4)',15));
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
test_suite.add_test(TestEqual(rot3_0,rot3_0_true,'rot3(0)',15));
test_suite.add_test(TestEqual(rot3_pi_4,rot3_pi_4_true,'rot3(π/4)',15));
test_suite.add_test(TestEqual(rot3_pi_2,rot3_pi_2_true,'rot3(π/2)',15));
test_suite.add_test(TestEqual(rot3_3pi_4,rot3_3pi_4_true,'rot3(3π/4)',15));
test_suite.add_test(TestEqual(rot3_pi,rot3_pi_true,'rot3(π)',15));
test_suite.add_test(TestEqual(rot3_5pi_4,rot3_5pi_4_true,'rot3(5π/4)',15));
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
test_suite.add_test(TestEqual(R321_actual,R321_true,'R321 forward',15));

% ---------------
% "Reverse" test.
% ---------------

% true result
R321_reverse_true = rot3(-theta1)*rot2(-theta2)*rot1(-theta3);

% actual result
R321_reverse_actual = rot321(theta1,theta2,theta3).';

% unit test
test_suite.add_test(TestEqual(R321_reverse_actual,R321_reverse_true,...
    'R321 reverse',15));



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
test_suite.add_test(TestEqual(R313_actual,R313_true,'R313 forward',15));

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



%% RUNS TEST SUITE

test_suite.run;