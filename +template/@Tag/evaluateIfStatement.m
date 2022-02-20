function tf = evaluateIfStatement(obj, ctxt)
% Returns the boolean result obtained from evaluating an IF statement 
% that exists in the beginning of a tag.

if ~obj.isIf
    error('Tag:evaluateIfStatement:invalidTagType', ...
        'Attempted to evaluate non-IF tag as an IF tag.');
end

% IF statement may have the form
%   IF OBJ1
% or
%   IF OBJ1 OPER OBJ2
% Is this a smiple IF statement "IF X"? If so, OBJECT2 has default value 
% '-1'.
isSimpleIfStatement = strcmp(obj.Object2, '-1');

if isSimpleIfStatement
    tf = ~~obj.getVariableValue(obj.Object1, ctxt);
else
    tf = eval(sprintf('%s %s %s', ...
        obj.Object1, obj.Operator, obj.Object2));
end

end