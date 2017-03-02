% f_cells()��Ҫ�����ÿ������cell��(x+i*sin(angle)*y...)��������ʾ����Z,
%�ڼ����ÿ��cell��Z_intensity(Cx,Cy,Cmin,Cmax,Cavg)��Cell������(Cx,Cy)����ˮǿ����Сֵ���ֵ�Լ���ֵ��Cmin,Cmax,Cavg��
function [Z,Z_intensity]=f_cells(file)

intensity=f_intensities(file);  %f_intensity()���ڼ���Cell������(Cx,Cy)����ˮǿ����Сֵ���ֵ�Լ���ֵ��Cmin,Cmax,Cavg��
[k,b]=size(intensity); 
Z_intensity=intensity';         %��������ת�ã�ת�ú�ÿһ�б�ʾ��Ӧcell������(Cx,Cy)����ˮǿ����Сֵ���ֵ�Լ���ֵ��Cmin,Cmax,Cavg��
intensity=intensity';
Z=zeros(8,k);                   %��ʼ��Z

%��ʹ����ֵ��25����������Ȼ��8��ͨ���ˣ��ڶ�ֵ��
fid = fopen(file, 'r');           
I0= fread(fid,7808,'float32' ); 
I1=reshape(I0,128,61);      
I2=I1;
I2(I2<=25)=0;
I2(I2>25)=1;
[I2,num]=bwlabel(I2,8);
I2= bwareaopen(I2,8,8);
[I2,num]=bwlabel(I2,8);
[B,L]=bwboundaries(I2,'noholes');      %��ȡ�߽磬B���ص���ÿ������ı߽����꣬EXAMPLE:B{1}��1���߽���������2*N��N����߽����Ŀ��
fclose(fid);
          %ѭ������ÿ��cell��������ʾ,��Z_intensity()��Ӧ�Ŵ洢��Z��
 for j=1:k
    Cx=intensity(1,j);
    Cy=intensity(2,j);
    Res=f_angle(B{j},Cx,Cy);
    Z(:,j)=f_Z(Res);            %f_z()������Ҫ���ڷ��ؼ����cells��������ʾZ(x+y*i....)
 end
end