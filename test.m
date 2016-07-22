clear all
clc
% A = loadMNISTImages('train-images.idx3-ubyte');
% A = A(500:540,600:650);

load clown
%A = rand(100,500);
A = X;

[p, q] = size(A);

% perm1 = randperm(p);
% perm2 = randperm(q);
% permA = A(perm1, :);
% permA = permA(:, perm2);
% A = permA;

k = 10;
threshold = 0.4;


[W,H,t,rezidual] = bppss(A, k, threshold);
norma1 = norm(W*H-A,'fro')/norm(A, 'fro');

opt = statset('Display','final');
[W1,H1] = nnmf(A,k, 'algorithm', 'als', 'options', opt);
norma2 = norm(W1*H1-A,'fro')/norm(A, 'fro');

x=1:t-1;
figure
plot(x, rezidual);
title('BPP-SS');
xlabel('Iteracija');
ylabel('Rezidual');

figure
title('Original');
image(A);

figure
title('BPP-SS');
image(W*H);

figure
title('ALS NNMF');
image(W1*H1);