clear,clc   %��ʼ��
prob = optimproblem('ObjectiveSense','max');  %Ŀ�꺯��������Ż�����
c = [2;3;-5];  %Ŀ�꺯��ϵ��������
beq = 7; %��ʽԼ������
aeq = [1,1,1]; %��ʽԼ������ A1 x = b1
b = [-10;12;0;0;0];%С�ڵ���Լ������
a = [-2,5,-1;1,3,1;-1,0,0;0,-1,0;0,0,-1];%С�ڵ���Լ������ A1 x <= b1
%��Ŀ�꺯�������
lb = zeros(3,1);
[xx,fval] = linprog(-c,a,b,aeq,beq,lb);  %��СֵĿ�꺯��ϵ����С�ڵ���Լ������������Լ��������������
z = -fval

%��Ŀ�꺯���Ա���
x = optimvar('x',3,'LowerBound',0);
prob.Objective = c' * x;
prob.Constraints.con1 = a * x<=b;
prob.Constraints.con2 = aeq * x == beq;
%�м�����ʽ(����ʽ)��д����.con

[sol,fval,flag,out] = solve(prob), sol.x
 