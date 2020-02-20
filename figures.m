%% Figure 1
n_models = 3;

% Gaussian %
i = 1;
x = linspace(-5, 5, 100);
func = @(x) normpdf(x, 0, 1);

subplot(n_models, 2, 2 * (i - 1) + 1);
area(x, func(x));
ylim([0, .45])
% axis square
aux.VLine(0)
aux.Fix

subplot(n_models, 2, 2 * (i - 1) + 2);
fplot(func, [-5, 5]);
cy = cumsum(func(x));
area(x, cy);
ylim([0, 11])
% axis square
aux.VLine(0)
yticks([0, max(cy)])
aux.Fix

% Bimodal %
i = 2;
xrange = [3, 24];
m = [9 18];
s = [1.8 1.8];
x = linspace(3, 24, 100);
funcs{1} = @(x) .6 * normpdf(x, m(1), s(1));
funcs{2} = @(x) .4 * normpdf(x, m(2), s(2));

subplot(n_models, 2, 2 * (i - 1) + 1);
y = funcs{1}(x) + funcs{2}(x);
area(x, y, 'EdgeColor', 'none');
hold on
fplot(funcs{1}, [m(1) - 3*s(1) m(1) + 3*s(1)], 'k', 'LineWidth', 2);
fplot(funcs{2}, [m(2) - 3*s(2) m(2) + 3*s(2)], 'k', 'LineWidth', 2);
hold off

ylim([0, max(y) * 1.1])
xlim(xrange)

% axis square
aux.VLine(9)
aux.VLine(18)
aux.Fix

subplot(n_models, 2, 2 * (i - 1) + 2);
cy = cumsum(y);
area(x, cy);
ylim([0, max(cy) * 1.1])
xlim(xrange)
% axis square
aux.VLine(m(1))
aux.VLine(m(2))
yticks([0, max(cy)])
aux.Fix

% Square %
i = 3;
xrange = [-5 5];
x = linspace(xrange(1), xrange(2), 100);
func = @(x) x > -3 & x < 3;

subplot(n_models, 2, 2 * (i - 1) + 1);
y = func(x);
area(x, y);
ylim([0, max(y) * 1.1])
% axis square
aux.VLine(0)
aux.Fix

subplot(n_models, 2, 2 * (i - 1) + 2);
cy = cumsum(y);
area(x, cy);
ylim([0, max(cy) * 1.1])
xlim(xrange)
% axis square
aux.VLine(0)
yticks([0, max(cy)])
aux.Fix


%% 2nd figure
% bi-normal
n = 100;
freeze = false;
xrange = [3, 24];
m = [9 18];
sigma = [1.8 1.8];
x = linspace(3, 24, 100);
p = [.6, .4];
funcs{1} = @(x) p(1) * normpdf(x, m(1), sigma(1));
funcs{2} = @(x) p(2) * normpdf(x, m(2), sigma(2));

gm = gmdistribution(m(:), reshape(sigma, [1, 1, length(p)]), p(:));
if ~freeze
    xs = gm.random(n);
end
s = [0; diff(xs) > 0];
subplot(3,1,1);
plot(xs, 'o-', 'MarkerFaceColor', 'k')
aux.HLine(m(1))
aux.HLine(m(2))
axis off
subplot(3,1,2);

for i=1:length(s)
    plot([i i], [0, s(i)], 'k-')
    hold on
end
axis off
hold off

n = 1000000;
if ~freeze
    x = gm.random(n);
end
s = [0; diff(x) > 0];
edges = linspace(xrange(1), xrange(2), 20);
X = discretize(x, edges);
h = accumarray(X(~isnan(X)), s(~isnan(X)), [length(edges)-1 1], @mean, nan);
subplot(3,3,7)
e = (edges(1:end-1) + edges(2:end))/2;
refh = p(1) * normcdf(e, m(1), sigma(1)) + p(2) * normcdf(e, m(2), sigma(2));
plot(e, h, ':o', e, refh, 'MarkerFaceColor', 'k')
hold off
aux.VLine(m(1))
aux.VLine(m(2))


%% normal
n = 100;
freeze = false;
xrange = [-5, 5];
m = [0 10];
sigma = [1 1];
x = linspace(3, 24, 100);
p = [1, eps];
funcs{1} = @(x) p(1) * normpdf(x, m(1), sigma(1));
funcs{2} = @(x) p(2) * normpdf(x, m(2), sigma(2));

gm = gmdistribution(m(:), reshape(sigma, [1, 1, length(p)]), p(:));
if ~freeze
    xs = gm.random(n);
end
s = [0; diff(xs) > 0];
subplot(3,1,1);
plot(xs, 'o-', 'MarkerFaceColor', 'k')
aux.HLine(m(1))

axis off;
subplot(3,1,2);

for i=1:length(s)
    plot([i i], [0, s(i)], 'k-')
    hold on
end
hold off
axis off;

n = 1000000;
if ~freeze
    x = gm.random(n);
end
s = [0; diff(x) > 0];
edges = linspace(xrange(1), xrange(2), 20);
X = discretize(x, edges);
h = accumarray(X(~isnan(X)), s(~isnan(X)), [length(edges)-1 1], @mean, nan);
subplot(3,3,7)
e = (edges(1:end-1) + edges(2:end))/2;
refh = p(1) * normcdf(e, m(1), sigma(1)) + p(2) * normcdf(e, m(2), sigma(2));
plot(e, h, ':o', e, refh, 'MarkerFaceColor', 'k')
hold off
aux.VLine(m(1))

%% uniform
n = 100;
freeze = false;
xrange = [-5, 5];
m = [0 10];
sigma = [1 1];
x = linspace(3, 24, 100);
p = [1, eps];
funcs = {};
funcs{1} = @(x) x > -3 & x < 3;

if ~freeze
    xs = 6 * rand(n, 1) - 3;
end
s = [0; diff(xs) > 0];
subplot(3,1,1);
plot(xs, 'o-', 'MarkerFace', 'k')
aux.HLine(0)

axis off;

subplot(3,1,2);

for i=1:length(s)
    plot([i i], [0, s(i)], 'k-')
    hold on
end
hold off
axis off;
n = 1000;
if ~freeze
    x = 6 * rand(n, 1) - 3;
end
s = [0; diff(x) > 0];
edges = linspace(xrange(1), xrange(2), 20);
X = discretize(x, edges);
h = accumarray(X(~isnan(X)), s(~isnan(X)), [length(edges)-1 1], @mean, nan);
subplot(3,3,7)
e = (edges(1:end-1) + edges(2:end))/2;
refh = unifcdf(e, -3, 3);
plot(e, h, ':o', e, refh, 'MarkerFaceColor', 'k')
hold off
aux.VLine(0)