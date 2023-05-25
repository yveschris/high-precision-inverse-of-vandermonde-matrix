function B = invvander(v, m)
%INVVANDER inverse or pseudoinverse of Vandermonde matrix
%  Compute the inverse of a sqaure Vandermonde matrix or the pseudoinverse
%  of a rectangular Vandermonde matrix.
%
%  A = invvander(v, m) returns the m-by-n Vandermonde matrix whose columns are
%  powers of the vector v: A(i,j) = v(i)^(j-1), i = {1, 2, ..., m},
%  j = {1, 2, ..., n}, where n is the length of v. If m is not specified,
%  square matrix is assumed, i.e. m = n.
%  computation complexity: O(2(n-1)^2)
% Yu Chen, <chrainy@gmail.com>
% Version: 1.0, Date: 2023-05-25
% v = 1:.5:4;
% m = numel(v);

assert(isrow(v), 'v must be a row vector.')
assert(numel(v) == numel(unique(v)), 'all elements in the v must be distinct.')
n = numel(v);
if nargin == 1
    m = n;
else
    assert(isscalar(m), 'm must be a scalar.')
    assert(m > 0 && mod(m, 1) == 0, 'm must be a poistive integer.')
end

if m == n
    % 1-by-1 matrix
    if n == 1
        B = 1 / v;
        return;
    end
    
    p = [-v(1) 1];
    C(1) = 1;
    for i = 2:n
        p = [0, p] + [-v(i) * p, 0];
        
        Cp = C;
        C = zeros(1, i);
        for j = 1:i - 1
            C(j) = Cp(j) / (v(j) - v(i));       
        end
        C(i) = - sum(C);
    end
    
    B = zeros(n);
    c = zeros(1, n);
    
    for i = 1:n
        c(n) = 1;
        for j = n-1:-1:1
            c(j) = p(j + 1) + v(i) * c(j + 1);
        end
        B(i, :) = c * C(i);
    end
    
else
    V = (v.' .^ (0:(m - 1)));
    if m > n % over-determined
        V = V.';
    end
    [~, R] = qr(V);
    B = mldivide(R, mldivide(R', V'));
    if m < n % under-determined
        B = B.';
    end
end