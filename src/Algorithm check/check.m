%We need to compare rate and error of us to the former algorithm
%In this part, we compute our rate and error and we use the same data set as former

A=importdata('enwiki_cooccurrence_10k_10k.mat');
A=reshape(A.val(1:50000000),[1000,50000]);
A=log2(abs(A)+1);
s=[800,2500,10000,30000];
err=zeros(1,length(s));
T=zeros(1,length(s));
for index=1:length(s)
    tic;
    F=Hsketch(A,s(index));
    L = SVD_s(F,k);
    N= SVD(A,k);
    Q=L*L'*A;
    X = A-Q;
    Y= A-N;
    M=norm(X,'fro');
    P=norm(Y,'fro');
    err(index)=M./P
    toc;
end

s=s./size(A,2);
plot(s,err,'-db')
xlabel('space used/total space of the matrix','FontSize',12,'FontWeight','bold','Color','k')
ylabel('Error ratio','FontSize',12,'FontWeight','bold','Color','k')
