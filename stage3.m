function [L, U] = stage3(A)

% --------- Matlab Assignment 2019 ---------
% This function factorises a square real matrix A into it's LU components.
%
% Input variable:
% A     A square (nxn) matrix of real values.
%
% Output variables:
% L     A lower triangular matrix with ones across the diagonal.
% U     An upper triangular matrix, when multiplied to L, gives A.
%
% By Jaspreet Dhanjan
% The University of Huddersfield
% ------------------------------------------

% Check if matrix is empty.
if isempty(A)
    error('Matrix A cannot be empty.');
end

% Check if matrix contains real values.
if ~isreal(A)
    error('Matrix A must contain only real values.');
end

% Check if matrix is square.
if size(A) ~= size(A')
    error('Matrix A must be a square matrix.');
end

% Check if matrix is at least 2x2
if (size(A, 1) < 2) && (size(A, 2) < 2)
    error('Matrix A must be at least a 2x2 matrix.');
end

% The number of rows/cols we're dealing with.
n = size(A, 1);

% All lower matrices have a diagonal of ones.
L = eye(n);

% All upper matrices share the first row with A.
U = zeros(n);
for col = 1 : n
    U(1, col) = A(1, col);
end

% Iterate from the next row, we have pre-filled both L and U.
% We can do this in one pass through each element in the matrix for both
% LU.
for row = 2 : n
    for col = 1 : n
        % We compute the dot product for the prior and subsequent row
        % and column. This is rearranged (subtracting from A and divide
        % by the last diagonal value of U. 
        %
        % For example:
        % A(1, 1) = L(1, 1) * U(1, 1) + L(1, 2) * U(2, 1) + L(1, 3) *
        % U(3, 1). This can be generalised to:
        % A(1, 1) = 1 * a + 0 * 0 + 0 * 0 -> A(1, 1) - any constants (k) =
        % a.
        
        k = (A(row, col) - (L(row, 1:n ~= col) * U(1:n ~= col, col)));
        
        % If (row, col) is not on or over the diagonal, compute for Lower.
        if row ~= col && col < row
            L(row, col) = k / U(col, col);
            
        % If (row, col) is over the diagonal then compute for Upper.
        elseif col >= row
            U(row, col) = k;
        end
    end
end

end