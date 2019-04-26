function kalmanTracking()

x1 = csvread('x.csv');
y = csvread('y.csv');
a = csvread('a.csv');
b = csvread('b.csv');

z = [a,b];

% Track a target with a Kalman filter
% z: observation vector
% Return the estimated state position coordinates (px,py)
dt = 0.05; % time interval
N = length(z); % number of samples
F = [1 dt 0 0; 0 1 0 0; 0 0 1 dt; 0 0 0 1]; % CV motion model
Q = [0.2 0 0 0; 0 0.5 0 0; 0 0 0.2 0; 0 0 0 0.5]; % motion noise
H = [1 0 0 0; 0 0 1 0]; % Cartesian observation model
R = [4 0; 0 4]; % observation noise
x = [0 0 0 0]'; % initial state
P = Q; % initial state covariance
s = zeros(4,N);
for i = 1 : N
[xp, Pp] = kalmanPredict(x, P, F, Q);
[x, P] = kalmanUpdate(xp, Pp, H, R, z(:,i));
s(:,i) = x; % save current state
end
px = s(1,:); % NOTE: s(2, :) and s(4, :), not considered here,
py = s(3,:); % contain the velocities on x and y respectively

figure
plot(x1, y, 'xb')
hold;
plot(px, py, '+r')

figure
plot(a, b, 'xb')
hold;
plot(px, py, '+r')


for i = 1:100
    c(i) = a(i) - px(i);
    d(i) = b(i) - py(i);
end

[s0, nx] = sumsqr(c);
s1 = s0/nx;
s2 = sqrt(s1);

[t0, nx] = sumsqr(d);
t1 = t0/nx;
t2 = sqrt(t1);

disp({'RMSE X', s2});
disp({'RMSE Y', t2});

end


