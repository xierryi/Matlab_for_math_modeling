clc,clear,close all
prob = optimproblem('ObjectiveSense','min');  %注意模型三目标函数是求最小值
x = optimvar('x',1,6,'LowerBound',0); %这行代码定义了一个名为 'x' 的变量，包含5个元素的向量。元素限制在大于等于0的范围内
%为甚么是6?因为要将目标函数线性化，使用x(6)来替换目标函数当中的非线性部分，具体见eg1_9_model3目标函数线性化.png

c = [0.05,0.27,0.19,0.185,0.185];
q = [0.025, 0.015, 0.055, 0.026];  %不等式约束系数向量
M = 10000; %总投资金额
aeq = [1,1.01,1.02,1.045,1.065];  %等号约束系数矩阵
% w = 0:0.1:1;
w = [0.766, 0.767, 0.810, 0.811, 0.824, 0.825, 0.962, 0.963, 1.0]
VV = [];QQ = [];XX = [];
prob.Constraints.con1 = aeq * x(1:5)' == M; %等式约束条件,注意要去掉最后一个元素
prob.Constraints.con2 = q .* x(2:end-1) <= x(end); %不等式约束，包含x(6)


%由于不知道权重w,故需要遍历求最优w
%用X = [];X = [X,x]的方式就不怕画图时向量长度不同啦
for i = 1:length(w) 
    prob.Objective = w(i) * x(end) - (1 - w(i)) * (c * x(1:end-1)'); %将待定参数w带入到目标函数当中
    [sol,fval,flag,out]=solve(prob);
    xx = sol.x; %需要用变量接住sol.x
    QQ = [QQ,c * xx(1:end-1)']; %收益向量
    VV = [VV, max(q.*xx(2:5))]; %亏损向量
    XX = [XX;xx];
    plot(VV,QQ,'*-');grid on
    xlabel('风险/元');ylabel('收益/元');
end

XX = [QQ',XX] %找到拐点的对应投资金额解

