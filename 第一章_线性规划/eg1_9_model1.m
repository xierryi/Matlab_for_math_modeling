%将多目标问题转换为单目标问题往往会产生新的参数，此处用的是遍历的方法寻找最优解参数

clear,clc,close all
prob = optimproblem('ObjectiveSense','max');
x = optimvar('x',5,1,'LowerBound',0); %这行代码定义了一个名为 'x' 的变量，包含5个元素的向量。元素限制在大于等于0的范围内
c = [0.05,0.27,0.19,0.185,0.185];
aeq = [1,1.01,1.02,1.045,1.065];  %等号约束系数矩阵
prob.Objective = c * x; %目标函数
M = 10000;
prob.Constraints.con1 = aeq * x == M; %等式约束条件
q = [0.025, 0.015, 0.055, 0.026];  %不等式约束系数向量
a = 0; aa = []; QQ = []; XX = []; hold on
while a < 0.05
    prob.Constraints.con2 = q' .* x(2:end) <= a *M;  %不等式约束方程，注意总共有5个x，这里只约束了四个x,故x(2:end)
    %注意！！！这里是列向量.*列向量，不能行向量.*列向量
    %为甚么要.*？因为不等式左边只有一个数！！！！如果不等式左边是一个列向量，才能用Ax<=b的方式求解
    [sol,Q,flag,out]=solve(prob);
    aa = [aa,a]; QQ = [QQ,Q];  %直接往向量中进行堆叠；类似Sum = Sum + MemberNum 的操作
    XX = [XX;sol.x'];
    a = a + 0.001;
end
plot(aa,QQ,'*k')
xlabel('$a$','Interpreter','Latex');
ylabel('$Q$','Interpreter','Latex','Rotation',0);
XX = [QQ',XX]
