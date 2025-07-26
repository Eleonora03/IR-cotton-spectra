clear; clc; close all;

% ===========================
% Load and preprocess the data
% ===========================
[X, No, Nv, wavelength] = LOAD_DATA;

% ===========================
% Perform Principal Component Analysis
% ===========================
[L, S, Sigma, sigma, chi] = PCA_INPUT(X, No);

% ===========================
% Visualize PCA results
% ===========================
PLOT_PCA(X, L, S, Sigma, sigma, chi, wavelength, No);
