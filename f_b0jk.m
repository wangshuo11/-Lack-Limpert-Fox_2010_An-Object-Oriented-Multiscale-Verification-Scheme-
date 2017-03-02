function B0jk=f_b0jk(Zjk,Zj,Rjk,FFjk)
B0jk=sum(Zjk)/7-Rjk*exp(i*FFjk)*sum(Zj)/7;
end