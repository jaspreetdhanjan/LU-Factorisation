function [x] = stage2(U, b)

% --------- Matlab Assignment 2019 ---------
% The function solves a system of linear equations in the form Ux=b.
%
% Input variables:
% U     The upper matrix (nxn) of coefficients.
% b     A column vector of constants.
%
% Output variable:
% x     A solution column vector, when multiplied to U, gives us b.
%
% By Jaspreet Dhanjan
% The University of Huddersfield
% ------------------------------------------

% Check if matrix is empty.
if isempty(U)
    error('Matrix U cannot be empty.');
end

% Check if matrix contains real values.
if ~isreal(U)
    error('Matrix U must contain only real values.');
end

% Check if matrix is square.
if size(U) ~= size(U')
    error('Matrix U must be a square matrix.');
end

% Check if matrix is at least 2x2
if (size(U, 1) < 2) && (size(U, 2) < 2)
    error('Matrix U must be at least a 2x2 matrix.');
end

% Check if matrix is triangular.
if ~istriu(U)
    error('Matrix U must be upper triangular.');
end

% Check if our matrix is dimensionally compatible with b.
if size(U, 1) ~= size(b, 1)
    error('Matrix L must be dimensionally compatible with vector b.');
end

% The number of components we're dealing with.
n = length(b);

% Our result vector. Just preload with zeros.
x = zeros(n, 1);

% Unlike stage1, an upper matrix can have diagonal values other than one.
x(n, 1) = b(n, 1) / U(n, n);

% For each row in the matrix, we do this in reverse order.
for row = (n - 1) : -1 : 1
    terms = 0;
    
    % For each column within a row in the matrix after the diag.
    for col = row + 1 : n
        
        % Collect the coeffecients/constant terms as we pass through.
        terms = terms + U(row, col) * x(col, 1);
    end
    
    % This is the rearrangement part, we just subtract terms and divide by
    % the diagonal element to get the value.
    x(row, 1) = (b(row, 1) - terms) / U(row, row);
end

end