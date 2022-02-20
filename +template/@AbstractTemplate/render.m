function render(obj, ctxt)
%RENDER Render a template.
%   TEMPLATE.RENDER identifies all tags in TemplateText. The tags are 
%   stored in the Tags property.

validateattributes(ctxt, {'template.Context'}, {})

% Make sure that TemplateText has been updated if FileName was updated.
if ~isempty(obj.FileName)
    obj.readFile();
end

obj.parse(ctxt);
obj.replaceTagsWithRenderedText();
replaceVariableExpressionsNotInTags(obj, ctxt);

end


%--------------------------------------------------------------------------
function replaceVariableExpressionsNotInTags(obj, ctxt)
% Variables may exist outside of tags. Identify remaining variable 
% expressions in the template and replace them if necessary.

vars = template.Tag.getVariableExpressions(obj.RenderedText);
for numVar = 1:numel(vars)
    varExpr = vars{numVar};
    varVal = template.Tag.getVariableValue(varExpr, ctxt);
    obj.RenderedText = regexprep(obj.RenderedText, varExpr, varVal);
end

end