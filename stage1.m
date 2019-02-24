function [x] = stage1(L, b)

% --------- Matlab Assignment 2019 ---------
% The function solves a system of linear equations in the form Lx=b.
%
% Input variables:
% L     The lower matrix (nxn) of coefficients.
% b     A column vector of constants.
%
% Output variable:
% x     A solution column vector, when multiplied to L, gives us b.
%
% By Jaspreet Dhanjan
% The University of Huddersfield
% ------------------------------------------

% Check if matrix is empty.
if isempty(L)
    error('Matrix L cannot be empty.');
end

% Check if matrix contains real values.
if ~isreal(L)
    error('Matrix L must contain only real values.');
end

% Check if matrix is square.
if size(L) ~= size(L')
    error('Matrix L must be a square matrix.');
end

% Check if matrix is at least 2x2
if (size(L, 1) < 2) && (size(L, 2) < 2)
    error('Matrix L must be at least a 2x2 matrix.');
end

% Check if matrix is triangular.
if ~istril(L)
    error('Matrix L must be lower triangular.');
end

% Check if our matrix is dimensionally compatible with b.
if size(L, 1) ~= size(b, 1)
    error('Matrix L must be dimensionally compatible with vector b.');
end

% The number of components we're dealing with.
n = length(b);

% Our result vector. Just preload with zeros.
x = zeros(n, 1);

% No computation needed. L(i, i) is always a one.
x(1) = b(1);

% For each row in the matrix.
for row = 2 : n
    terms = 0;
    
    % For each column within a row in the matrix before the diag.
    for col = 1 : row - 1
        
        % Collect the coeffecients/constant terms as we pass through.
        terms = terms + L(row, col) * x(col, 1);
    end
    
    % This is the rearrangement part, we just subtract terms.
    x(row, 1) = b(row, 1) - terms;
end
    
end