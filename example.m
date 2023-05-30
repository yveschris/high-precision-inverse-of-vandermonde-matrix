v = 1:.5:6;
A = vanderm(v);

%% computational accuracy
e1 = norm(A - inv(inv(A)), 2);
e2 = norm(A - inv(invvander(v)), 2);
disp(['e1/e2 = ' num2str(e1 / e2)]);

%% computational time
tic
invvander(v);
t1 = toc

tic
inv(A);
t2 = toc

disp(['t1/t2 = ' num2str(t1 / t2)]);
