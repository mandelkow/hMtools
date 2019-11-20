function y = hparen(x,varargin)
% paren = @(x, varargin) x(varargin{:});
% curly = @(x, varargin) x{varargin{:}};
% SEE: hsubp(), hsubc()
% http://blogs.mathworks.com/loren/2013/01/24/introduction-to-functional-programming-with-anonymous-functions-part-2/#db344cb8-ae1b-4b25-8071-af3883a49003

y = x(varargin{:});
