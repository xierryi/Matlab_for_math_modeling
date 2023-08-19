%����Ŀ������ת��Ϊ��Ŀ����������������µĲ������˴��õ��Ǳ����ķ���Ѱ�����Ž����

clear,clc,close all
prob = optimproblem('ObjectiveSense','max');
x = optimvar('x',5,1,'LowerBound',0); %���д��붨����һ����Ϊ 'x' �ı���������5��Ԫ�ص�������Ԫ�������ڴ��ڵ���0�ķ�Χ��
c = [0.05,0.27,0.19,0.185,0.185];
aeq = [1,1.01,1.02,1.045,1.065];  %�Ⱥ�Լ��ϵ������
prob.Objective = c * x; %Ŀ�꺯��
M = 10000;
prob.Constraints.con1 = aeq * x == M; %��ʽԼ������
q = [0.025, 0.015, 0.055, 0.026];  %����ʽԼ��ϵ������
a = 0; aa = []; QQ = []; XX = []; hold on
while a < 0.05
    prob.Constraints.con2 = q' .* x(2:end) <= a *M;  %����ʽԼ�����̣�ע���ܹ���5��x������ֻԼ�����ĸ�x,��x(2:end)
    %ע�⣡����������������.*������������������.*������
    %Ϊ��ôҪ.*����Ϊ����ʽ���ֻ��һ�������������������ʽ�����һ����������������Ax<=b�ķ�ʽ���
    [sol,Q,flag,out]=solve(prob);
    aa = [aa,a]; QQ = [QQ,Q];  %ֱ���������н��жѵ�������Sum = Sum + MemberNum �Ĳ���
    XX = [XX;sol.x'];
    a = a + 0.001;
end
plot(aa,QQ,'*k')
xlabel('$a$','Interpreter','Latex');
ylabel('$Q$','Interpreter','Latex','Rotation',0);
XX = [QQ',XX]
