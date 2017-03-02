%以中心(Cx,Cy)为偏角中心点，求出各个偏角（2*pi(L-1)(/A-1)）,L=0,1...A-1)值到边界区域edge
%所相交的像素点的坐标。遍历像素点的偏角值，当某个像素相对于中心的偏角alpha和所求偏角angle相差小于pi/16时，
%可考虑使用该位置记录为相应的偏角位置，当有多个位置满足时，使用误差最小的作为替代位置。
%当在误差的范围内找不到合适的点来描述偏角anglg时与边界区域的交点时，取所有像素点中到中心点最远的R，
%记录该位置为x=Cx+R*sin(angle),y=Cy+R*cos(angle)
function Z=f_Z(Res)
  [a,b]=size(Res);
  Z1=zeros(16,1);
  [Rmax,k]=max(Res(:,5));
  X_Rmax=Res(k,1);
  Y_Rmax=Res(k,2);
  flag=pi/16;    %所设置误差
for i=0:7
    angle=i*2*pi/8;
    t_min=5*pi;
    for j=1:a
        t_cha=abs(Res(j,3)-angle);
        t_abs=abs(t_min-angle);
        if(t_cha<t_abs)
            t_r=Res(j,5);
            t_min=Res(j,3);
            tx=Res(j,1);
            ty=Res(j,2);
        end
    end
    if(abs(t_min-angle)>flag)
      t_r=Rmax;
      t_min=angle;
      tx=X_Rmax;
      ty=Y_Rmax;
    end
    Z1(i+1,1)=tx;   %Z1中Z1(1,1:8)按照顺序存放x坐标,Z1(1,9:16)按照顺序存放y坐标
    Z1(i+9,1)=ty;
end
Z=complex(Z1(1:8),Z1(9:16));     % 变换成Zj=(x+i*y,....)形式
end