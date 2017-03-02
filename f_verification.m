%[flag,SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]读入两个文件file_truth,file_forecast,分别计算各项误差；
%EXAMPLE:
%    [flag,SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_verification('3.dat','1.dat')
function [flag,SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_verification(file_truth,file_forecast)
 
%f_cells()的作用：识别各个雨区，并且计算出每个雨区的特征信息（Cx，Cy,Cmin,Cmax,Cavg）和
%向量表示Zj=(X0+sin(angle)*Y*i....)
 %后缀为jk的表示的是forecast的信息，后缀是j的表示truth的信息
%Zj的每一列表示truth的每个cell的vector informations；
%Zjk矩阵的每一列表示forecast的每个cell的vector
%Zj_intensity矩阵中每一列表示truth中每个雨区的中心（Cx，Cy）和降雨强度（Cmin,Cmax,Cavg）;
%Zjk_intensity矩阵中每一列表示forecast中每个雨区的中心（Cx，Cy）和降雨强度（Cmin,Cmax,Cavg）;
%Zjk和Zjk_intesity同一列表示forecast同一个雨区的信息；
%Zj和Zj_intesity同一列表示truth同一个雨区的信息；

[Zj,Zj_intensity]=f_cells(file_truth);                                  
[Zjk,Zjk_intensity]=f_cells(file_forecast);

%求出矩阵的大小，矩阵的宽既是image中celss的数量，Zjkb表示forecast的cells数量，Zj表示ruth的cells的数量
[Zjka,Zjkb]=size(Zjk);
[Zja,Zjb]=size(Zj);
     
%根据truth的cells和forecast 的cells的差值，分为三种情况讨论
    if(Zjkb==0||Zjb==0)
        disp('预测错误严重！');
        %没有雨区，验证出错！
        flag=-1;
        SEmin=-1;
        SEmax=-1;
        SEavg=-1;
        SEd=-1;
        SEr=-1;
        SEt=-1;
        RSE=-1;
        D=-1;
    elseif(Zjkb==Zjb) %truth 的cells等于forecast的cells时
        [SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_equal(Zjk,Zj,Zjk_intensity,Zj_intensity);  
        flag=0;%其中(Zjkb>Zjb)flag表示false,(Zjkb==Zjb)flag表示hit，flag(Zjkb<Zjb)flag表示miss
        
    elseif(Zjkb<Zjb)           %truth 的cells比forecast的cells多时
         [SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_big(Zjk,Zj,Zjk_intensity,Zj_intensity);
         flag=1;
         
    elseif(Zjkb>Zjb) %truth 的cells比forecast的cells少时
         [SEmin,SEmax,SEavg,SEd,SEr,SEt,RSE,D]=f_small(Zjk,Zj,Zjk_intensity,Zj_intensity);
         flag=-1;
      end
end