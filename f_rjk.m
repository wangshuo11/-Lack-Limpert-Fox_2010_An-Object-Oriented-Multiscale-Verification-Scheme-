% function Rjk=f_rjk(Zjkc,Zjc)
close all;
clear all;
clc;
Zjkc=[1+2i;2+3i;4+5i;6+7i]
Zjkc'
Zjc=[11-1i;12-3i;34-5i;5-3i]
t1=(Zjkc)'*Zjc
t2=(Zjkc)'*Zjkc
t3=abs(t1)
Rjk=t3/t2;
% end