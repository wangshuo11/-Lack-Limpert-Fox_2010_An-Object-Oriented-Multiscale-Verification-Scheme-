%2007年论文公式（8）
function Bjk=f_Bjk(Zjk_avg,Zj_avg,Rjk,FFjk)
Bjk=Zj_avg-Rjk*exp(i*FFjk)*Zjk_avg;
end
