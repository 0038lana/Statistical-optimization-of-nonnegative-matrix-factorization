function [ S ] = rotation_matrix( v1, v2)

[d, ~] = size(v1);
V = [ v1 v2 ];

[Q, R] = qr(V,0);

r11 = R(1,1);
r12 = R(1,2);
r22 = R(2,2);

U = 1/sqrt(r12^2+r22^2) * [r12 -r22; r22 r12];

I = eye(d);
I1 = eye(2);
S = I - Q*(I1-U)*Q';


end

