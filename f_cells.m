% f_cells()主要计算出每个雨区cell的(x+i*sin(angle)*y...)的向量表示既是Z,
%在计算出每个cell的Z_intensity(Cx,Cy,Cmin,Cmax,Cavg)，Cell的中心(Cx,Cy)和雨水强度最小值最大值以及均值（Cmin,Cmax,Cavg）
function [Z,Z_intensity]=f_cells(file)

intensity=f_intensities(file);  %f_intensity()用于计算Cell的中心(Cx,Cy)和雨水强度最小值最大值以及均值（Cmin,Cmax,Cavg）
[k,b]=size(intensity); 
Z_intensity=intensity';         %将计算结果转置，转置后每一列表示对应cell的中心(Cx,Cy)和雨水强度最小值最大值以及均值（Cmin,Cmax,Cavg）
intensity=intensity';
Z=zeros(8,k);                   %初始化Z

%首使用阈值：25过滤雨区，然后8联通过滤，在二值化
fid = fopen(file, 'r');           
I0= fread(fid,7808,'float32' ); 
I1=reshape(I0,128,61);      
I2=I1;
I2(I2<=25)=0;
I2(I2>25)=1;
[I2,num]=bwlabel(I2,8);
I2= bwareaopen(I2,8,8);
[I2,num]=bwlabel(I2,8);
[B,L]=bwboundaries(I2,'noholes');      %提取边界，B返回的是每个区域的边界坐标，EXAMPLE:B{1}第1个边界的坐标矩阵2*N（N代表边界点数目）
fclose(fid);
          %循环计算每个cell的向量表示,和Z_intensity()对应着存储在Z中
 for j=1:k
    Cx=intensity(1,j);
    Cy=intensity(2,j);
    Res=f_angle(B{j},Cx,Cy);
    Z(:,j)=f_Z(Res);            %f_z()函数主要用于返回计算的cells的向量表示Z(x+y*i....)
 end
end