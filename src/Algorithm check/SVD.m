function [L] = SVD(A,k)
% Input the matrix A,and the expect rank k
% Output the optimal LRA L for A

[r_s,c_s]=size(F);
[U,S,V]=svd(F);
d=size(S,1);
U=U(1:r_s,1:k);
S=S(1:k,1:k);
V=V(1:c_s,1:k);
L=U*S*V';
% S(k+1:r_s,k+1:c_s)=0;
% L= U*S*V';
% r=min(size(F,1),size(F,2));
% S_R=S(1:k,1:k);
% S_R(k+1:r_s,k+1:c_s)=0;
% R=zeros(size(F));
% R=S_R+R(1:r_s,1:c_s);
% for i =k+1:r
%     S(i,i)=0;
% end

end