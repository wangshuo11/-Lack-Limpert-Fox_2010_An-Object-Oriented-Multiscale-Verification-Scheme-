close all;
clear all;
clc;
tic
T_res=zeros(1,9);   %暂存结果
for i=0:100
    str_truth=strcat('anal_',int2str(i));
    str_truth=strcat(str_truth,'.dat');
    str_forecast=strcat('fcst_',int2str(i));
    str_forecast=strcat(str_forecast,'.dat');
[T_res(1,1),T_res(1,2),T_res(1,3),T_res(1,4),T_res(1,5),T_res(1,6),T_res(1,7),T_res(1,8),T_res(1,9)]=f_verification2(str_truth,str_forecast);
write_file('res.txt',T_res);   %每次结果对应着追加到res.txt中
end
toc;   %tic..toc用于显示程序执行时间