function [L, S, Sigma, sigma, chi] = PCA_INPUT(X, No)
% PCA_INPUT  Performs Principal Component Analysis (PCA) on input data.
%
%   [L, S, Sigma, sigma, chi] = PCA_INPUT(X, No)
%
%   Inputs:
%       X  - Input data matrix (observations x variables)
%       No - Number of observations
%
%   Outputs:
%       L     - Matrix of eigenvectors (principal components)
%       S     - Scores (projection of data onto principal components)
%       Sigma - Covariance matrix of centered data
%       sigma - Sorted eigenvalues (variances explained by components)
%       chi   - Centered data matrix

% Center the dataset (subtract mean of each variable)
chi = X - mean(X);

% Compute covariance matrix of centered data
Sigma = cov(chi);

% Eigen decomposition of covariance matrix
[L, D] = eig(Sigma);

% Extract and sort eigenvalues in descending order
[sigma, indx] = sort(diag(D), 'descend');

% Sort eigenvectors accordingly
L = L(:, indx);

% Project centered data onto principal components (scores)
S = chi * L / sqrt(No - 1);

end