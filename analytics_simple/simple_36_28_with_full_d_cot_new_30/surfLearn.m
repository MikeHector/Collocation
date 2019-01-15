%Test out some stuff with plotting surfaces

%% uniform
x = [1 2 3 4];
y = .1*x;

[X Y] = meshgrid(x,y);

Z= X.*Y;
surf(x,y,Z);

%% non uniform - interpolate
x = rand(100,1)*16-8;
y = rand(100,1)*16-8;
r = sqrt(x.^2+y.^2)+eps;
z = sin(r)./r;

xlin = linspace(min(x),max(x),33);
ylin = linspace(min(y),max(y),33);
[X,Y] = meshgrid(xlin,ylin);

Z = griddata(x,y,z,X,Y,'v4');

surf(X,Y,Z)
hold on;
plot3(x,y,z,'r.','MarkerSize',15)

%% non uniform reshape
p1 = [0 0 0];
p2 = [1 1 1];
p3 = [.1 2 .05];
x = [
    


