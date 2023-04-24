clear;clc;close all;

q = [1;2;3;4];
q = q/norm(q);

t1 = TIME_EVALUATION(@(q)quat2mat_v1(q),{q},1000000);
t2 = TIME_EVALUATION(@(q)quat2mat_v2(q),{q},1000000);
t3 = TIME_EVALUATION(@(q)quat2mat_v2(q),{q},1000000);

%t1/t2