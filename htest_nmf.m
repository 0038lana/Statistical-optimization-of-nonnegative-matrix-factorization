function [ pass ] = htest_nmf( W, A, H, threshold, J )

[~,n] = size(A);
q = datasample(1:n,J);
for j=1:J
    [H(:,j), F] = blocknnls(W,A(:,q(j))); % za J random odabranih stupaca od H
                                          % ra�unamo BPP pomo�u sw redaka
                                          % od W i A
    pass = hypothesis_test(W(:,F), A(:,q(j)), H(F,q(j)), threshold); %radimo J hipoteza
 %kako bi provjerili je li smjer a�uriranja to�an
    if pass == false
        break
    end
end

end

