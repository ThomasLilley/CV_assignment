x = csvread('x.csv');
y = csvread('y.csv');

a = csvread('a.csv');
b = csvread('b.csv');

plot(x, y, 'xb');
hold;
plot(a, b, '+r');

nx = a - x;
ny = a - y;