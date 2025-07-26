function [X, No, Nv, wavelength] = LOAD_DATA
% LOAD_DATA  Loads and normalizes spectral data from CSV files.
%
%   [X, No, Nv, wavelength] = LOAD_DATA
%
%   Outputs:
%       X         - Normalized data matrix (observations x variables)
%       No        - Number of observations (samples)
%       Nv        - Number of variables (wavelengths)
%       wavelength- Wavelength vector

% Load wavelength vector from the first file
tmp = load('1.CSV');
wavelength = tmp(:, 1);
clear tmp;

Nv = length(wavelength); % Number of variables (wavelengths)
No = 30;                 % Number of observations (samples)

% Initialize data matrix
X = zeros(No, Nv);

% Load all spectra
for i = 1:No
    tmp = load([num2str(i), '.CSV']);
    X(i, :) = tmp(:, 2);
end
clear tmp

% Normalize each spectrum to its maximum value
for i = 1:No
    X(i, :) = X(i, :) / max(X(i, :));
end

end
