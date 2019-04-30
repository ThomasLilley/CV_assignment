function kalmanTracking()

x1 = csvread('x.csv');
y = csvread('y.csv');
a = csvread('a.csv');
b = csvread('b.csv');

z = [a;b];

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


% for i = 1:100
%     c(i) = a(i) - px(i);
%     d(i) = b(i) - py(i);
% end
% e0 = c + d;
% [f0, fn] = sumsqr(e0);
% f1 = f0/fn;
% f2 = sqrt(f1);
% disp(f2)

for i = 1:100
    errx(i) = ((px(i) - a(i)).^2);
    erry(i) = ((py(i) - b(i)).^2);
    err(i) = sqrt(errx(i) + erry(i));

end

meanerr = mean(err)
stdev = std2(err)
rmse = rms(err)


