rng(42)
v = 1:.5:7;
A = vanderm(v);
B = invvander(v);
x = randn(numel(v),1);
b = A * x;
y1 = inv(A) * b;
y2 = A \ b;
y3 = B * b;
err1 = norm(y1 - x);  % absolute error of using inv, err1 = 0.0668
err2 = norm(y2 - x);  % absolute error of using mldivide, err2 = 0.0233
err3 = norm(y3 - x);  % % absolute error of using invvander, err3 = 6.5713e-06
semilogy(1, err1, 'p', 'MarkerSize', 15, 'MarkerFaceColor', 'r');
hold on
semilogy(2, err2, 'p', 'MarkerSize', 15, 'MarkerFaceColor', 'g');
semilogy(3, err3, 'p', 'MarkerSize', 15, 'MarkerFaceColor', 'b');
legend('inv', 'mldivide', 'invvander');
grid on