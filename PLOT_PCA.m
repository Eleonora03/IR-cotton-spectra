function PLOT_PCA(X, L, S, Sigma, sigma, chi, wavelength, No)
% PLOT_PCA  Visualizes PCA results for spectral data.
%
%   PLOT_PCA(X, L, S, Sigma, sigma, chi, wavelength, No)
%
%   Inputs:
%       X         - Original data matrix (observations x variables)
%       L         - Eigenvectors (principal components)
%       S         - Scores (projection of data)
%       Sigma     - Covariance matrix of centered data
%       sigma     - Sorted eigenvalues
%       chi       - Centered data matrix
%       wavelength- Wavelength vector
%       No        - Number of observations

%% Plot original and centered spectra
fig = figure('Position', [150, 150, 1200, 500]);
tiledlayout(1, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

% Original spectra
nexttile
hold on
for i = 1:No
    plot(wavelength, X(i, :), 'LineWidth', 1.5)
end
title('Original NIR Spectra')
xlabel('Wavelength (nm)')
ylabel('Absorbance')
grid on

% Centered spectra
nexttile
hold on
for i = 1:No
    plot(wavelength, chi(i, :), 'LineWidth', 1.5)
end
title('Centered NIR Spectra')
xlabel('Wavelength (nm)')
ylabel('Centered Absorbance')
grid on

saveas(fig, 'Spectra_plot.png')

%% Plot covariance matrix and principal components
fig = figure('Position', [150, 150, 1200, 500]);
tiledlayout(1, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

% Covariance matrix heatmap
nexttile
imagesc(wavelength, wavelength, Sigma)
hold on
contour(wavelength, wavelength, Sigma, 20, 'k-')
colorbar()
title('Covariance Matrix')
xlabel('Wavelength (nm)')
ylabel('Wavelength (nm)')
axis square

% Mean spectrum and first 3 PCs
nexttile
plot(wavelength, mean(X), 'k', 'LineWidth', 1.5)
hold on
plot(wavelength, mean(X) - std(X), 'Color', [0.7 0.7 1], 'LineWidth', 1.2)
plot(wavelength, mean(X) + std(X), 'Color', [0.7 0.7 1], 'LineWidth', 1.2)
plot(wavelength, L(:, 1) + 0.3, 'r', 'LineWidth', 1.5)
plot(wavelength, L(:, 2) + 0.3, 'g', 'LineWidth', 1.5)
plot(wavelength, L(:, 3) + 0.3, 'b', 'LineWidth', 1.5)
legend('Mean Spectrum', 'Mean - Std', 'Mean + Std', 'PC1', 'PC2', 'PC3')
title('Mean Spectrum and First 3 Principal Components')
xlabel('Wavelength (nm)')
ylabel('Absorbance')
grid on

saveas(fig, 'Covariance_plot.png')

%% Scree plot and score plot
fig = figure('Position', [150, 150, 1200, 500]);
tiledlayout(1, 2, 'TileSpacing', 'compact', 'Padding', 'compact');

% Scree plot (variance explained)
nexttile
plot(1:10, sigma(1:10), 'o-b', 'LineWidth', 2, 'MarkerFaceColor', 'b')
xlabel('Principal Component Index')
ylabel('Variance Explained')
title('Scree Plot')
grid on

% Score plot (PC1 vs PC2)
nexttile
scatter(S(:, 1), S(:, 2), 40, 'filled')
xlabel('PC1 Score')
ylabel('PC2 Score')
title('Score Plot (PC1 vs PC2)')
grid on

saveas(fig, 'Score_and_Scree_plot.png')

%% Variation along principal components
Ns_selected = 9;
fig = figure();

% Choose tiled layout based on Ns_selected
if Ns_selected <= 4
    tiledlayout(2, 2, 'TileSpacing', 'compact', 'Padding', 'compact');
else
    N = ceil(sqrt(Ns_selected));
    tiledlayout(N, N, 'TileSpacing', 'compact', 'Padding', 'compact');
end

meanX = mean(X);
for idx = 1:Ns_selected
    nexttile;
    % Compute PC curve variations
    pc = L(:, idx) * sqrt(sigma(idx));
    y_plus = meanX + pc';
    y_minus = meanX - pc';
    
    plot(wavelength, meanX, 'k', 'LineWidth', 1.5)
    hold on
    plot(wavelength, y_plus, 'r', 'LineWidth', 1.2)
    plot(wavelength, y_minus, 'b', 'LineWidth', 1.2)
    hold off
    
    PC_label = sprintf('PC%d', idx);
    if idx == Ns_selected
        legend('Mean Spectrum', ['Mean + ' PC_label], ['Mean - ' PC_label])
    end
    
    xlabel('Wavelength (nm)')
    ylabel('Absorbance')
    title(['Variation Along ' PC_label])
    set(gca, 'FontSize', 7 + 5 / Ns_selected)
    grid on
end
saveas(fig, 'Variation_in_PC.png')

end