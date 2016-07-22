function [ pass ] = hypothesis_test( A, b, h, threshold )
%HYPOTHESIS_TEST 
%   A matrix, b, h vectors

[m, n] = size(A);
mi = inv(A'*A)*A'*b;
Q = 1/(m-1)*A'*A;
sigma = 1/(m-1)*norm(A*h-b, 2)^2;
Sigma = inv(Q)*sigma/m;

pzeros = zeros(n-1,1);
new_mi= [norm(mi-h, 2); pzeros];

R = rotation_matrix(mi-h, new_mi);
new_Sigma = inv(R)*Sigma*R;

ro = normcdf(0,new_mi(1),new_Sigma(1,1));

if ro > threshold
    pass = false;
else
    pass = true;
end

end

