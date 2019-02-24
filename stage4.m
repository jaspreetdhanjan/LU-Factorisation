function [x] = stage4(A, b)

% --------- Matlab Assignment 2019 ---------
% The function solves a system of linear equations in the form Ax=b.
%
% Input variables:
% A     A square (nxn) matrix of real values.
% b     A right-hand-side vector.
%
% Output variable:
% x     A solution column vector, when multiplied to A, gives us b.
%
% By Jaspreet Dhanjan
% The University of Huddersfield
% ------------------------------------------

% Get our L and U values.
[L, U] = stage3(A);

% The product of the diagonal entries of a triangular matrix produce the
% determinant. If this is zero we cannot calculate this.
if prod(diag(U)) == 0
    error('Matrix A is a singular matrix and cannot be inverted to find x.');
end

% Get our values for y using forward-substitution.
y = stage1(L, b);

% Then get our values with y using back-substitution.
x = stage2(U, y);

end