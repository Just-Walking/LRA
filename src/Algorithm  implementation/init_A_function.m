function [H,bucket_average_num,bucket_last_num]=init_A_function(d,n,bucket_num)
A=[]
for j=10:20
A=[2.^j*rand(d,n./10),A]
end
%You also could import data and reshape it
%A=importdata('enwiki_cooccurrence_10k_10k.mat');
%A=reshape(A.val(1:n*d,[d,n]);


A=log2(abs(A)+1);
select_index=1:n;
size_index=size(select_index,2)
%split A
bucket_average_num=floor(n/bucket_num);
if mod(n,bucket_num)~=0
    bucket_last_num=mod(n,bucket_num)+bucket_average_num;
else
    bucket_last_num=bucket_average_num;
end
H=[];
a=[];
for i=1:bucket_num-1
    for j=1:bucket_average_num
        select_index_num =randi(size_index);
        select_coloum_num=select_index(select_index_num)
        H=[H,A(:,select_index_num)];
        select_index(select_index_num)=[];
        [ans,size_index]=size(select_index)
        a=[a,select_coloum_num]
    end
end
for i=1:bucket_last_num
        select_index_num=randi(size_index);
        select_coloum_num=select_index(select_index_num)
        H=[H,A(:,select_index_num)];
        select_index(select_index_num)=[];
        [ans,size_index]=size(select_index)
        a=[a,select_coloum_num]
end
end