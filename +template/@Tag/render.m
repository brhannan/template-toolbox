function render(obj, ctxt)
%RENDER Render output text for a tag.
%   TAG.RENDER(CTXT) renders output text from a Tag object using Context
%   object CTXT.

validateattributes(ctxt, {'template.Context'}, {})

% Parse contents of beginning {% ... %} to obtain tag metadata.
obj.parse();

if obj.isIf
    renderIfTag(obj, ctxt);
elseif obj.isFor
    renderForTag(obj, ctxt);
elseif obj.isComment
    renderCommentTag(obj);
else
    error('Tag:render:unrecognizedType', 'Unknown tag type.');
end

end


%--------------------------------------------------------------------------
function renderIfTag(obj, ctxt)

% Initialize output.
outputText = obj.Body;

% Does this IF statement evaluate to true?
didIfStatementEvaluateToTrue = obj.evaluateIfStatement(ctxt);

if didIfStatementEvaluateToTrue
    % TODO: create function for this (see below).
    vars = template.Tag.getVariableExpressions(obj.Body);
    % Evaluate each variable expression in the tag body.
    for nv = 1:numel(vars)
        varExpr = vars{nv};
        varVal = template.Tag.getVariableValue(varExpr, ctxt);
        outputText = regexprep(outputText, varExpr, varVal);
    end
else
    if obj.IsIfElse
        if strcmp(template.Tag.removeBraces(obj.TagControlTokens{2}),'else')
            % TODO: create function for this (see above).
            outputText = strtrim(obj.Parts{4});
            vars = template.Tag.getVariableExpressions(obj.Parts{4});
            for nv = 1:numel(vars)
                varExpr = vars{nv};
                varVal = template.Tag.getVariableValue(varExpr, ctxt);
                outputText = regexprep(outputText, varExpr, varVal);
            end
        end
    else
        % If the IF statement did not evaluate to true, output text is empty.
        outputText = '';
    end
end

obj.RenderedText = strtrim(outputText);

end


%--------------------------------------------------------------------------
function renderForTag(obj, ctxt)

% Initialize output.
outputText = '';

numericLB = obj.getVariableValue(obj.LoopLowerBound, ctxt);
numericUB = obj.getVariableValue(obj.LoopUpperBound, ctxt);
for k = numericLB:numericUB
    vars = obj.getVariableExpressions(obj.Body);
    templBodyStr = obj.Body;
    % Evaluate each variable expression in the tag body.
    for nv = 1:numel(vars)
        varExp = vars{nv};
        varNow = obj.removeBraces(varExp);
        % Get the value specified by the variable.
        varVal = obj.getVariableValue(varNow, ctxt, ...
            'LoopVariable', obj.LoopVariable, 'LoopVariableValue', k);
        % Replace variable expression by the value obtained above.
        % Get the template body result that was obtained from this 
        % iteration of the loop.
        if isnumeric(varVal)
            varVal = num2str(varVal);
        end
        templBodyStr = regexprep(templBodyStr, ...
            template.Tag.escapeSpecialCharacters(varExp), ...
            varVal);
    end
    % Append this expression to the output text. If there are no
    % variables in the template body, then the result is just the
    % unmodified body of the template.
    if numel(vars) == 0
        templBodyStr = obj.Body;
    end
    if isempty(outputText)
        % No newline is required if this is the first entry.
        outputText = strtrim(templBodyStr);
    else
        outputText = sprintf('%s\n%s', outputText, strtrim(templBodyStr));
    end
    
    obj.RenderedText = strtrim(outputText);
end

end


%--------------------------------------------------------------------------
function renderCommentTag(obj)

obj.RenderedText = '';

end