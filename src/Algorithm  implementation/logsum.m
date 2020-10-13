function [M] = logsum(A)
% A is the input log-transformed matrix
% M is the sum of f-norm of A's column
n=size(A,2)
col_sum=zeros(1,n)
M=0
for i = 1:n
    col_sum(i)=norm(A(:,i),'fro').^2;
    M = M+col_sum(i)
end
end

