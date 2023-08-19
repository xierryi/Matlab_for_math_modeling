clear,clc   %初始化
prob = optimproblem('ObjectiveSense','max');  %目标函数求最大化优化问题
c = [2;3;-5];  %目标函数系数列向量
beq = 7; %等式约束条件
aeq = [1,1,1]; %等式约束条件 A1 x = b1
b = [-10;12;0;0;0];%小于等于约束条件
a = [-2,5,-1;1,3,1;-1,0,0;0,-1,0;0,0,-1];%小于等于约束条件 A1 x <= b1
%求目标函数因变量
lb = zeros(3,1);
[xx,fval] = linprog(-c,a,b,aeq,beq,lb);  %最小值目标函数系数，小于等于约束条件，等于约束条件，解向量
z = -fval

%求目标函数自变量
x = optimvar('x',3,'LowerBound',0);
prob.Objective = c' * x;
prob.Constraints.con1 = a * x<=b;
prob.Constraints.con2 = aeq * x == beq;
%有几个等式(不等式)就写几个.con

[sol,fval,flag,out] = solve(prob), sol.x
 