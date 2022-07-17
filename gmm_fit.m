function[alphas,mus,sigmas] = gmm_fit(x,k)
model = fitgmdist(x,k,'RegularizationValue',0.1);
alphas = model.ComponentProportion;
mus = model.mu;
sigmas = model.Sigma;
