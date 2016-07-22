function [W, H, t, rezidual] = bppss(A, k, threshold)

[p, q] = size(A);
sh = round(rand(1)*floor(p/2));
sw = round(rand(1)*floor(q/2));

W = rand(p,k);
H = rand(k,q);

J = 10;
t = 1;
rezidual = [];

while 1

% trazimo H
pass = htest_nmf(W(1:sh,:), A(1:sh,1:sw), H(:,1:sw), threshold, J);

if pass
    for i = 1:sw
        H(:,i) = blocknnls(W(1:sh,:),A(1:sh,i));
    end
    
else
    if sh==p
        break
    else
        sh = min(2*sh, p);
    end
end

%trazimo W
pass = htest_nmf(H(:,1:sw)', A(1:sh,1:sw)', W(1:sh,:)', threshold, J);
if pass
    for j = 1:sh
        W(j,:) = blocknnls(H(:,1:sw)',A(j, 1:sw)');
    end
    
else
    if sw==q
        break
    else
        sw = min(2*sw, q);
    end
end

rezidual = [rezidual norm(W*H-A, 'fro')/norm(A,'fro')];
%broj iteracija
t = t + 1;

end
   
   
