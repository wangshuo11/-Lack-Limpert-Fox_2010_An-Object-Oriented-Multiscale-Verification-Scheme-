1：将文件夹添加到matlab路径；
2:运行test_f_verification.m,可以得到0-100的结果存在根目录下res.txt中，
  每一行代表一组anal和fcst的检验,检验结果在第1行代表anal_0.dat和fcst_0.dat
  的验证结果，依次第i+1行代表anal_i.dat和fcst_i.dat的结果；
3.结果为[-1,-1,1..-1]的代表fcst或者anal没出现雨区，因此没做验证；
4.可以修改i的循环范围得到不同的结果，目前使用matlab2016b测量0.dat-100.dat
  时间约1.2秒，