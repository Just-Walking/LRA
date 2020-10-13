function [S_level,S_level_value,M_bucket,T_level_value]=level_function(n,bucket_num,bucket_average_num,bucket_last_num,A,level_num)

M_bucket=[];
for i=1:bucket_average_num:n-bucket_last_num
    A_bucket=A(:,i:i-1+bucket_average_num);
    M_bucket=[M_bucket,logsum(A_bucket)];
end

A_bucket=A(:,n+1-bucket_average_num:n);
M_bucket=[M_bucket,logsum(A_bucket)];

%level_num=10;%set level num
T_level_value=zeros(level_num,bucket_num)
for i=1:bucket_num
    for j=1:level_num
        T_level_value(j,i)=M_bucket(i)/(2^(j-1));
        T_level_value(j+1,i)=0;
    end
end

S_level=zeros(level_num,bucket_num);
S_level_value=[];
i=1;
for j=1:bucket_average_num:n-bucket_last_num
    for k=j:j-1+bucket_average_num
        level_value=norm(A(:,k),'fro').^2;
        S_level_value=[S_level_value,level_value];
        level_evoluate=max(find(T_level_value(:,i)>S_level_value(k)));
        S_level(level_evoluate,i)=S_level(level_evoluate,i)+1;
    end
    i=1+i;
end
j=j+bucket_average_num;
for k=j:n
        level_value=norm(A(:,k),'fro').^2;
        S_level_value=[S_level_value,level_value];
        level_evoluate=max(find(T_level_value(:,i)>S_level_value(k)));
        S_level(level_evoluate,i)=S_level(level_evoluate,i)+1;
end
end