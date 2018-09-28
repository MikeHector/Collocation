%Check why TD isn't working

load('TDunlocked');
optUnlock = opt;

load('TDlocked.mat')
optLock = opt;

[unlock.a, unlock.b, unlock.c, unlock.d] = SymConFunc(optUnlock.X, optUnlock.param);
[lock.a, lock.b, lock.c, lock.d] = SymConFunc(optLock.X, optLock.param);

[max(max(abs(unlock.a - lock.a))), max(max(abs(unlock.b - lock.b))), max(max(abs(unlock.c - lock.c))), max(max(abs(unlock.d - lock.d)))]

d = unlock.d - lock.d;
dInds = find(d>0);