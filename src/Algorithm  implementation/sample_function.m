function [F,H_S_level]=sample_function(s,n,A,t,M_bucket,bucket_num,S_level,T_level_value,level_num,bucket_average_num,bucket_last_num)

M_sum=sum(M_bucket);
%Mbucket get
M_pro=M_bucket./M_sum;
for i=2:bucket_num
    M_pro(i)=M_pro(i)+M_pro(i-1);
end


level_select_condition=zeros(level_num,bucket_num);
for i=1:bucket_num
    for j=1:level_num
        level_select_condition(j,i)=S_level(j,i)*T_level_value(j,i);
    end
end
for i=1:bucket_num
    level_select_condition_sum(i)=sum(level_select_condition(:,i))
end
for i=1:bucket_num
    level_pro(:,i)=level_select_condition(:,i)./level_select_condition_sum(i);
end
for i=1:bucket_num
    for j=2:level_num
        level_pro(j,i)=level_pro(j,i)+level_pro(j-1,i);
    end
end



%Hsketch level
H_bucket=[];
for i=1:bucket_average_num:n-bucket_last_num
    A_bucket=A(:,i:i-1+bucket_average_num);
    H_bucket=[H_bucket,Hsketch(A_bucket,s)];
end

A_bucket=A(:,n+1-bucket_average_num:n);
H_bucket=[H_bucket,Hsketch(A_bucket,s)];
%Hsketch logsum
H_logsum_bucket=[];
for i=1:s:bucket_num*s
    A_bucket=A(:,i:i-1+s);
    H_logsum_bucket=[H_logsum_bucket,logsum(A_bucket)];
end

H_T_level_value=zeros(level_num,bucket_num)
for i=1:bucket_num
    for j=1:level_num
        H_T_level_value(j,i)=H_logsum_bucket(i)/(2^(j-1))
        H_T_level_value(j+1,i)=0;
    end
end
%Hsketch level
H_S_level=zeros(level_num,bucket_num);
H_S_level_value=[];
i=1;
for j=1:s:bucket_num*s
    for k=j:j-1+s
        level_value=norm(A(:,k),'fro').^2;
        H_S_level_value(1,k)=level_value;
        level_evoluate=max(find(H_T_level_value(:,i)>H_S_level_value(1,k)));
        H_S_level_value(2,k)=level_evoluate;
        H_S_level(level_evoluate,i)=H_S_level(level_evoluate,i)+1;
    end
    i=1+i;
end
%sample coloum
F=[];
M_pro_exist=1:bucket_num;
while size(F,2)<s
    %pro_rand=randi([1,10000])/10000;
    %M_pro_get=min(find(M_pro>pro_rand));
    if isempty(M_pro_exist)
        break;
    end 
    M_pro_get=randsample(M_pro_exist,1,true);
    M_pro_exist(find(M_pro_exist==M_pro_get))=[]

    pro_rand=randi([1,10000])/10000;
    level_get=min(find(level_pro(:,M_pro_get)>pro_rand));

    k=max(1,ceil(level_get-log(s*log(n))));%level_get-log(s*log(n))
    
    H_get_index=find(H_S_level_value(2,s*M_pro_get:M_pro_get+s-1)==k);
    H_get_value=H_S_level_value(1,H_get_index);
    H_adapt_A_index=find((H_get_value>T_level_value(level_get+1,M_pro_get))&(H_get_value<T_level_value(level_get,M_pro_get)))
    if isempty(H_adapt_A_index)
        continue;
    end
    H_adapt_get=randsample(H_adapt_A_index,1,true);
    F=[F,H_bucket(:,H_adapt_get)]
end