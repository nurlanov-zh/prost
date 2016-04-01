%%
% load input image
im = imread('../../images/dog.png');
[ny, nx, nc] = size(im);
f = double(im(:)) / 255.; % convert to [0, 1]

%%
% parameters
grad = spmat_gradient2d(nx,ny,nc);
lmb = 0.3;

%%
% problem
u = prost.variable(nx*ny*nc);
q = prost.variable(2*nx*ny*nc);

u.fun = prost.function.sum_1d('square', 1, f, lmb, 0, 0);
q.fun = prost.function.sum_norm2(... 
    2 * nc, false, 'ind_leq0', 1, 1, 1, 0, 0);

prost.set_dual_pair(u, q, prost.linop.sparse(grad));

prob = prost.min_max( {u}, {q} );

%%
% specify solver options
backend = prost.backend.pdhg('stepsize', 'alg2', ...
                             'residual_iter', -1, ...
                             'alg2_gamma', 0.05 * lmb);

pd_gap_callback = @(it, x, y) example_rof_pdgap(it, x, y, grad, ...
                                                f, lmb, ny, nx, nc);

opts = prost.options('max_iters', 20000, ...
                     'interm_cb', pd_gap_callback, ...
                     'num_cback_calls', 100, ...
                     'verbose', false);

tic;
prost.init();
prost.set_gpu(0);
result = prost.solve(prob, backend, opts);
prost.release();
toc;

%%
% show result
imshow(reshape(u.val, [ny nx nc]));
