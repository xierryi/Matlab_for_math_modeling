% %求目标函数(因变量)最优值
% clc,clear %初始化
% c = [4;3]; %目标函数系数，列向量
% b = [10;8;7]; %小于等于约束条件， ,列向量
% a = [2,1;1,1;0,1]; %Ax<=b的A和b
% lb = zeros(2,1);
% [x,fval] = linprog(-c,a,b,[],[],lb);  %目标函数最小值，小于等于约束，等于约束(没有就填[]),lb
% y = -fval

%求目标函数(自变量)最优解
clc,clear
prob = optimproblem('ObjectiveSense','max');  %目标函数最大化的优化问题
c = [4;3];
b = [10;8;7];
a = [2,1;1,1;0,1];
x = optimvar('x',2,'LowerBound',0);  %这行代码定义了一个名为 'x' 的变量，包含2个元素的向量。元素限制在大于等于0的范围内
prob.Objective = c' * x;  %目标函数
prob.Constraints.con = a * x <= b;
[sol,fval,flag,out] = solve(prob);
sol.x  %%自变量
fval  %%因变量

%最后，只需要第二种方法就能将目标函数的最优解的函数值以及对应的自变量的值解出