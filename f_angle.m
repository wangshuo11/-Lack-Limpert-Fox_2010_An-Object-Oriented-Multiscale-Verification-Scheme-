 %遍历像素，并求出每个像素所对应Res=（x坐标，y坐标,对应的偏角angle，与中心点的距，所在象限）
%返回的结果是一个矩阵Res，每一行分别是（x坐标，y坐标,对应的偏角angle，与中心点的距，所在象限）
function Res=f_angle(boundary,Cx,Cy)
[k,b]=size(boundary);    %k是边界矩阵的长度，也是像素点的数目
Res=zeros(k,5);         %初始化Res()
for i=1:k
    tx=boundary(i,1);     %tx取出i位置像素的x坐标
    ty=boundary(i,2);     %ty取出i位置像素的y坐标
    
   temp=(ty-Cy)/(tx-Cx);    %计算正切tan(y/x)
   value=atan(temp);        %求出反正切值value既是偏角
   Res(i,1)=tx;             %按照i循环放入Res()矩阵中
   Res(i,2)=ty;
   dx=tx-Cx;                 %像素点坐标和cell中心点坐标差值（dx,dy）
   dy=ty-Cy;
   if(dx>0)                     %假设中心点为原点，建立坐标系，判断象限，坐标系的建立和matlab中图像的坐标系一致
       if(dy>=0)
           Res(i,4)=1;
             Res(i,3)=value;
             Res(i,5)=sqrt(dx*dx+dy*dy);
       end
   end
   if(dx<=0)
       if(dy>0)
           Res(i,4)=2;
           Res(i,3)=pi+value;
           Res(i,5)=sqrt(dx*dx+dy*dy);
       end
   end
   if(dx<0)
       if(dy<=0)
           Res(i,4)=3;
           Res(i,3)=value+pi;
           Res(i,5)=sqrt(dx*dx+dy*dy);
       end
   end
   if(dx>=0)
       if(dy<0)
           Res(i,4)=4;
             Res(i,3)=2*pi+value;
              Res(i,5)=sqrt(dx*dx+dy*dy);
       end
   end
end
end