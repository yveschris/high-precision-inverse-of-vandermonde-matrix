
function V = vanderm(v, m)
assert(isrow(v), 'v must be a row vector.')
if nargin == 1
    m = numel(v);
else
    assert(isscalar(m), 'm must be a scalar.')
    assert(m > 0 && mod(m, 1) == 0, 'm must be a positive integer.')
end
V = transpose(v.' .^ (0:(m - 1)));
