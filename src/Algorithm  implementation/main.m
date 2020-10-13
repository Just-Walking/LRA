%define parameter
n = 3000;
d=50;
r=15;
delta = 0.0001;
level_num=50; % j /in level
s=15; % larger than k
t=20;
%Initialize matrix a
[A,bucket_average_num,bucket_last_num]=init_A_function(d,n,t);
%Divide level
[S_level,S_level_value,M_bucket,T_level_value]=level_function(n,t,bucket_average_num,bucket_last_num,A,level_num);
%Sample
[F,H_S_level]=sample_function(s,n,A,t,M_bucket,t,S_level,T_level_value,level_num,bucket_average_num,bucket_last_num);