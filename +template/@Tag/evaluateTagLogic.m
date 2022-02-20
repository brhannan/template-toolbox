function val = evaluateTagLogic(obj)
%TAG.EVALUATETAGLOGIC 

if obj.isIfTag

end


%--------------------------------------------------------------------------
function val = evaluateIfTag(obj)

expectedFields = { 'Keyword', 'Obj1', 'Obj2', 'Operator' };

actFields = fieldnames(tagInfo);
for k = 1:numel(expectedFields)
    expFieldNow = expectedFields{k};
    doesInputHaveField = contains(expFieldNow,actFields);
    if ~doesInputHaveField
        error('Engine:getIfStatementResult:missingField', ...
            'Expected input tagInfo to contain field "%s."', expFieldNow);
    end
end

% IF statement may have the form
%   IF OBJ1
% or
%   IF OBJ1 OPER OBJ2
% Is this a smiple IF statement "IF X"? If so, OBJ2 has default value '-1'.
ifSimpleIfStatement = strcmp(tagInfo.Obj2, '-1');

if ifSimpleIfStatement
    val = ~~obj.getVariableValue(tagInfo.Obj1);
else
    val = eval(sprintf('%s %s %s', ...
        tagInfo.Obj1, tagInfo.Operator, tagInfo.Obj2));
end

end