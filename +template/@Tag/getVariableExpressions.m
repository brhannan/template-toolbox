function vars = getVariableExpressions(str)
%GETVARIABLEEXPRESSIONS Get variable expressions from input.
%   VARS = TAG.GETVARIABLEEXPRESSIONS(STR) Returns the variable 
%   expressions, which are wrapped in double-curly-braces {{ ... }}, in 
%   input character array STR. VARS is a cell array of character arrays.

validateattributes(str, {'char'}, {})

% Get the indices of the start of each {{ and }}.
varStartIxs = regexp(str, template.Template.VarStartPat);
varStopIxs = regexp(str, template.Template.VarEndPat);

vars = cell(1, numel(varStartIxs));
for k = 1:numel(varStartIxs)
    vars{k} = str(varStartIxs(k):varStopIxs(k)+1);
end

end