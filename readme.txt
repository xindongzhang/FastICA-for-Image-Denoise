cal_ica_W.m 用fixed-point求解W和A

data.m 抓取数据并进行预处理

estimate.m 是fixed-point（fastICA）方法的实现，并且将每步的解决写入ica.mat中

利用学好的ica.mat可以进行图象去噪: 详细可以看demo-denoise-winsize8和16