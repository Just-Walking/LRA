function [S] = SVD_s(F,k)
% Input the sample matrix F,and the expect rank k
% Output the U value of F
[m,n] =size(F);
[U,S,V]=svd(F);
S=U(1:m,1:k);
end