function B = invvander(v, m)
%INVVANDER inverse or pseudoinverse of Vandermonde matrix
%  Compute the inverse of a sqaure Vandermonde matrix or the pseudoinverse
%  of a rectangular Vandermonde matrix.
%
%  A = invvander(v, m) returns the m-by-n Vandermonde matrix whose columns are
%  powers of the vector v: A(i,j) = v(i)^(j-1), i = {1, 2, ..., m},
%  j = {1, 2, ..., n}, where n is the length of v. If m is not specified,
%  square matrix is assumed, i.e. m = n.
%
% Yu Chen, <chrainy@gmail.com>
% Version: 1.0, Date: 2023-04-20
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
    
    P = zeros(n, n - 1);
    P(1:2, 1) = [-v(n); 1];
    for i = 2:n-1
        P(1:(i + 1), i) = [0; P(1:i, i - 1)] + [-v(n - i + 1) * P(1:i, i - 1); 0];
    end
    
    B = zeros(n);
    ii = 1:n;
    B(1, :) = P(:, n-1) / prod(v(1) - v(ii ~= 1));
    cc = [-v(1); 1];
    
    for i = 2:n-1
        c = conv(cc, P(1:(n-i+1), n-i));
        B(i, :) = c / prod(v(i) - v(ii ~= i));
        cc = [0; cc] + [-v(i) * cc; 0];
    end
    B(n, :) = cc / prod(v(n) - v(ii ~= n));
    
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