clear;
load('opt_noAnkle_seed.mat');

p.m = 1; p.c = .4; p.k = 20; p.i_motor = 3.65e-04; p.transmission = 80;
p.lf = .15; p.transmission_ankle = 1; p.g = 1; p.apex_height = 1;
p.apex_velocity = 1; p.objWeight = .001; p.c_objWeight = 0; p.N =30;

X = opt.X;
Xblock = dvSymList2Block(X,p);

%Check rows
assert(max(max(opt.dy' - Xblock(5,:))) == 0)

e = get_energy3(opt);

OBJ_F(Xblock, p,3);