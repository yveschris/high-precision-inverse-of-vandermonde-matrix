v = 1:.5:6;
A = vanderm(v);

%% computational accuracy
e1 = norm(A - inv(inv(A)), 2);
e2 = norm(A - inv(invvander(v)), 2);

figure(1)
semilogy(1, e1, 'p', 2, e2, 'p', 'MarkerSize', 30);
legend('build-in inv', 'invvander', 'FontSize', 15);
ylabel('error')
xlim([0.9, 2.1])
grid on
disp(['e1/e2 = ' num2str(e1 / e2)]);

%% computational time
g = @() invvander(v);
h = @() inv(A);
t1 = timeit(g);
t2 = timeit(h);

figure(2)
plot(1, t1, 'p', 2, t2, 'p', 'MarkerSize', 30);
legend('build-in inv', 'invvander', 'FontSize', 15);
ylabel('run time')
xlim([0.9, 2.1])
grid on

disp(['t1/t2 = ' num2str(t1 / t2)]);
