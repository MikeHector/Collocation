load('ankle')
s = opt;
load('noAnkle')
sa = opt;

nu = 100* abs(sa.cost - s.cost) / s.cost;


