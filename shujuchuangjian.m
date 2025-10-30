clear
% 设置参数 A, D, M
A = 1; % 示例值
D = 2; % 示例值
M = 0.5; % 示例值

% 定义符号变量
syms t x

% 定义第一个函数 U
U_sym = sin(3*t) * (2*x^5 - 0.7*x^4 - 3*x^3 - x^2/3);

% 计算第一个函数对 x 的四阶偏导数
d4U_dx4_sym = simplify(diff(U_sym, x, 4));

% 计算第一个函数对 t 的两阶偏导数
d2U_dt2_sym = simplify(diff(U_sym, t, 2));

% 定义新的函数 F
F_sym = 24.982723 * x^5 * cos(4*t);

% 定义 x 和 t 的范围和步长
x_vals = linspace(0, 1, 201); % 从 -5 到 5 均布的 201 个点
t_vals = linspace(0, 4, 101); % 从 0 到 10 均布的 101 个点

% 创建网格
[X, T] = meshgrid(x_vals, t_vals);

% 将符号表达式转换为数值函数
U_func = matlabFunction(U_sym);
d4U_dx4_func = matlabFunction(d4U_dx4_sym);
d2U_dt2_func = matlabFunction(d2U_dt2_sym);
F_func = matlabFunction(F_sym);

% 计算函数1的结果 U
U = U_func(T, X);

% 计算函数2的结果 S
d4U_dx4 = d4U_dx4_func(T, X);
d2U_dt2 = d2U_dt2_func(T, X);
S = D * d4U_dx4 + M * d2U_dt2;

% 计算函数 F 的结果 F
F = F_func(T, X);

% 指定保存路径
savePath = 'C:\Users\user\Desktop\研究工作\方程重构代码训练\训练数据';

% 创建保存目录（如果不存在）
if ~exist(savePath, 'dir')
    mkdir(savePath);
end

% 构建完整的文件路径
filePath = fullfile(savePath, 'data3.mat');

% 将矩阵 x_vals, t_vals, U, S, F 保存到 .mat 文件中
%save(filePath, 'x_vals', 't_vals', 'U', 'S', 'F');

%disp(['数据已成功保存到 ', filePath]);

% 绘制矩阵 S 和 F
figure;
subplot(1, 2, 1);
surf(X, T, S);
title('Matrix S');
xlabel('x');
ylabel('t');
zlabel('Value');
colorbar;

subplot(1, 2, 2);
surf(X, T, F);
title('Matrix F');
xlabel('x');
ylabel('t');
zlabel('Value');
colorbar;