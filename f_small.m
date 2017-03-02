%当truth 的cells数目少于forest的cells数目，使用f_small（）函数计算[SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]
function [SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_small(Zjk,Zj,Zjk_intensity,Zj_intensity)
        [a,b]=size(Zj);           
                     %Zjk的每一列存储了一个cells的向量信息，因此矩阵Zj的列数b既是cells的数目
        [ajk,bjk]=size(Zjk);       
                        %Tres()用来累计truth的第i个cell和forecast的第i个cell的误差
        T_res=zeros(1,8);          
                      %用来标记forecast的cells匹配情况
        visit=zeros(bjk,1);
        for i=1:b
            Cx=Zj_intensity(1,i);
            Cy=Zj_intensity(2,i);
          loc=f_equal_close(Cx,Cy,Zjk_intensity,visit,bjk);
           %找出位置为loc的未访问的距离truth的第i个cell的中心(Cx,Cy)最近的forecst的cell 进行match
          t_Zj=Zj(:,i);
          t_Zjk=Zjk(:,loc);
          Cmin_Zj=Zj_intensity(3,i);
          Cmax_Zj=Zj_intensity(4,i);
          Cavg_Zj=Zj_intensity(5,i);
          Cmin_Zjk=Zjk_intensity(3,loc);
          Cmax_Zjk=Zjk_intensity(4,loc);
          Cavg_Zjk=Zjk_intensity(5,loc);
          [SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_res(t_Zjk,t_Zj,Cavg_Zjk,Cavg_Zj,Cmin_Zjk,Cmin_Zj,Cmax_Zjk,Cmax_Zj);
             %f_res()计算出每个两个cell的各项误差
          T_res(1,1)=T_res(1,1)+SEmin;
          T_res(1,2)=T_res(1,2)+SEmax;
          T_res(1,3)=T_res(1,3)+SEavg;
          T_res(1,4)=T_res(1,4)+SEd;
          T_res(1,5)=T_res(1,5)+SEr;
          T_res(1,6)=T_res(1,6)+SEt;
          T_res(1,7)=T_res(1,7)+RSE;
          T_res(1,8)=T_res(1,8)+D;
        end
       SEmin=T_res(1,1);
       SEmax=T_res(1,2);
       SEavg=T_res(1,3);
                    %按照公式SEd,SEt,SEr取均值
       SEd=T_res(1,4)/b;
       SEr=T_res(1,5)/b;
       SEt=T_res(1,6)/b;
       RSE= T_res(1,7);
       D=T_res(1,8);
  end