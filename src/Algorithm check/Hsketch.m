function [H] = Hsketch(A,s)
%sample proportional to the f-norm of the column
%   A is the input matrix; s is the number of sample column; 
% H is the output sketch matrix
tic;
prob=zeros(1,size(A,2));
H=zeros(size(A,1),s);
n=size(A,2);

prob=sum(A.^2);%compute f-value of coloums
prob_sum=sum(prob,2);

prob_value=prob./prob_sum; %get the probability
prob_value_sort=sort(prob_value);

for i=2:size(A,2)
    prob_value(i)=prob_value(i-1)+prob_value(i);
end

for j=1:s
 rand_num=rand(1);
 x=min(find(prob_value>rand_num));
 H(:,j)=A(:,x(1));
end
toc;                   
end
