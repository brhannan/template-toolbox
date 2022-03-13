function tf = evaluateIfStatement(obj, ctxt)
% Returns the boolean result obtained from evaluating an IF statement 
% that exists in the beginning of a tag.

if ~obj.isIf
    error('Tag:evaluateIfStatement:invalidTagType', ...
        'Attempted to evaluate non-IF tag as an IF tag.');
end

% tf = eval(obj.ConditionalText);

vars = obj.getVariableExpressions(obj.ConditionalText);
bodyStr = obj.ConditionalText;
% Evaluate each variable expression in the tag body.
for nv = 1:numel(vars)
    varExp = vars{nv};
    varNow = obj.removeBraces(varExp);
    % Get the value specified by the variable.
    varVal = obj.getVariableValue(varNow, ctxt);
    % Replace variable expression by the value obtained above.
    if isnumeric(varVal) || islogical(varVal)
        varVal = num2str(varVal);
    end
    bodyStr = regexprep(bodyStr, ...
        template.Tag.escapeSpecialCharacters(varExp), ...
        varVal);
end

tf = ~~obj.getVariableValue(bodyStr, ctxt);

end