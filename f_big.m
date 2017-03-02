%当truth 的cells数目大于forest的cells数目，使用f_small（）函数计算[SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]
%按照论文中每个truth的cell都需要匹配的原则，将truth的cells分解为等于的（f_equal()）和小于的情况去解决（f_small()）;
%这个时候允许forecast的cells被多次访问；
function  [SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_big(Zjk,Zj,Zjk_intensity,Zj_intensity)

     [aj,bj]=size(Zj);
     [ajk,bjk]=size(Zjk);
     T_res=zeros(1,8);
     k=fix(bj/bjk);
     m=mod(bj,bjk);
                 %k表示truth中cells的数目是forcast中cells数目的k倍，m表示余数，于是可以使用k次f_equal()和1次f_small()解决
     for i=0:k-1
         t_Zj=Zj(:,bjk*i+1:(i+1)*bjk);
         t_Zj_intensity=Zj_intensity(:,bjk*i+1:(i+1)*bjk);
                                                         %f_bigtoequal()用来计算这种情况下各项误差并且累计
         [SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_bigtoequal(Zjk,t_Zj,Zjk_intensity,t_Zj_intensity); 
         T_res(1,1)=T_res(1,1)+ SEmin;
         T_res(1,2)=T_res(1,2)+ SEmax;
         T_res(1,3)=T_res(1,3)+ SEavg;
         T_res(1,4)=T_res(1,4)+SEd;
         T_res(1,5)=T_res(1,5)+ SEr;
         T_res(1,6)=T_res(1,6)+ SEt;
         T_res(1,7)=T_res(1,7)+RSE;
         T_res(1,8)=T_res(1,8)+D;
     end        
     if(m>0)                       %f_bigtoequal()用来计算这种情况下各项误差并且累计
         t_Zj=Zj(:,(k*bjk+1):bj);
         t_Zj_intensity=Zj_intensity(:,(bjk*k+1):bj);
         [SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_bigtoequal(Zjk,t_Zj,Zjk_intensity,t_Zj_intensity);
         T_res(1,1)=T_res(1,1)+ SEmin;
         T_res(1,2)=T_res(1,2)+ SEmax;
         T_res(1,3)=T_res(1,3)+ SEavg;
         T_res(1,4)=T_res(1,4)+SEd;
         T_res(1,5)=T_res(1,5)+ SEr;
         T_res(1,6)=T_res(1,6)+ SEt;
         T_res(1,7)=T_res(1,7)+RSE;
         T_res(1,8)=T_res(1,8)+D;
     end
                     % %按照公式SEd,SEt,SEr取均值
     SEd=T_res(1,4)/bj;
     SEr=T_res(1,5)/bj;
     SEt=T_res(1,6)/bj;
 end