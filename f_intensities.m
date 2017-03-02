%�����ļ�file������file�ļ��ĸ��������Cx,Cy,Cmin,Cmax,Cavg��

function intensity=f_intensities(file)
fid = fopen(file, 'r');
I0= fread(fid,7808,'float32' ); 
I1=reshape(I0,128,61);
I2=I1;
I2(I2<=25)=0;
I2(I2>25)=1;
[I2,num]=bwlabel(I2,8);
I2= bwareaopen(I2,8,8);
[I2,num]=bwlabel(I2,8);
fclose(fid);
intensity=zeros(num,5);
%���� Cell������(Cx,Cy)����ˮǿ����Сֵ���ֵ�Լ���ֵ��Cmin,Cmax,Cavg��
for k=1:num
    countx=0;
    county=0;
    count=0;
    Cmin=0;
    Cmax=0;
    sum=0;
    for x=1:128
        for y=1:61
            if(I2(x,y)==k)
                countx=countx+x;
                county=county+y;
                count=count+1;
                if(count==1)
                    Cmin=I1(x,y);  %�������ҳ������󣬲��ܽ��ж�ֵ������Ϊ��Ҫͳ�ƽ����ǿ�ȣ�����ʹ�����û�ж�ֵ����I1
                    Cmax=I1(x,y);
                else 
                    if(Cmin>I1(x,y))
                       Cmin=I1(x,y);
                    end
                    if(Cmax<I1(x,y))
                        Cmax=I1(x,y);
                    end
                end
                sum=sum+I1(x,y);
            end
        end
    end
    intensity(k,1)=countx/count;
    intensity(k,2)=county/count;
    intensity(k,3)=Cmin;
    intensity(k,4)=Cmax;
    intensity(k,5)=sum/count;
end
end

