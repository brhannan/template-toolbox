function tf = isNumericVal(str)
%ISNUMERICVAL Check whether input contains a numeric value.
%   TF = TAG.ISNUMERICVAL(STR) returns true if STR is a character array
%   or string that specifies a numeric value.

validateattributes(str, {'char','string'}, {}, 'isNumericVal', 'str')
tf = ~isnan(str2double(str));

end