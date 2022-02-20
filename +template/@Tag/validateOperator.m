function validateOperator(obj, operatorStr)
% Throws an error if character array OPERATORSTR is not a member of
% template.Template.ValidOperators.

validateattributes(operatorStr, {'char'}, {})
isOperatorValid = contains(operatorStr, obj.ValidOperators);
if ~isOperatorValid
    error('Tag:validateOperator:invalidOperator', ...
        ['Operator "%s" is in tag\n"%s"\ninvalid. Supported ', ...
        'operators are: %s.'], operatorStr, obj.TemplateText, ...
        strjoin(template.Template.ValidOperators, ', '));
end

end