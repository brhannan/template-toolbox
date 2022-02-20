function tf = isLogicalVal(str)
%ISLOGICALVAL Check whether input string is a logical scalar value.
%   TF = TAG.ISLOGICALVAL(STR) returns true if STR is a character array 
%   or a string specifying a logical scalar.

validateattributes(str, {'char','string'}, {}, 'isLogicalVal', 'str')
tf = strcmpi(str,'true') || strcmpi(str,'false');

end